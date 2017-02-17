
import argparse, struct, binascii, array, time

def get_formatted_inst_signals(names,ismaster=True,ntabs=1):
	if ismaster:
		f0 = 'm'
	else:
		f0 = 's'
	f1 = ''.join(['\t'for _ in range(ntabs)])

	lines = []
	for name in names:
		lines.extend([\
			f1+name+'_'+f0+'_axi_awid <= '+name+'_'+f0+'_axi_awid,\n',\
			f1+name+'_'+f0+'_axi_awaddr <= '+name+'_'+f0+'_axi_awaddr,\n',\
			f1+name+'_'+f0+'_axi_awlen <= '+name+'_'+f0+'_axi_awlen,\n',\
			f1+name+'_'+f0+'_axi_awsize <= '+name+'_'+f0+'_axi_awsize,\n',\
			f1+name+'_'+f0+'_axi_awburst <= '+name+'_'+f0+'_axi_awburst,\n',\
			f1+name+'_'+f0+'_axi_awlock <= '+name+'_'+f0+'_axi_awlock,\n',\
			f1+name+'_'+f0+'_axi_awcache <= '+name+'_'+f0+'_axi_awcache,\n',\
			f1+name+'_'+f0+'_axi_awprot <= '+name+'_'+f0+'_axi_awprot,\n',\
			f1+name+'_'+f0+'_axi_awqos <= '+name+'_'+f0+'_axi_awqos,\n',\
			f1+name+'_'+f0+'_axi_awregion <= '+name+'_'+f0+'_axi_awregion,\n',\
			f1+name+'_'+f0+'_axi_awvalid <= '+name+'_'+f0+'_axi_awvalid,\n',\
			f1+name+'_'+f0+'_axi_awready <= '+name+'_'+f0+'_axi_awready,\n',\
			f1+name+'_'+f0+'_axi_wdata <= '+name+'_'+f0+'_axi_wdata,\n',\
			f1+name+'_'+f0+'_axi_wstrb <= '+name+'_'+f0+'_axi_wstrb,\n',\
			f1+name+'_'+f0+'_axi_wlast <= '+name+'_'+f0+'_axi_wlast,\n',\
			f1+name+'_'+f0+'_axi_wvalid <= '+name+'_'+f0+'_axi_wvalid,\n',\
			f1+name+'_'+f0+'_axi_wready <= '+name+'_'+f0+'_axi_wready,\n',\
			f1+name+'_'+f0+'_axi_bid <= '+name+'_'+f0+'_axi_bid,\n',\
			f1+name+'_'+f0+'_axi_bresp <= '+name+'_'+f0+'_axi_bresp,\n',\
			f1+name+'_'+f0+'_axi_bvalid <= '+name+'_'+f0+'_axi_bvalid,\n',\
			f1+name+'_'+f0+'_axi_bready <= '+name+'_'+f0+'_axi_bready,\n',\
			f1+name+'_'+f0+'_axi_arid <= '+name+'_'+f0+'_axi_arid,\n',\
			f1+name+'_'+f0+'_axi_araddr <= '+name+'_'+f0+'_axi_araddr,\n',\
			f1+name+'_'+f0+'_axi_arlen <= '+name+'_'+f0+'_axi_arlen,\n',\
			f1+name+'_'+f0+'_axi_arsize <= '+name+'_'+f0+'_axi_arsize,\n',\
			f1+name+'_'+f0+'_axi_arburst <= '+name+'_'+f0+'_axi_arburst,\n',\
			f1+name+'_'+f0+'_axi_arlock <= '+name+'_'+f0+'_axi_arlock,\n',\
			f1+name+'_'+f0+'_axi_arcache <= '+name+'_'+f0+'_axi_arcache,\n',\
			f1+name+'_'+f0+'_axi_arprot <= '+name+'_'+f0+'_axi_arprot,\n',\
			f1+name+'_'+f0+'_axi_arqos <= '+name+'_'+f0+'_axi_arqos,\n',\
			f1+name+'_'+f0+'_axi_arregion <= '+name+'_'+f0+'_axi_arregion,\n',\
			f1+name+'_'+f0+'_axi_arvalid <= '+name+'_'+f0+'_axi_arvalid,\n',\
			f1+name+'_'+f0+'_axi_arready <= '+name+'_'+f0+'_axi_arready,\n',\
			f1+name+'_'+f0+'_axi_rid <= '+name+'_'+f0+'_axi_rid,\n',\
			f1+name+'_'+f0+'_axi_rdata <= '+name+'_'+f0+'_axi_rdata,\n',\
			f1+name+'_'+f0+'_axi_rresp <= '+name+'_'+f0+'_axi_rresp,\n',\
			f1+name+'_'+f0+'_axi_rlast <= '+name+'_'+f0+'_axi_rlast,\n',\
			f1+name+'_'+f0+'_axi_rvalid <= '+name+'_'+f0+'_axi_rvalid,\n',\
			f1+name+'_'+f0+'_axi_rready <= '+name+'_'+f0+'_axi_rready,\n'\
		])

	return ''.join(lines)

