# Andrew Powell
#
# This script is necessary to convert the binary into a format acceptable by Xilinx to load into their BRAM.

import argparse, struct, binascii, array, time

if __name__ == '__main__':
    
    # Create the parser.
    parser = argparse.ArgumentParser(description='Convert binary to a coe files.')
    
    # Create argument for getting file name.
    parser.add_argument('binary_name',metavar='binary_name',type=str,nargs=1,
                    help='File name of input binary. The extension should be included.')
    parser.add_argument('coe_name',metavar='coe_name',type=str,nargs=1,
                    help='File name of output coe. The extension should be included.')
    parser.add_argument('--swap_bytes',dest='swap_bytes',action='store_const',
                    const=True,default=False,
                    help='Swaps the bytes in each word')
    parser.add_argument('--word_count',metavar='word_count',type=int,nargs=1,
                    help='Numbers of words to store in coef from the binary.')
    
    # Perform the parsing.
    args = parser.parse_args()
    binary_name = args.binary_name[0]
    coe_name = args.coe_name[0]
    swap_bytes_flag = args.swap_bytes
    try: word_count_value = args.word_count[0]
    except TypeError: word_count_value = -1
    
#     # Print the file names.
#     print('Binary name: ' + binary_name)
#     print('Coe name: ' + coe_name)
#     print('Swap: ' + repr(swap_bytes_flag))
#     print('Word Count: ' + repr(word_count_value))
    
    # Perform the conversion.
    bytes_per_word = 4
    radix = 16
    # First open binary for reading and the coe file for writing.
    with open(binary_name,mode='rb') as binary_file, open(coe_name,mode='w') as coe_file:
        # Insert the necessary headers into the coe files.
        coe_file.write('memory_initialization_radix='+repr(radix)+';\n')
        coe_file.write('memory_initialization_vector=\n')
        # Acquire the binary file and determine the number of words in the file.
        binary_content = binary_file.read()
        words_in_binary = len(binary_content)/bytes_per_word
        # If a word count is specified, update if the new word count is valid.
        if word_count_value>=0 and word_count_value<words_in_binary:
            words_in_binary = word_count_value
        # Perform the following operations for each word in the binary.
        for each_word in range(words_in_binary):
            # Acquire the word and convert it to an integer.
            word_packed = binary_content[each_word*bytes_per_word:(each_word+1)*bytes_per_word]
            word_int = struct.unpack('I',word_packed)
            # If specified by command, swap the bytes in the word.
            if swap_bytes_flag:
                word_array = array.array('I',word_int)
                word_array.byteswap()
                word_int = word_array[0]
            # Convert the word into the necessary string hex format.
            word_hex = "%0.8X" % word_int
            # Write the word to the coe file.
            coe_file.write(word_hex)
            if each_word != words_in_binary-1: coe_file.write(',\n')
            else: coe_file.write(';\n')
