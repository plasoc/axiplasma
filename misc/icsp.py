import argparse, struct, binascii, array, time, serial

def send_word(serial_obj,bytes_per_word,word):
	for each_byte in range(bytes_per_word):
		byte = bytearray([word&255])
		serial_obj.write(byte)
		word = word>>8

if __name__ == '__main__':

	# Create the parser.
	parser = argparse.ArgumentParser(description='Load an application to the Plasma-SoC with in-circuit serial programming.')

	# Create argument for getting file name.
	parser.add_argument('binary_name',metavar='binary_name',type=str,nargs=1,
		help='File name of input binary. The extension should be included.')
	parser.add_argument('--verbose',dest='verbose',action='store_const',
		const=True,default=False,
		help='Enables verbose output')
	parser.add_argument('--serial_port',metavar='serial_port',type=str,nargs=1,default=['/dev/ttyUSB1'],
		help='Specifies the serial port.')
	parser.add_argument('--serial_baud',metavar='serial_baud',type=int,nargs=1,default=[9600],
		help='Specifies the baudrate of the serial connection.')

	# Perform the parsing.
	args = parser.parse_args()
	verbose_flag = args.verbose
	binary_name =  args.binary_name[0]
	serial_port = args.serial_port[0]
	serial_baud = args.serial_baud[0]

	if verbose_flag:
		print('Binary name: '+binary_name)
		print('Serial port: '+serial_port)
		print('Serial baud: '+repr(serial_baud))

	# Constants from the bootloader.
	BOOT_LOADER_START_WORD = int('f0f0f0f0',16)
	BOOT_LOADER_ACK_SUCCESS_BYTE = bytearray([int('01',16)])
	BOOT_LOADER_ACK_FAILURE_BYTE = bytearray([int('02',16)])
	BOOT_LOADER_STATUS_MORE	= bytearray([int('01',16)])
	BOOT_LOADER_STATUS_DONE	= bytearray([int('02',16)])
	BOOT_LOADER_CHECKSUM_DIVISOR = 230

	if verbose_flag: print('Reading binary...')
	
	if verbose_flag: print('Setting up serial...')
	serial_obj = serial.Serial()
	serial_obj.port = serial_port
	serial_obj.baudrate = serial_baud
	serial_obj.bytesize = serial.EIGHTBITS
	serial_obj.parity = serial.PARITY_NONE
	serial_obj.stopbits = serial.STOPBITS_ONE
	serial_obj.timeout = None
	with open(binary_name,mode='rb') as binary_file, serial_obj as serial_obj:

		bytes_per_word = 4
		binary_content = binary_file.read()
		words_in_binary = len(binary_content)/bytes_per_word

		if verbose_flag: print('Sending start word...')		

		send_word(serial_obj,bytes_per_word,BOOT_LOADER_START_WORD)
		status = array.array('B',serial_obj.read())[0]
		print("Status: {}".format(status))
		assert(status==BOOT_LOADER_ACK_SUCCESS_BYTE[0])

		if verbose_flag: print('Writing the data...')	

		for each_word in range(words_in_binary):

			word_packed = binary_content[each_word*bytes_per_word:(each_word+1)*bytes_per_word]
            		word_int = struct.unpack('I',word_packed)
			word_array = array.array('I',word_int)
		        word_array.byteswap()
		        word_int = word_array[0]
			send_word(serial_obj,bytes_per_word,word_int)

			checksum_byte = bytearray([word_int%BOOT_LOADER_CHECKSUM_DIVISOR])
			serial_obj.write(checksum_byte)

			if each_word==words_in_binary-1:
				serial_obj.write(BOOT_LOADER_STATUS_DONE)
			else:
				serial_obj.write(BOOT_LOADER_STATUS_MORE)
			
			status = array.array('B',serial_obj.read())[0]
			assert(status==BOOT_LOADER_ACK_SUCCESS_BYTE[0])

			if verbose_flag:
				print('Word index: ' + repr(each_word))
				print('Word sent: ' + ("%0.8X" % word_int))
				print('Checksum: ' + ("%0.2X" % checksum_byte[0]))
				
	