def get_formatted_assignments(slave_names,master_names):
	lines = \
		[\
			'\tm_axi_awid <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_awid' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_awaddr <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_awaddr' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_awlen <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_awlen' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_awsize <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_awsize' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_awburst <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_awburst' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_awlock <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_awlock' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_awcache <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_awcache' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_awprot <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_awprot' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_awqos <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_awqos' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_awregion <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_awregion' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_awvalid <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_awvalid' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_wdata <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_wdata' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_wstrb <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_wstrb' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_wlast <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_wlast' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_wvalid <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_wvalid' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_bready <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_bready' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_arid <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_arid' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_araddr <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_araddr' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_arlen <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_arlen' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_arsize <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_arsize' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_arburst <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_arburst' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_arlock <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_arlock' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_arcache <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_arcache' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_arprot <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_arprot' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_arqos <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_arqos' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_arregion <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_arregion' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_arvalid <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_arvalid' for master_name in master_names][::-1]),';\n',\
			'\tm_axi_rready <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+master_name+'_m_axi_rready' for master_name in master_names][::-1]),';\n',\
			'\ts_axi_awready <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+slave_name + '_s_axi_awready' for slave_name in slave_names][::-1]),';\n',\
			'\ts_axi_wready <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+slave_name + '_s_axi_wready' for slave_name in slave_names][::-1]),';\n',\
			'\ts_axi_bid <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+slave_name + '_s_axi_bid' for slave_name in slave_names][::-1]),';\n',\
			'\ts_axi_bresp <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+slave_name + '_s_axi_bresp' for slave_name in slave_names][::-1]),';\n',\
			'\ts_axi_bvalid <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+slave_name + '_s_axi_bvalid' for slave_name in slave_names][::-1]),';\n',\
			'\ts_axi_arready <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+slave_name + '_s_axi_arready' for slave_name in slave_names][::-1]),';\n',\
			'\ts_axi_rid <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+slave_name + '_s_axi_rid' for slave_name in slave_names][::-1]),';\n',\
			'\ts_axi_rdata <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+slave_name + '_s_axi_rdata' for slave_name in slave_names][::-1]),';\n',\
			'\ts_axi_rresp <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+slave_name + '_s_axi_rresp' for slave_name in slave_names][::-1]),';\n',\
			'\ts_axi_rlast <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+slave_name + '_s_axi_rlast' for slave_name in slave_names][::-1]),';\n',\
			'\ts_axi_rvalid <= std_logic_vector(to_unsigned(0,0))',''.join([' & '+slave_name + '_s_axi_rvalid' for slave_name in slave_names][::-1]),';\n',\
			''.join(['\t'+master_name+'_m_axi_awready <= m_axi_awready('+repr(index)+');\n'for (index,master_name) in enumerate(master_names)]),\
			''.join(['\t'+master_name+'_m_axi_wready <= m_axi_wready('+repr(index)+');\n'for (index,master_name) in enumerate(master_names)]),\
			''.join(['\t'+master_name+'_m_axi_bid <= m_axi_bid((1+'+repr(index)+')*axi_master_id_width-1 downto '+repr(index)+'*axi_master_id_width);\n'for (index,master_name) in enumerate(master_names)]),\
			''.join(['\t'+master_name+'_m_axi_bresp <= m_axi_bresp((1+'+repr(index)+')*2-1 downto '+repr(index)+'*2);\n'for (index,master_name) in enumerate(master_names)]),\
			''.join(['\t'+master_name+'_m_axi_bvalid <= m_axi_bvalid('+repr(index)+');\n'for (index,master_name) in enumerate(master_names)]),\
			''.join(['\t'+master_name+'_m_axi_arready <= m_axi_arready('+repr(index)+');\n'for (index,master_name) in enumerate(master_names)]),\
			''.join(['\t'+master_name+'_m_axi_rid <= m_axi_rid((1+'+repr(index)+')*axi_master_id_width-1 downto '+repr(index)+'*axi_master_id_width);\n'for (index,master_name) in enumerate(master_names)]),\
			''.join(['\t'+master_name+'_m_axi_rdata <= m_axi_rdata((1+'+repr(index)+')*axi_data_width-1 downto '+repr(index)+'*axi_data_width);\n'for (index,master_name) in enumerate(master_names)]),\
			''.join(['\t'+master_name+'_m_axi_rresp <= m_axi_rresp((1+'+repr(index)+')*2-1 downto '+repr(index)+'*2);\n'for (index,master_name) in enumerate(master_names)]),\
			''.join(['\t'+master_name+'_m_axi_rlast <= m_axi_rlast('+repr(index)+');\n'for (index,master_name) in enumerate(master_names)]),\
			''.join(['\t'+master_name+'_m_axi_rvalid <= m_axi_rvalid('+repr(index)+');\n'for (index,master_name) in enumerate(master_names)]),\
			''.join(['\t'+slave_name+'_s_axi_awid <= s_axi_awid((1+'+repr(index)+')*axi_slave_id_width-1 downto '+repr(index)+'*axi_slave_id_width);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_awaddr <= s_axi_awaddr((1+'+repr(index)+')*axi_address_width-1 downto '+repr(index)+'*axi_address_width);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_awlen <= s_axi_awlen((1+'+repr(index)+')*8-1 downto '+repr(index)+'*8);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_awsize <= s_axi_awsize((1+'+repr(index)+')*3-1 downto '+repr(index)+'*3);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_awburst <= s_axi_awburst((1+'+repr(index)+')*2-1 downto '+repr(index)+'*2);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_awlock <= s_axi_awlock('+repr(index)+');\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_awcache <= s_axi_awcache((1+'+repr(index)+')*4-1 downto '+repr(index)+'*4);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_awprot <= s_axi_awprot((1+'+repr(index)+')*3-1 downto '+repr(index)+'*3);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_awqos <= s_axi_awqos((1+'+repr(index)+')*4-1 downto '+repr(index)+'*4);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_awregion <= s_axi_awregion((1+'+repr(index)+')*4-1 downto '+repr(index)+'*4);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_awvalid <= s_axi_awvalid('+repr(index)+');\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_wdata <= s_axi_wdata((1+'+repr(index)+')*axi_data_width-1 downto '+repr(index)+'*axi_data_width);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_wstrb <= s_axi_wstrb((1+'+repr(index)+')*axi_data_width/8-1 downto '+repr(index)+'*axi_data_width/8);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_wlast <= s_axi_wlast('+repr(index)+');\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_wvalid <= s_axi_wvalid('+repr(index)+');\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_bready <= s_axi_bready('+repr(index)+');\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_arid <= s_axi_arid((1+'+repr(index)+')*axi_slave_id_width-1 downto '+repr(index)+'*axi_slave_id_width);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_araddr <= s_axi_araddr((1+'+repr(index)+')*axi_address_width-1 downto '+repr(index)+'*axi_address_width);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_arlen <= s_axi_arlen((1+'+repr(index)+')*8-1 downto '+repr(index)+'*8);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_arsize <= s_axi_arsize((1+'+repr(index)+')*3-1 downto '+repr(index)+'*3);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_arburst <= s_axi_arburst((1+'+repr(index)+')*2-1 downto '+repr(index)+'*2);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_arlock <= s_axi_arlock('+repr(index)+');\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_arcache <= s_axi_arcache((1+'+repr(index)+')*4-1 downto '+repr(index)+'*4);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_arprot <= s_axi_arprot((1+'+repr(index)+')*3-1 downto '+repr(index)+'*3);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_arqos <= s_axi_arqos((1+'+repr(index)+')*4-1 downto '+repr(index)+'*4);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_arregion <= s_axi_arregion((1+'+repr(index)+')*4-1 downto '+repr(index)+'*4);\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_arvalid <= s_axi_arvalid('+repr(index)+');\n'for (index,slave_name) in enumerate(slave_names)]),\
			''.join(['\t'+slave_name+'_s_axi_rready <= s_axi_rready('+repr(index)+');\n'for (index,slave_name) in enumerate(slave_names)])\
		]
	lines2 = []
	lines2.extend(lines)
	return ''.join(lines2)

