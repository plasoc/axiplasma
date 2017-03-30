MISC_DIR = ../../../misc
CROSSGEN = python2 $(MISC_DIR)/gencross.py

crossbar_wrapper:
	$(CROSSGEN) \
		--slave_count 2 --master_count 8 \
		--address_width 32 --data_width 32 --slave_id_width 0 \
		--slave_names cpu cdma --master_names bram ram int timer gpio cdma uart timer_extra_0 \
		--master_base_addresses 00000000 01000000 44a00000 44a10000 44a20000 44a30000 44a40000 44a50000 \
		--master_high_addresses 0000ffff 0103ffff 44a0ffff 44a1ffff 44a2ffff 44a3ffff 44a4ffff 44a5ffff

all: crossbar_wrapper