def get_formatted_cross_inst():
	lines = \
		[\
			'\tplasoc_crossbar_inst : plasoc_crossbar\n',\
			'\t\tgeneric map\n',\
			'\t\t(\n',\
			'\t\t\taxi_address_width  => axi_address_width,\n'
			'\t\t\taxi_data_width  => axi_data_width,\n'
			'\t\t\taxi_master_amount  => axi_master_amount,\n'
			'\t\t\taxi_master_id_width  => axi_master_id_width,\n'
			'\t\t\taxi_slave_amount  => axi_slave_amount,\n'
			'\t\t\taxi_slave_base_address  => axi_slave_base_address,\n'
			'\t\t\taxi_slave_high_address  => axi_slave_high_address\n'
			'\t\t)\n',\
			'\t\tport map\n',\
			'\t\t(\n',\
			'\t\t\taclk => aclk,\n',\
			'\t\t\taresetn => aresetn,\n',\
			'\t\t\tm_axi_awid => m_axi_awid,\n',\
			'\t\t\tm_axi_awaddr => m_axi_awaddr,\n',\
			'\t\t\tm_axi_awlen => m_axi_awlen,\n',\
			'\t\t\tm_axi_awsize => m_axi_awsize,\n',\
			'\t\t\tm_axi_awburst => m_axi_awburst,\n',\
			'\t\t\tm_axi_awlock => m_axi_awlock,\n',\
			'\t\t\tm_axi_awcache => m_axi_awcache,\n',\
			'\t\t\tm_axi_awprot => m_axi_awprot,\n',\
			'\t\t\tm_axi_awqos => m_axi_awqos,\n',\
			'\t\t\tm_axi_awregion => m_axi_awregion,\n',\
			'\t\t\tm_axi_awvalid => m_axi_awvalid,\n',\
			'\t\t\tm_axi_awready => m_axi_awready,\n',\
			'\t\t\tm_axi_wdata => m_axi_wdata,\n',\
			'\t\t\tm_axi_wstrb => m_axi_wstrb,\n',\
			'\t\t\tm_axi_wlast => m_axi_wlast,\n',\
			'\t\t\tm_axi_wvalid => m_axi_wvalid,\n',\
			'\t\t\tm_axi_wready => m_axi_wready,\n',\
			'\t\t\tm_axi_bid => m_axi_bid,\n',\
			'\t\t\tm_axi_bresp => m_axi_bresp,\n',\
			'\t\t\tm_axi_bvalid => m_axi_bvalid,\n',\
			'\t\t\tm_axi_bready => m_axi_bready,\n',\
			'\t\t\tm_axi_arid => m_axi_arid,\n',\
			'\t\t\tm_axi_araddr => m_axi_araddr,\n',\
			'\t\t\tm_axi_arlen => m_axi_arlen,\n',\
			'\t\t\tm_axi_arsize => m_axi_arsize,\n',\
			'\t\t\tm_axi_arburst => m_axi_arburst,\n',\
			'\t\t\tm_axi_arlock => m_axi_arlock,\n',\
			'\t\t\tm_axi_arcache => m_axi_arcache,\n',\
			'\t\t\tm_axi_arprot => m_axi_arprot,\n',\
			'\t\t\tm_axi_arqos => m_axi_arqos,\n',\
			'\t\t\tm_axi_arregion => m_axi_arregion,\n',\
			'\t\t\tm_axi_arvalid => m_axi_arvalid,\n',\
			'\t\t\tm_axi_arready => m_axi_arready,\n',\
			'\t\t\tm_axi_rid => m_axi_rid,\n',\
			'\t\t\tm_axi_rdata => m_axi_rdata,\n',\
			'\t\t\tm_axi_rresp => m_axi_rresp,\n',\
			'\t\t\tm_axi_rlast => m_axi_rlast,\n',\
			'\t\t\tm_axi_rvalid => m_axi_rvalid,\n',\
			'\t\t\tm_axi_rready => m_axi_rready,\n',\
			'\t\t\ts_axi_awid => s_axi_awid,\n',\
			'\t\t\ts_axi_awaddr => s_axi_awaddr,\n',\
			'\t\t\ts_axi_awlen => s_axi_awlen,\n',\
			'\t\t\ts_axi_awsize => s_axi_awsize,\n',\
			'\t\t\ts_axi_awburst => s_axi_awburst,\n',\
			'\t\t\ts_axi_awlock => s_axi_awlock,\n',\
			'\t\t\ts_axi_awcache => s_axi_awcache,\n',\
			'\t\t\ts_axi_awprot => s_axi_awprot,\n',\
			'\t\t\ts_axi_awqos => s_axi_awqos,\n',\
			'\t\t\ts_axi_awregion => s_axi_awregion,\n',\
			'\t\t\ts_axi_awvalid => s_axi_awvalid,\n',\
			'\t\t\ts_axi_awready => s_axi_awready,\n',\
			'\t\t\ts_axi_wdata => s_axi_wdata,\n',\
			'\t\t\ts_axi_wstrb => s_axi_wstrb,\n',\
			'\t\t\ts_axi_wlast => s_axi_wlast,\n',\
			'\t\t\ts_axi_wvalid => s_axi_wvalid,\n',\
			'\t\t\ts_axi_wready => s_axi_wready,\n',\
			'\t\t\ts_axi_bid => s_axi_bid,\n',\
			'\t\t\ts_axi_bresp => s_axi_bresp,\n',\
			'\t\t\ts_axi_bvalid => s_axi_bvalid,\n',\
			'\t\t\ts_axi_bready => s_axi_bready,\n',\
			'\t\t\ts_axi_arid => s_axi_arid,\n',\
			'\t\t\ts_axi_araddr => s_axi_araddr,\n',\
			'\t\t\ts_axi_arlen => s_axi_arlen,\n',\
			'\t\t\ts_axi_arsize => s_axi_arsize,\n',\
			'\t\t\ts_axi_arburst => s_axi_arburst,\n',\
			'\t\t\ts_axi_arlock => s_axi_arlock,\n',\
			'\t\t\ts_axi_arcache => s_axi_arcache,\n',\
			'\t\t\ts_axi_arprot => s_axi_arprot,\n',\
			'\t\t\ts_axi_arqos => s_axi_arqos,\n',\
			'\t\t\ts_axi_arregion => s_axi_arregion,\n',\
			'\t\t\ts_axi_arvalid => s_axi_arvalid,\n',\
			'\t\t\ts_axi_arready => s_axi_arready,\n',\
			'\t\t\ts_axi_rid => s_axi_rid,\n',\
			'\t\t\ts_axi_rdata => s_axi_rdata,\n',\
			'\t\t\ts_axi_rresp => s_axi_rresp,\n',\
			'\t\t\ts_axi_rlast => s_axi_rlast,\n',\
			'\t\t\ts_axi_rvalid => s_axi_rvalid,\n',\
			'\t\t\ts_axi_rready => s_axi_rready\n',\
			'\t);\n'
		]
	return ''.join(lines)

def get_formatted_cross_signals():
	lines = \
	[\
		'\tconstant axi_slave_id_width : integer := clogb2(axi_master_amount+1)+axi_master_id_width;\n',\
		'\tsignal m_axi_awid : std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);\n',\
		'\tsignal m_axi_awaddr : std_logic_vector(axi_master_amount*axi_address_width-1 downto 0);\n',\
		'\tsignal m_axi_awlen : std_logic_vector(axi_master_amount*8-1 downto 0);\n',\
		'\tsignal m_axi_awsize : std_logic_vector(axi_master_amount*3-1 downto 0);\n',\
		'\tsignal m_axi_awburst : std_logic_vector(axi_master_amount*2-1 downto 0);\n',\
		'\tsignal m_axi_awlock : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_awcache : std_logic_vector(axi_master_amount*4-1 downto 0);\n',\
		'\tsignal m_axi_awprot : std_logic_vector(axi_master_amount*3-1 downto 0);\n',\
		'\tsignal m_axi_awqos : std_logic_vector(axi_master_amount*4-1 downto 0);\n',\
		'\tsignal m_axi_awregion : std_logic_vector(axi_master_amount*4-1 downto 0);\n',\
		'\tsignal m_axi_awvalid : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_awready : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_wdata : std_logic_vector(axi_master_amount*axi_data_width-1 downto 0);\n',\
		'\tsignal m_axi_wstrb : std_logic_vector(axi_master_amount*axi_data_width/8-1 downto 0);\n',\
		'\tsignal m_axi_wlast : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_wvalid : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_wready : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_bid : std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);\n',\
		'\tsignal m_axi_bresp : std_logic_vector(axi_master_amount*2-1 downto 0);\n',\
		'\tsignal m_axi_bvalid : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_bready : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_arid : std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);\n',\
		'\tsignal m_axi_araddr : std_logic_vector(axi_master_amount*axi_address_width-1 downto 0);\n',\
		'\tsignal m_axi_arlen : std_logic_vector(axi_master_amount*8-1 downto 0);\n',\
		'\tsignal m_axi_arsize : std_logic_vector(axi_master_amount*3-1 downto 0);\n',\
		'\tsignal m_axi_arburst : std_logic_vector(axi_master_amount*2-1 downto 0);\n',\
		'\tsignal m_axi_arlock : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_arcache : std_logic_vector(axi_master_amount*4-1 downto 0);\n',\
		'\tsignal m_axi_arprot : std_logic_vector(axi_master_amount*3-1 downto 0);\n',\
		'\tsignal m_axi_arqos : std_logic_vector(axi_master_amount*4-1 downto 0);\n',\
		'\tsignal m_axi_arregion : std_logic_vector(axi_master_amount*4-1 downto 0);\n',\
		'\tsignal m_axi_arvalid : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_arready : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_rid : std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);\n',\
		'\tsignal m_axi_rdata : std_logic_vector(axi_master_amount*axi_data_width-1 downto 0);\n',\
		'\tsignal m_axi_rresp : std_logic_vector(axi_master_amount*2-1 downto 0);\n',\
		'\tsignal m_axi_rlast : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_rvalid : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal m_axi_rready : std_logic_vector(axi_master_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_awid : std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);\n',\
		'\tsignal s_axi_awaddr : std_logic_vector(axi_slave_amount*axi_address_width-1 downto 0);\n',\
		'\tsignal s_axi_awlen : std_logic_vector(axi_slave_amount*8-1 downto 0);\n',\
		'\tsignal s_axi_awsize : std_logic_vector(axi_slave_amount*3-1 downto 0);\n',\
		'\tsignal s_axi_awburst : std_logic_vector(axi_slave_amount*2-1 downto 0);\n',\
		'\tsignal s_axi_awlock : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_awcache : std_logic_vector(axi_slave_amount*4-1 downto 0);\n',\
		'\tsignal s_axi_awprot : std_logic_vector(axi_slave_amount*3-1 downto 0);\n',\
		'\tsignal s_axi_awqos : std_logic_vector(axi_slave_amount*4-1 downto 0);\n',\
		'\tsignal s_axi_awregion : std_logic_vector(axi_slave_amount*4-1 downto 0);\n',\
		'\tsignal s_axi_awvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_awready : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_wdata : std_logic_vector(axi_slave_amount*axi_data_width-1 downto 0);\n',\
		'\tsignal s_axi_wstrb : std_logic_vector(axi_slave_amount*axi_data_width/8-1 downto 0);\n',\
		'\tsignal s_axi_wlast : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_wvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_wready : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_bid : std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);\n',\
		'\tsignal s_axi_bresp : std_logic_vector(axi_slave_amount*2-1 downto 0);\n',\
		'\tsignal s_axi_bvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_bready : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_arid : std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);\n',\
		'\tsignal s_axi_araddr : std_logic_vector(axi_slave_amount*axi_address_width-1 downto 0);\n',\
		'\tsignal s_axi_arlen : std_logic_vector(axi_slave_amount*8-1 downto 0);\n',\
		'\tsignal s_axi_arsize : std_logic_vector(axi_slave_amount*3-1 downto 0);\n',\
		'\tsignal s_axi_arburst : std_logic_vector(axi_slave_amount*2-1 downto 0);\n',\
		'\tsignal s_axi_arlock : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_arcache : std_logic_vector(axi_slave_amount*4-1 downto 0);\n',\
		'\tsignal s_axi_arprot : std_logic_vector(axi_slave_amount*3-1 downto 0);\n',\
		'\tsignal s_axi_arqos : std_logic_vector(axi_slave_amount*4-1 downto 0);\n',\
		'\tsignal s_axi_arregion : std_logic_vector(axi_slave_amount*4-1 downto 0);\n',\
		'\tsignal s_axi_arvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_arready : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_rid : std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);\n',\
		'\tsignal s_axi_rdata : std_logic_vector(axi_slave_amount*axi_data_width-1 downto 0);\n',\
		'\tsignal s_axi_rresp : std_logic_vector(axi_slave_amount*2-1 downto 0);\n',\
		'\tsignal s_axi_rlast : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_rvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);\n',\
		'\tsignal s_axi_rready : std_logic_vector(axi_slave_amount*1-1 downto 0);\n'\
	]
	return ''.join(lines)

def get_formatted_wrapper_signals(names,ismaster=True,ntabs=1):
	if ismaster:
		f0 = '_m_'
		f1 = ' in '
		f2 = ' out '
		f3 = 'axi_master_id_width'
	else:
		f0 = '_s_'
		f1 = ' out '
		f2 = ' in '
		f3 = '(clogb2(axi_master_amount+1)+axi_master_id_width)'
	f4 = ''.join(['\t'for _ in range(ntabs)])
	formatted_signals = []
	for name in names:
		lines = \
		[\
			f4+name+f0+'axi_awid : '+f1+' std_logic_vector('+f3+'-1 downto 0);\n',\
			f4+name+f0+'axi_awaddr : '+f1+' std_logic_vector(axi_address_width-1 downto 0);\n',\
			f4+name+f0+'axi_awlen : '+f1+' std_logic_vector(7 downto 0);\n',\
			f4+name+f0+'axi_awsize : '+f1+' std_logic_vector(2 downto 0);\n',\
			f4+name+f0+'axi_awburst : '+f1+' std_logic_vector(1 downto 0);\n',\
			f4+name+f0+'axi_awlock : '+f1+' std_logic;\n',\
			f4+name+f0+'axi_awcache : '+f1+' std_logic_vector(3 downto 0);\n',\
			f4+name+f0+'axi_awprot : '+f1+' std_logic_vector(2 downto 0);\n',\
			f4+name+f0+'axi_awqos : '+f1+' std_logic_vector(3 downto 0);\n',\
			f4+name+f0+'axi_awregion : '+f1+' std_logic_vector(3 downto 0);\n',\
			f4+name+f0+'axi_awvalid : '+f1+' std_logic;\n',\
			f4+name+f0+'axi_awready : '+f2+' std_logic;\n',\
			f4+name+f0+'axi_wdata : '+f1+' std_logic_vector(axi_data_width-1 downto 0);\n',\
			f4+name+f0+'axi_wstrb : '+f1+' std_logic_vector(axi_data_width/8-1 downto 0);\n',\
			f4+name+f0+'axi_wlast : '+f1+' std_logic;\n',\
			f4+name+f0+'axi_wvalid : '+f1+' std_logic;\n',\
			f4+name+f0+'axi_wready : '+f2+' std_logic;\n',\
			f4+name+f0+'axi_bid : '+f2+' std_logic_vector('+f3+'-1 downto 0);\n',\
			f4+name+f0+'axi_bresp : '+f2+' std_logic_vector(1 downto 0);\n',\
			f4+name+f0+'axi_bvalid : '+f2+' std_logic;\n',\
			f4+name+f0+'axi_bready : '+f1+' std_logic;\n',\
			f4+name+f0+'axi_arid : '+f1+' std_logic_vector('+f3+'-1 downto 0);\n',\
			f4+name+f0+'axi_araddr : '+f1+' std_logic_vector(axi_address_width-1 downto 0);\n',\
			f4+name+f0+'axi_arlen : '+f1+' std_logic_vector(7 downto 0);\n',\
			f4+name+f0+'axi_arsize : '+f1+' std_logic_vector(2 downto 0);\n',\
			f4+name+f0+'axi_arburst : '+f1+' std_logic_vector(1 downto 0);\n',\
			f4+name+f0+'axi_arlock : '+f1+' std_logic;\n',\
			f4+name+f0+'axi_arcache : '+f1+' std_logic_vector(3 downto 0);\n',\
			f4+name+f0+'axi_arprot : '+f1+' std_logic_vector(2 downto 0);\n',\
			f4+name+f0+'axi_arqos : '+f1+' std_logic_vector(3 downto 0);\n',\
			f4+name+f0+'axi_arregion : '+f1+' std_logic_vector(3 downto 0);\n',\
			f4+name+f0+'axi_arvalid : '+f1+' std_logic;\n',\
			f4+name+f0+'axi_arready : '+f2+' std_logic;\n',\
			f4+name+f0+'axi_rid : '+f2+' std_logic_vector('+f3+'-1 downto 0);\n',\
			f4+name+f0+'axi_rdata : '+f2+' std_logic_vector(axi_data_width-1 downto 0);\n',\
			f4+name+f0+'axi_rresp : '+f2+' std_logic_vector(1 downto 0);\n',\
			f4+name+f0+'axi_rlast : '+f2+' std_logic;\n',\
			f4+name+f0+'axi_rvalid : '+f2+' std_logic;\n',\
			f4+name+f0+'axi_rready : '+f1+' std_logic;\n'\
		]
		formatted_signals.extend(lines)
	return ''.join(formatted_signals)

if __name__ == '__main__':

	STRING_PLASMA_SOC_PREFIX = 'plasoc_'
	STRING_CROSSBAR_ENTITY_SUFFIX = '_crossbar_wrap'
	STRING_PACKAGES = \
		'library ieee;\n'+\
		'use ieee.std_logic_1164.all;\n'+\
		'use ieee.std_logic_unsigned.all;\n'+\
		'use ieee.numeric_std.all;\n'

	# Create the parser.
	parser = argparse.ArgumentParser(description='Generate the crossbar wrapper ')
	parser.add_argument('--verbose',dest='verbose',action='store_const',
		const=True,default=False,
		help='Enables verbose output')
	parser.add_argument('--generate_instant',dest='generate_instant',action='store_const',
		const=True,default=False,
		help='Generates entity instantiation file.')
	parser.add_argument('--master_count',metavar='master_count',type=int,nargs=1,default=[1],
		help='Specifies the number of master interfaces.')
	parser.add_argument('--slave_count',metavar='slave_count',type=int,nargs=1,default=[1],
		help='Specifies the number of slave interfaces.')
	parser.add_argument('--address_width',metavar='address_width',type=int,nargs=1,default=[32],
		help='Specifies the master address width.')
	parser.add_argument('--data_width',metavar='data_width',type=int,nargs=1,default=[32],
		help='Specifies the data width.')
	parser.add_argument('--master_id_width',metavar='master_id_width',type=int,nargs=1,default=[0],
		help='Specifies the width of each master id.');
	parser.add_argument('--cross_name',metavar='cross_name',type=str,nargs=1,default=['0'],
		help='Specifies the name of the crossbar. The name of the corresponding package and entity is based on cross_name.')
	parser.add_argument('--master_names',metavar='master_names',type=str,nargs='*',default=['0'],
		help='Specifies the names of each master interface. Order should match other master-related parameters.');
	parser.add_argument('--slave_names',metavar='slave_names',type=str,nargs='*',default=['0'],
		help='Specifies the names of each slave interface. Order should match other slave-related parameters.');
	parser.add_argument('--slave_base_addresses',metavar='slave_base_addresses',type=str,nargs='*',default=['0'],
		help='Specifies the base addresses for each slave interface in hexadecimal. Order should match other slave-related parameters.');
	parser.add_argument('--slave_high_addresses',metavar='slave_high_addresses',type=str,nargs='*',default=['0'],
		help='Specifies the high addresses for each slave interface in hexadecimal. Order should match other slave-related parameters.');
		
	# Perform the parsing.
	args = parser.parse_args()
	verbose_flag = args.verbose
	generate_instant_flag = args.generate_instant
	master_count = args.master_count[0]
	slave_count = args.slave_count[0]
	address_width = args.address_width[0]
	data_width = args.data_width[0]
	master_id_width = args.master_id_width[0]
	cross_name = args.cross_name[0]
	master_names = args.master_names
	slave_names = args.slave_names
	slave_base_addresses = args.slave_base_addresses
	slave_high_addresses = args.slave_high_addresses
	
	# Display parameters.
	if verbose_flag:
		print('generate_instant_flag: ' + repr(generate_instant_flag))
		print('master_count: ' + repr(master_count))
		print('slave_count: ' + repr(slave_count))
		print('address_width: ' + repr(address_width))
		print('data_width: ' + repr(data_width))
		print('master_id_width: ' + repr(master_id_width))
		print('cross_name: ' + cross_name)
		print('master_names: ' + repr(master_names))
		print('slave_names: ' + repr(slave_names))
		print('slave_base_addresses: ' + repr(slave_base_addresses))
		print('slave_high_addresses: ' + repr(slave_high_addresses))
		print('')
		
	# Generate full names.
	entity_full_name = STRING_PLASMA_SOC_PREFIX+cross_name+STRING_CROSSBAR_ENTITY_SUFFIX
	package_full_name = entity_full_name+'_pack'
	
	# Generate generic string.
	generic_full = \
		'\tgeneric\n'+\
		'\t(\n'+\
		'\t\taxi_address_width : integer := '+repr(address_width)+';\n'+\
		'\t\taxi_data_width : integer := '+repr(data_width)+';\n'+\
		'\t\taxi_master_id_width : integer := '+repr(master_id_width)+';\n'+\
		'\t\taxi_master_amount : integer := '+repr(master_count)+';\n'+\
		'\t\taxi_slave_amount : integer := '+repr(slave_count)+';\n'+\
		'\t\taxi_slave_base_address : std_logic_vector := X"'+''.join(slave_base_addresses[::-1])+'";\n'+\
		'\t\taxi_slave_high_address : std_logic_vector := X"'+''.join(slave_high_addresses[::-1])+'"\n'+\
		'\t);\n'
	
	# Generate port string.
	port_full = \
		'\tport\n'+\
		'\t(\n'+\
		get_formatted_wrapper_signals(master_names,ismaster=True,ntabs=2)+\
		get_formatted_wrapper_signals(slave_names,ismaster=False,ntabs=2)+\
		'\t\taclk : in std_logic;\n'+\
		'\t\taresetn : in std_logic\n'+\
		'\t);\n'
		
	# Generate package string.
	package_string = STRING_PACKAGES+'\npackage '+package_full_name+' is\n\n'+\
		'function clogb2(bit_depth : in integer ) return integer;\n\n'+\
		'component '+entity_full_name+' is\n\n'+\
		generic_full+port_full+\
		'end component;\n\n'+\
		'end;\n\n'+\
		'package body '+package_full_name+' is\n\n'+\
		'	function clogb2(bit_depth : in natural ) return integer is\n'+\
		'		variable result : integer := 0;\n'+\
		'		variable bit_depth_buff : integer := bit_depth;\n'+\
		'	begin\n'+\
		'		while bit_depth_buff>1 loop\n'+\
		'			bit_depth_buff := bit_depth_buff/2;\n'+\
		'			result := result+1;\n'+\
		'		end loop; \n'+\
		'		return result;\n'+\
		'	end;\n'+\
		'end;\n'

	# Generate entity string.
	entity_string = STRING_PACKAGES+'use work.plasoc_crossbar_pack.plasoc_crossbar;\n'+'use work.'+package_full_name+'.all;\n\n'+\
		'entity '+entity_full_name+' is\n'+\
		generic_full+port_full+\
		'end '+entity_full_name+';\n\n'+\
		'architecture Behavioral of '+entity_full_name+' is\n'+\
		get_formatted_cross_signals()+\
		'begin\n'+\
		get_formatted_assignments(slave_names,master_names)+\
		get_formatted_cross_inst()+\
		'end Behavioral;\n'

	# Generate instantiation string.
	instant_string = \
		entity_full_name+'_inst : '+entity_full_name+'\n'+\
		'\tgeneric map\n'+\
		'\t(\n'+\
		'\t\taxi_address_width => axi_address_width,\n'+\
		'\t\taxi_data_width => axi_data_width,\n'+\
		'\t\taxi_master_id_width => axi_master_id_width,\n'+\
		'\t\taxi_master_amount => axi_master_amount,\n'+\
		'\t\taxi_slave_amount => axi_slave_amount,\n'+\
		'\t\taxi_slave_base_address => axi_slave_base_address,\n'+\
		'\t\taxi_slave_high_address => axi_slave_high_address\n'+\
		'\t)\n'+\
		'\tport map\n'+\
		'\t(\n'+\
		get_formatted_inst_signals(master_names,ismaster=True,ntabs=2)+\
		get_formatted_inst_signals(slave_names,ismaster=False,ntabs=2)+\
		'\t\taclk => aclk,\n'+\
		'\t\taresetn => aresetn\n'+\
		'\t);\n'
		
		
	# View the files
	if verbose_flag:
		print(package_string)
		print(entity_string)
		print(instant_string)
		
	# Save the VHDL files.
	with open(package_full_name+'.vhd',mode='w') as package_file: package_file.write(package_string)
	with open(entity_full_name+'.vhd',mode='w') as entity_file: entity_file.write(entity_string)
	if generate_instant_flag: 
		with open(entity_full_name+'.instant',mode='w') as instant_file: instant_file.write(instant_string)
		
	
	
