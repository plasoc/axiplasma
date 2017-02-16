library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.plasoc_crossbar_pack.plasoc_crossbar;
use work.plasoc_0_crossbar_wrap_pack.all;

entity plasoc_0_crossbar_wrap is
	generic
	(
		axi_address_width : integer := 32;
		axi_data_width : integer := 32;
		axi_master_id_width : integer := 0;
		axi_master_amount : integer := 2;
		axi_slave_amount : integer := 5;
		axi_slave_base_address : std_logic_vector := X"44a3000044a2000044a1000044a0000000000000";
		axi_slave_high_address : std_logic_vector := X"44a3ffff44a2ffff44a1ffff44a0ffff0000ffff"
	);
	port
	(
		cpu_m_axi_awid :  in  std_logic_vector(axi_master_id_width-1 downto 0);
		cpu_m_axi_awaddr :  in  std_logic_vector(axi_address_width-1 downto 0);
		cpu_m_axi_awlen :  in  std_logic_vector(7 downto 0);
		cpu_m_axi_awsize :  in  std_logic_vector(2 downto 0);
		cpu_m_axi_awburst :  in  std_logic_vector(1 downto 0);
		cpu_m_axi_awlock :  in  std_logic;
		cpu_m_axi_awcache :  in  std_logic_vector(3 downto 0);
		cpu_m_axi_awprot :  in  std_logic_vector(2 downto 0);
		cpu_m_axi_awqos :  in  std_logic_vector(3 downto 0);
		cpu_m_axi_awregion :  in  std_logic_vector(3 downto 0);
		cpu_m_axi_awvalid :  in  std_logic;
		cpu_m_axi_awready :  out  std_logic;
		cpu_m_axi_wdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		cpu_m_axi_wstrb :  in  std_logic_vector(axi_data_width/8-1 downto 0);
		cpu_m_axi_wlast :  in  std_logic;
		cpu_m_axi_wvalid :  in  std_logic;
		cpu_m_axi_wready :  out  std_logic;
		cpu_m_axi_bid :  out  std_logic_vector(axi_master_id_width-1 downto 0);
		cpu_m_axi_bresp :  out  std_logic_vector(1 downto 0);
		cpu_m_axi_bvalid :  out  std_logic;
		cpu_m_axi_bready :  in  std_logic;
		cpu_m_axi_arid :  in  std_logic_vector(axi_master_id_width-1 downto 0);
		cpu_m_axi_araddr :  in  std_logic_vector(axi_address_width-1 downto 0);
		cpu_m_axi_arlen :  in  std_logic_vector(7 downto 0);
		cpu_m_axi_arsize :  in  std_logic_vector(2 downto 0);
		cpu_m_axi_arburst :  in  std_logic_vector(1 downto 0);
		cpu_m_axi_arlock :  in  std_logic;
		cpu_m_axi_arcache :  in  std_logic_vector(3 downto 0);
		cpu_m_axi_arprot :  in  std_logic_vector(2 downto 0);
		cpu_m_axi_arqos :  in  std_logic_vector(3 downto 0);
		cpu_m_axi_arregion :  in  std_logic_vector(3 downto 0);
		cpu_m_axi_arvalid :  in  std_logic;
		cpu_m_axi_arready :  out  std_logic;
		cpu_m_axi_rid :  out  std_logic_vector(axi_master_id_width-1 downto 0);
		cpu_m_axi_rdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		cpu_m_axi_rresp :  out  std_logic_vector(1 downto 0);
		cpu_m_axi_rlast :  out  std_logic;
		cpu_m_axi_rvalid :  out  std_logic;
		cpu_m_axi_rready :  in  std_logic;
		cdma_m_axi_awid :  in  std_logic_vector(axi_master_id_width-1 downto 0);
		cdma_m_axi_awaddr :  in  std_logic_vector(axi_address_width-1 downto 0);
		cdma_m_axi_awlen :  in  std_logic_vector(7 downto 0);
		cdma_m_axi_awsize :  in  std_logic_vector(2 downto 0);
		cdma_m_axi_awburst :  in  std_logic_vector(1 downto 0);
		cdma_m_axi_awlock :  in  std_logic;
		cdma_m_axi_awcache :  in  std_logic_vector(3 downto 0);
		cdma_m_axi_awprot :  in  std_logic_vector(2 downto 0);
		cdma_m_axi_awqos :  in  std_logic_vector(3 downto 0);
		cdma_m_axi_awregion :  in  std_logic_vector(3 downto 0);
		cdma_m_axi_awvalid :  in  std_logic;
		cdma_m_axi_awready :  out  std_logic;
		cdma_m_axi_wdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		cdma_m_axi_wstrb :  in  std_logic_vector(axi_data_width/8-1 downto 0);
		cdma_m_axi_wlast :  in  std_logic;
		cdma_m_axi_wvalid :  in  std_logic;
		cdma_m_axi_wready :  out  std_logic;
		cdma_m_axi_bid :  out  std_logic_vector(axi_master_id_width-1 downto 0);
		cdma_m_axi_bresp :  out  std_logic_vector(1 downto 0);
		cdma_m_axi_bvalid :  out  std_logic;
		cdma_m_axi_bready :  in  std_logic;
		cdma_m_axi_arid :  in  std_logic_vector(axi_master_id_width-1 downto 0);
		cdma_m_axi_araddr :  in  std_logic_vector(axi_address_width-1 downto 0);
		cdma_m_axi_arlen :  in  std_logic_vector(7 downto 0);
		cdma_m_axi_arsize :  in  std_logic_vector(2 downto 0);
		cdma_m_axi_arburst :  in  std_logic_vector(1 downto 0);
		cdma_m_axi_arlock :  in  std_logic;
		cdma_m_axi_arcache :  in  std_logic_vector(3 downto 0);
		cdma_m_axi_arprot :  in  std_logic_vector(2 downto 0);
		cdma_m_axi_arqos :  in  std_logic_vector(3 downto 0);
		cdma_m_axi_arregion :  in  std_logic_vector(3 downto 0);
		cdma_m_axi_arvalid :  in  std_logic;
		cdma_m_axi_arready :  out  std_logic;
		cdma_m_axi_rid :  out  std_logic_vector(axi_master_id_width-1 downto 0);
		cdma_m_axi_rdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		cdma_m_axi_rresp :  out  std_logic_vector(1 downto 0);
		cdma_m_axi_rlast :  out  std_logic;
		cdma_m_axi_rvalid :  out  std_logic;
		cdma_m_axi_rready :  in  std_logic;
		ram_s_axi_awid :  out  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		ram_s_axi_awaddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		ram_s_axi_awlen :  out  std_logic_vector(7 downto 0);
		ram_s_axi_awsize :  out  std_logic_vector(2 downto 0);
		ram_s_axi_awburst :  out  std_logic_vector(1 downto 0);
		ram_s_axi_awlock :  out  std_logic;
		ram_s_axi_awcache :  out  std_logic_vector(3 downto 0);
		ram_s_axi_awprot :  out  std_logic_vector(2 downto 0);
		ram_s_axi_awqos :  out  std_logic_vector(3 downto 0);
		ram_s_axi_awregion :  out  std_logic_vector(3 downto 0);
		ram_s_axi_awvalid :  out  std_logic;
		ram_s_axi_awready :  in  std_logic;
		ram_s_axi_wdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		ram_s_axi_wstrb :  out  std_logic_vector(axi_data_width/8-1 downto 0);
		ram_s_axi_wlast :  out  std_logic;
		ram_s_axi_wvalid :  out  std_logic;
		ram_s_axi_wready :  in  std_logic;
		ram_s_axi_bid :  in  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		ram_s_axi_bresp :  in  std_logic_vector(1 downto 0);
		ram_s_axi_bvalid :  in  std_logic;
		ram_s_axi_bready :  out  std_logic;
		ram_s_axi_arid :  out  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		ram_s_axi_araddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		ram_s_axi_arlen :  out  std_logic_vector(7 downto 0);
		ram_s_axi_arsize :  out  std_logic_vector(2 downto 0);
		ram_s_axi_arburst :  out  std_logic_vector(1 downto 0);
		ram_s_axi_arlock :  out  std_logic;
		ram_s_axi_arcache :  out  std_logic_vector(3 downto 0);
		ram_s_axi_arprot :  out  std_logic_vector(2 downto 0);
		ram_s_axi_arqos :  out  std_logic_vector(3 downto 0);
		ram_s_axi_arregion :  out  std_logic_vector(3 downto 0);
		ram_s_axi_arvalid :  out  std_logic;
		ram_s_axi_arready :  in  std_logic;
		ram_s_axi_rid :  in  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		ram_s_axi_rdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		ram_s_axi_rresp :  in  std_logic_vector(1 downto 0);
		ram_s_axi_rlast :  in  std_logic;
		ram_s_axi_rvalid :  in  std_logic;
		ram_s_axi_rready :  out  std_logic;
		int_s_axi_awid :  out  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		int_s_axi_awaddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		int_s_axi_awlen :  out  std_logic_vector(7 downto 0);
		int_s_axi_awsize :  out  std_logic_vector(2 downto 0);
		int_s_axi_awburst :  out  std_logic_vector(1 downto 0);
		int_s_axi_awlock :  out  std_logic;
		int_s_axi_awcache :  out  std_logic_vector(3 downto 0);
		int_s_axi_awprot :  out  std_logic_vector(2 downto 0);
		int_s_axi_awqos :  out  std_logic_vector(3 downto 0);
		int_s_axi_awregion :  out  std_logic_vector(3 downto 0);
		int_s_axi_awvalid :  out  std_logic;
		int_s_axi_awready :  in  std_logic;
		int_s_axi_wdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		int_s_axi_wstrb :  out  std_logic_vector(axi_data_width/8-1 downto 0);
		int_s_axi_wlast :  out  std_logic;
		int_s_axi_wvalid :  out  std_logic;
		int_s_axi_wready :  in  std_logic;
		int_s_axi_bid :  in  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		int_s_axi_bresp :  in  std_logic_vector(1 downto 0);
		int_s_axi_bvalid :  in  std_logic;
		int_s_axi_bready :  out  std_logic;
		int_s_axi_arid :  out  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		int_s_axi_araddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		int_s_axi_arlen :  out  std_logic_vector(7 downto 0);
		int_s_axi_arsize :  out  std_logic_vector(2 downto 0);
		int_s_axi_arburst :  out  std_logic_vector(1 downto 0);
		int_s_axi_arlock :  out  std_logic;
		int_s_axi_arcache :  out  std_logic_vector(3 downto 0);
		int_s_axi_arprot :  out  std_logic_vector(2 downto 0);
		int_s_axi_arqos :  out  std_logic_vector(3 downto 0);
		int_s_axi_arregion :  out  std_logic_vector(3 downto 0);
		int_s_axi_arvalid :  out  std_logic;
		int_s_axi_arready :  in  std_logic;
		int_s_axi_rid :  in  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		int_s_axi_rdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		int_s_axi_rresp :  in  std_logic_vector(1 downto 0);
		int_s_axi_rlast :  in  std_logic;
		int_s_axi_rvalid :  in  std_logic;
		int_s_axi_rready :  out  std_logic;
		timer_s_axi_awid :  out  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		timer_s_axi_awaddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		timer_s_axi_awlen :  out  std_logic_vector(7 downto 0);
		timer_s_axi_awsize :  out  std_logic_vector(2 downto 0);
		timer_s_axi_awburst :  out  std_logic_vector(1 downto 0);
		timer_s_axi_awlock :  out  std_logic;
		timer_s_axi_awcache :  out  std_logic_vector(3 downto 0);
		timer_s_axi_awprot :  out  std_logic_vector(2 downto 0);
		timer_s_axi_awqos :  out  std_logic_vector(3 downto 0);
		timer_s_axi_awregion :  out  std_logic_vector(3 downto 0);
		timer_s_axi_awvalid :  out  std_logic;
		timer_s_axi_awready :  in  std_logic;
		timer_s_axi_wdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		timer_s_axi_wstrb :  out  std_logic_vector(axi_data_width/8-1 downto 0);
		timer_s_axi_wlast :  out  std_logic;
		timer_s_axi_wvalid :  out  std_logic;
		timer_s_axi_wready :  in  std_logic;
		timer_s_axi_bid :  in  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		timer_s_axi_bresp :  in  std_logic_vector(1 downto 0);
		timer_s_axi_bvalid :  in  std_logic;
		timer_s_axi_bready :  out  std_logic;
		timer_s_axi_arid :  out  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		timer_s_axi_araddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		timer_s_axi_arlen :  out  std_logic_vector(7 downto 0);
		timer_s_axi_arsize :  out  std_logic_vector(2 downto 0);
		timer_s_axi_arburst :  out  std_logic_vector(1 downto 0);
		timer_s_axi_arlock :  out  std_logic;
		timer_s_axi_arcache :  out  std_logic_vector(3 downto 0);
		timer_s_axi_arprot :  out  std_logic_vector(2 downto 0);
		timer_s_axi_arqos :  out  std_logic_vector(3 downto 0);
		timer_s_axi_arregion :  out  std_logic_vector(3 downto 0);
		timer_s_axi_arvalid :  out  std_logic;
		timer_s_axi_arready :  in  std_logic;
		timer_s_axi_rid :  in  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		timer_s_axi_rdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		timer_s_axi_rresp :  in  std_logic_vector(1 downto 0);
		timer_s_axi_rlast :  in  std_logic;
		timer_s_axi_rvalid :  in  std_logic;
		timer_s_axi_rready :  out  std_logic;
		gpio_s_axi_awid :  out  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		gpio_s_axi_awaddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		gpio_s_axi_awlen :  out  std_logic_vector(7 downto 0);
		gpio_s_axi_awsize :  out  std_logic_vector(2 downto 0);
		gpio_s_axi_awburst :  out  std_logic_vector(1 downto 0);
		gpio_s_axi_awlock :  out  std_logic;
		gpio_s_axi_awcache :  out  std_logic_vector(3 downto 0);
		gpio_s_axi_awprot :  out  std_logic_vector(2 downto 0);
		gpio_s_axi_awqos :  out  std_logic_vector(3 downto 0);
		gpio_s_axi_awregion :  out  std_logic_vector(3 downto 0);
		gpio_s_axi_awvalid :  out  std_logic;
		gpio_s_axi_awready :  in  std_logic;
		gpio_s_axi_wdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		gpio_s_axi_wstrb :  out  std_logic_vector(axi_data_width/8-1 downto 0);
		gpio_s_axi_wlast :  out  std_logic;
		gpio_s_axi_wvalid :  out  std_logic;
		gpio_s_axi_wready :  in  std_logic;
		gpio_s_axi_bid :  in  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		gpio_s_axi_bresp :  in  std_logic_vector(1 downto 0);
		gpio_s_axi_bvalid :  in  std_logic;
		gpio_s_axi_bready :  out  std_logic;
		gpio_s_axi_arid :  out  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		gpio_s_axi_araddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		gpio_s_axi_arlen :  out  std_logic_vector(7 downto 0);
		gpio_s_axi_arsize :  out  std_logic_vector(2 downto 0);
		gpio_s_axi_arburst :  out  std_logic_vector(1 downto 0);
		gpio_s_axi_arlock :  out  std_logic;
		gpio_s_axi_arcache :  out  std_logic_vector(3 downto 0);
		gpio_s_axi_arprot :  out  std_logic_vector(2 downto 0);
		gpio_s_axi_arqos :  out  std_logic_vector(3 downto 0);
		gpio_s_axi_arregion :  out  std_logic_vector(3 downto 0);
		gpio_s_axi_arvalid :  out  std_logic;
		gpio_s_axi_arready :  in  std_logic;
		gpio_s_axi_rid :  in  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		gpio_s_axi_rdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		gpio_s_axi_rresp :  in  std_logic_vector(1 downto 0);
		gpio_s_axi_rlast :  in  std_logic;
		gpio_s_axi_rvalid :  in  std_logic;
		gpio_s_axi_rready :  out  std_logic;
		cdma_s_axi_awid :  out  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		cdma_s_axi_awaddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		cdma_s_axi_awlen :  out  std_logic_vector(7 downto 0);
		cdma_s_axi_awsize :  out  std_logic_vector(2 downto 0);
		cdma_s_axi_awburst :  out  std_logic_vector(1 downto 0);
		cdma_s_axi_awlock :  out  std_logic;
		cdma_s_axi_awcache :  out  std_logic_vector(3 downto 0);
		cdma_s_axi_awprot :  out  std_logic_vector(2 downto 0);
		cdma_s_axi_awqos :  out  std_logic_vector(3 downto 0);
		cdma_s_axi_awregion :  out  std_logic_vector(3 downto 0);
		cdma_s_axi_awvalid :  out  std_logic;
		cdma_s_axi_awready :  in  std_logic;
		cdma_s_axi_wdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		cdma_s_axi_wstrb :  out  std_logic_vector(axi_data_width/8-1 downto 0);
		cdma_s_axi_wlast :  out  std_logic;
		cdma_s_axi_wvalid :  out  std_logic;
		cdma_s_axi_wready :  in  std_logic;
		cdma_s_axi_bid :  in  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		cdma_s_axi_bresp :  in  std_logic_vector(1 downto 0);
		cdma_s_axi_bvalid :  in  std_logic;
		cdma_s_axi_bready :  out  std_logic;
		cdma_s_axi_arid :  out  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		cdma_s_axi_araddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		cdma_s_axi_arlen :  out  std_logic_vector(7 downto 0);
		cdma_s_axi_arsize :  out  std_logic_vector(2 downto 0);
		cdma_s_axi_arburst :  out  std_logic_vector(1 downto 0);
		cdma_s_axi_arlock :  out  std_logic;
		cdma_s_axi_arcache :  out  std_logic_vector(3 downto 0);
		cdma_s_axi_arprot :  out  std_logic_vector(2 downto 0);
		cdma_s_axi_arqos :  out  std_logic_vector(3 downto 0);
		cdma_s_axi_arregion :  out  std_logic_vector(3 downto 0);
		cdma_s_axi_arvalid :  out  std_logic;
		cdma_s_axi_arready :  in  std_logic;
		cdma_s_axi_rid :  in  std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
		cdma_s_axi_rdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		cdma_s_axi_rresp :  in  std_logic_vector(1 downto 0);
		cdma_s_axi_rlast :  in  std_logic;
		cdma_s_axi_rvalid :  in  std_logic;
		cdma_s_axi_rready :  out  std_logic;
		aclk : in std_logic;
		aresetn : in std_logic
	);
end plasoc_0_crossbar_wrap;

architecture Behavioral of plasoc_0_crossbar_wrap is
	signal m_axi_awid : std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);
	signal m_axi_awaddr : std_logic_vector(axi_master_amount*axi_address_width-1 downto 0);
	signal m_axi_awlen : std_logic_vector(axi_master_amount*8-1 downto 0);
	signal m_axi_awsize : std_logic_vector(axi_master_amount*3-1 downto 0);
	signal m_axi_awburst : std_logic_vector(axi_master_amount*2-1 downto 0);
	signal m_axi_awlock : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_awcache : std_logic_vector(axi_master_amount*4-1 downto 0);
	signal m_axi_awprot : std_logic_vector(axi_master_amount*3-1 downto 0);
	signal m_axi_awqos : std_logic_vector(axi_master_amount*4-1 downto 0);
	signal m_axi_awregion : std_logic_vector(axi_master_amount*4-1 downto 0);
	signal m_axi_awvalid : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_awready : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_wdata : std_logic_vector(axi_master_amount*axi_data_width-1 downto 0);
	signal m_axi_wstrb : std_logic_vector(axi_master_amount*axi_data_width/8-1 downto 0);
	signal m_axi_wlast : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_wvalid : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_wready : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_bid : std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);
	signal m_axi_bresp : std_logic_vector(axi_master_amount*2-1 downto 0);
	signal m_axi_bvalid : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_bready : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_arid : std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);
	signal m_axi_araddr : std_logic_vector(axi_master_amount*axi_address_width-1 downto 0);
	signal m_axi_arlen : std_logic_vector(axi_master_amount*8-1 downto 0);
	signal m_axi_arsize : std_logic_vector(axi_master_amount*3-1 downto 0);
	signal m_axi_arburst : std_logic_vector(axi_master_amount*2-1 downto 0);
	signal m_axi_arlock : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_arcache : std_logic_vector(axi_master_amount*4-1 downto 0);
	signal m_axi_arprot : std_logic_vector(axi_master_amount*3-1 downto 0);
	signal m_axi_arqos : std_logic_vector(axi_master_amount*4-1 downto 0);
	signal m_axi_arregion : std_logic_vector(axi_master_amount*4-1 downto 0);
	signal m_axi_arvalid : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_arready : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_rid : std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);
	signal m_axi_rdata : std_logic_vector(axi_master_amount*axi_data_width-1 downto 0);
	signal m_axi_rresp : std_logic_vector(axi_master_amount*2-1 downto 0);
	signal m_axi_rlast : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_rvalid : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_rready : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal s_axi_awid : std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
	signal s_axi_awaddr : std_logic_vector(axi_slave_amount*axi_address_width-1 downto 0);
	signal s_axi_awlen : std_logic_vector(axi_slave_amount*8-1 downto 0);
	signal s_axi_awsize : std_logic_vector(axi_slave_amount*3-1 downto 0);
	signal s_axi_awburst : std_logic_vector(axi_slave_amount*2-1 downto 0);
	signal s_axi_awlock : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_awcache : std_logic_vector(axi_slave_amount*4-1 downto 0);
	signal s_axi_awprot : std_logic_vector(axi_slave_amount*3-1 downto 0);
	signal s_axi_awqos : std_logic_vector(axi_slave_amount*4-1 downto 0);
	signal s_axi_awregion : std_logic_vector(axi_slave_amount*4-1 downto 0);
	signal s_axi_awvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_awready : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_wdata : std_logic_vector(axi_slave_amount*axi_data_width-1 downto 0);
	signal s_axi_wstrb : std_logic_vector(axi_slave_amount*axi_data_width/8-1 downto 0);
	signal s_axi_wlast : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_wvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_wready : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_bid : std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
	signal s_axi_bresp : std_logic_vector(axi_slave_amount*2-1 downto 0);
	signal s_axi_bvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_bready : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_arid : std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
	signal s_axi_araddr : std_logic_vector(axi_slave_amount*axi_address_width-1 downto 0);
	signal s_axi_arlen : std_logic_vector(axi_slave_amount*8-1 downto 0);
	signal s_axi_arsize : std_logic_vector(axi_slave_amount*3-1 downto 0);
	signal s_axi_arburst : std_logic_vector(axi_slave_amount*2-1 downto 0);
	signal s_axi_arlock : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_arcache : std_logic_vector(axi_slave_amount*4-1 downto 0);
	signal s_axi_arprot : std_logic_vector(axi_slave_amount*3-1 downto 0);
	signal s_axi_arqos : std_logic_vector(axi_slave_amount*4-1 downto 0);
	signal s_axi_arregion : std_logic_vector(axi_slave_amount*4-1 downto 0);
	signal s_axi_arvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_arready : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_rid : std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
	signal s_axi_rdata : std_logic_vector(axi_slave_amount*axi_data_width-1 downto 0);
	signal s_axi_rresp : std_logic_vector(axi_slave_amount*2-1 downto 0);
	signal s_axi_rlast : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_rvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_rready : std_logic_vector(axi_slave_amount*1-1 downto 0);
begin
	m_axi_awid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awid & cpu_m_axi_awid;
	m_axi_awaddr <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awaddr & cpu_m_axi_awaddr;
	m_axi_awlen <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awlen & cpu_m_axi_awlen;
	m_axi_awsize <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awsize & cpu_m_axi_awsize;
	m_axi_awburst <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awburst & cpu_m_axi_awburst;
	m_axi_awlock <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awlock & cpu_m_axi_awlock;
	m_axi_awcache <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awcache & cpu_m_axi_awcache;
	m_axi_awprot <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awprot & cpu_m_axi_awprot;
	m_axi_awqos <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awqos & cpu_m_axi_awqos;
	m_axi_awregion <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awregion & cpu_m_axi_awregion;
	m_axi_awvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awvalid & cpu_m_axi_awvalid;
	m_axi_awready <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awready & cpu_m_axi_awready;
	m_axi_wdata <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_wdata & cpu_m_axi_wdata;
	m_axi_wstrb <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_wstrb & cpu_m_axi_wstrb;
	m_axi_wlast <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_wlast & cpu_m_axi_wlast;
	m_axi_wvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_wvalid & cpu_m_axi_wvalid;
	m_axi_wready <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_wready & cpu_m_axi_wready;
	m_axi_bid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_bid & cpu_m_axi_bid;
	m_axi_bresp <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_bresp & cpu_m_axi_bresp;
	m_axi_bvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_bvalid & cpu_m_axi_bvalid;
	m_axi_bready <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_bready & cpu_m_axi_bready;
	m_axi_arid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arid & cpu_m_axi_arid;
	m_axi_araddr <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_araddr & cpu_m_axi_araddr;
	m_axi_arlen <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arlen & cpu_m_axi_arlen;
	m_axi_arsize <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arsize & cpu_m_axi_arsize;
	m_axi_arburst <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arburst & cpu_m_axi_arburst;
	m_axi_arlock <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arlock & cpu_m_axi_arlock;
	m_axi_arcache <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arcache & cpu_m_axi_arcache;
	m_axi_arprot <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arprot & cpu_m_axi_arprot;
	m_axi_arqos <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arqos & cpu_m_axi_arqos;
	m_axi_arregion <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arregion & cpu_m_axi_arregion;
	m_axi_arvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arvalid & cpu_m_axi_arvalid;
	m_axi_arready <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arready & cpu_m_axi_arready;
	m_axi_rid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_rid & cpu_m_axi_rid;
	m_axi_rdata <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_rdata & cpu_m_axi_rdata;
	m_axi_rresp <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_rresp & cpu_m_axi_rresp;
	m_axi_rlast <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_rlast & cpu_m_axi_rlast;
	m_axi_rvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_rvalid & cpu_m_axi_rvalid;
	m_axi_rready <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_rready & cpu_m_axi_rready;
	s_axi_awid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awid & gpio_s_axi_awid & timer_s_axi_awid & int_s_axi_awid & ram_s_axi_awid;
	s_axi_awaddr <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awaddr & gpio_s_axi_awaddr & timer_s_axi_awaddr & int_s_axi_awaddr & ram_s_axi_awaddr;
	s_axi_awlen <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awlen & gpio_s_axi_awlen & timer_s_axi_awlen & int_s_axi_awlen & ram_s_axi_awlen;
	s_axi_awsize <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awsize & gpio_s_axi_awsize & timer_s_axi_awsize & int_s_axi_awsize & ram_s_axi_awsize;
	s_axi_awburst <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awburst & gpio_s_axi_awburst & timer_s_axi_awburst & int_s_axi_awburst & ram_s_axi_awburst;
	s_axi_awlock <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awlock & gpio_s_axi_awlock & timer_s_axi_awlock & int_s_axi_awlock & ram_s_axi_awlock;
	s_axi_awcache <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awcache & gpio_s_axi_awcache & timer_s_axi_awcache & int_s_axi_awcache & ram_s_axi_awcache;
	s_axi_awprot <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awprot & gpio_s_axi_awprot & timer_s_axi_awprot & int_s_axi_awprot & ram_s_axi_awprot;
	s_axi_awqos <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awqos & gpio_s_axi_awqos & timer_s_axi_awqos & int_s_axi_awqos & ram_s_axi_awqos;
	s_axi_awregion <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awregion & gpio_s_axi_awregion & timer_s_axi_awregion & int_s_axi_awregion & ram_s_axi_awregion;
	s_axi_awvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awvalid & gpio_s_axi_awvalid & timer_s_axi_awvalid & int_s_axi_awvalid & ram_s_axi_awvalid;
	s_axi_awready <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awready & gpio_s_axi_awready & timer_s_axi_awready & int_s_axi_awready & ram_s_axi_awready;
	s_axi_wdata <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_wdata & gpio_s_axi_wdata & timer_s_axi_wdata & int_s_axi_wdata & ram_s_axi_wdata;
	s_axi_wstrb <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_wstrb & gpio_s_axi_wstrb & timer_s_axi_wstrb & int_s_axi_wstrb & ram_s_axi_wstrb;
	s_axi_wlast <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_wlast & gpio_s_axi_wlast & timer_s_axi_wlast & int_s_axi_wlast & ram_s_axi_wlast;
	s_axi_wvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_wvalid & gpio_s_axi_wvalid & timer_s_axi_wvalid & int_s_axi_wvalid & ram_s_axi_wvalid;
	s_axi_wready <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_wready & gpio_s_axi_wready & timer_s_axi_wready & int_s_axi_wready & ram_s_axi_wready;
	s_axi_bid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_bid & gpio_s_axi_bid & timer_s_axi_bid & int_s_axi_bid & ram_s_axi_bid;
	s_axi_bresp <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_bresp & gpio_s_axi_bresp & timer_s_axi_bresp & int_s_axi_bresp & ram_s_axi_bresp;
	s_axi_bvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_bvalid & gpio_s_axi_bvalid & timer_s_axi_bvalid & int_s_axi_bvalid & ram_s_axi_bvalid;
	s_axi_bready <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_bready & gpio_s_axi_bready & timer_s_axi_bready & int_s_axi_bready & ram_s_axi_bready;
	s_axi_arid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arid & gpio_s_axi_arid & timer_s_axi_arid & int_s_axi_arid & ram_s_axi_arid;
	s_axi_araddr <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_araddr & gpio_s_axi_araddr & timer_s_axi_araddr & int_s_axi_araddr & ram_s_axi_araddr;
	s_axi_arlen <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arlen & gpio_s_axi_arlen & timer_s_axi_arlen & int_s_axi_arlen & ram_s_axi_arlen;
	s_axi_arsize <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arsize & gpio_s_axi_arsize & timer_s_axi_arsize & int_s_axi_arsize & ram_s_axi_arsize;
	s_axi_arburst <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arburst & gpio_s_axi_arburst & timer_s_axi_arburst & int_s_axi_arburst & ram_s_axi_arburst;
	s_axi_arlock <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arlock & gpio_s_axi_arlock & timer_s_axi_arlock & int_s_axi_arlock & ram_s_axi_arlock;
	s_axi_arcache <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arcache & gpio_s_axi_arcache & timer_s_axi_arcache & int_s_axi_arcache & ram_s_axi_arcache;
	s_axi_arprot <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arprot & gpio_s_axi_arprot & timer_s_axi_arprot & int_s_axi_arprot & ram_s_axi_arprot;
	s_axi_arqos <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arqos & gpio_s_axi_arqos & timer_s_axi_arqos & int_s_axi_arqos & ram_s_axi_arqos;
	s_axi_arregion <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arregion & gpio_s_axi_arregion & timer_s_axi_arregion & int_s_axi_arregion & ram_s_axi_arregion;
	s_axi_arvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arvalid & gpio_s_axi_arvalid & timer_s_axi_arvalid & int_s_axi_arvalid & ram_s_axi_arvalid;
	s_axi_arready <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arready & gpio_s_axi_arready & timer_s_axi_arready & int_s_axi_arready & ram_s_axi_arready;
	s_axi_rid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_rid & gpio_s_axi_rid & timer_s_axi_rid & int_s_axi_rid & ram_s_axi_rid;
	s_axi_rdata <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_rdata & gpio_s_axi_rdata & timer_s_axi_rdata & int_s_axi_rdata & ram_s_axi_rdata;
	s_axi_rresp <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_rresp & gpio_s_axi_rresp & timer_s_axi_rresp & int_s_axi_rresp & ram_s_axi_rresp;
	s_axi_rlast <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_rlast & gpio_s_axi_rlast & timer_s_axi_rlast & int_s_axi_rlast & ram_s_axi_rlast;
	s_axi_rvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_rvalid & gpio_s_axi_rvalid & timer_s_axi_rvalid & int_s_axi_rvalid & ram_s_axi_rvalid;
	s_axi_rready <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_rready & gpio_s_axi_rready & timer_s_axi_rready & int_s_axi_rready & ram_s_axi_rready;
	plasoc_crossbar_inst : plasoc_crossbar
		generic map
		(
			axi_address_width  => axi_address_width,
			axi_data_width  => axi_data_width,
			axi_master_amount  => axi_master_amount,
			axi_master_id_width  => axi_master_id_width,
			axi_slave_amount  => axi_slave_amount,
			axi_slave_base_address  => axi_slave_base_address,
			axi_slave_high_address  => axi_slave_high_address
		)
		port map
		(
			aclk => aclk,
			aresetn => aresetn,
			m_axi_awid => m_axi_awid,
			m_axi_awaddr => m_axi_awaddr,
			m_axi_awlen => m_axi_awlen,
			m_axi_awsize => m_axi_awsize,
			m_axi_awburst => m_axi_awburst,
			m_axi_awlock => m_axi_awlock,
			m_axi_awcache => m_axi_awcache,
			m_axi_awprot => m_axi_awprot,
			m_axi_awqos => m_axi_awqos,
			m_axi_awregion => m_axi_awregion,
			m_axi_awvalid => m_axi_awvalid,
			m_axi_awready => m_axi_awready,
			m_axi_wdata => m_axi_wdata,
			m_axi_wstrb => m_axi_wstrb,
			m_axi_wlast => m_axi_wlast,
			m_axi_wvalid => m_axi_wvalid,
			m_axi_wready => m_axi_wready,
			m_axi_bid => m_axi_bid,
			m_axi_bresp => m_axi_bresp,
			m_axi_bvalid => m_axi_bvalid,
			m_axi_bready => m_axi_bready,
			m_axi_arid => m_axi_arid,
			m_axi_araddr => m_axi_araddr,
			m_axi_arlen => m_axi_arlen,
			m_axi_arsize => m_axi_arsize,
			m_axi_arburst => m_axi_arburst,
			m_axi_arlock => m_axi_arlock,
			m_axi_arcache => m_axi_arcache,
			m_axi_arprot => m_axi_arprot,
			m_axi_arqos => m_axi_arqos,
			m_axi_arregion => m_axi_arregion,
			m_axi_arvalid => m_axi_arvalid,
			m_axi_arready => m_axi_arready,
			m_axi_rid => m_axi_rid,
			m_axi_rdata => m_axi_rdata,
			m_axi_rresp => m_axi_rresp,
			m_axi_rlast => m_axi_rlast,
			m_axi_rvalid => m_axi_rvalid,
			m_axi_rready => m_axi_rready,
			s_axi_awid => s_axi_awid,
			s_axi_awaddr => s_axi_awaddr,
			s_axi_awlen => s_axi_awlen,
			s_axi_awsize => s_axi_awsize,
			s_axi_awburst => s_axi_awburst,
			s_axi_awlock => s_axi_awlock,
			s_axi_awcache => s_axi_awcache,
			s_axi_awprot => s_axi_awprot,
			s_axi_awqos => s_axi_awqos,
			s_axi_awregion => s_axi_awregion,
			s_axi_awvalid => s_axi_awvalid,
			s_axi_awready => s_axi_awready,
			s_axi_wdata => s_axi_wdata,
			s_axi_wstrb => s_axi_wstrb,
			s_axi_wlast => s_axi_wlast,
			s_axi_wvalid => s_axi_wvalid,
			s_axi_wready => s_axi_wready,
			s_axi_bid => s_axi_bid,
			s_axi_bresp => s_axi_bresp,
			s_axi_bvalid => s_axi_bvalid,
			s_axi_bready => s_axi_bready,
			s_axi_arid => s_axi_arid,
			s_axi_araddr => s_axi_araddr,
			s_axi_arlen => s_axi_arlen,
			s_axi_arsize => s_axi_arsize,
			s_axi_arburst => s_axi_arburst,
			s_axi_arlock => s_axi_arlock,
			s_axi_arcache => s_axi_arcache,
			s_axi_arprot => s_axi_arprot,
			s_axi_arqos => s_axi_arqos,
			s_axi_arregion => s_axi_arregion,
			s_axi_arvalid => s_axi_arvalid,
			s_axi_arready => s_axi_arready,
			s_axi_rid => s_axi_rid,
			s_axi_rdata => s_axi_rdata,
			s_axi_rresp => s_axi_rresp,
			s_axi_rlast => s_axi_rlast,
			s_axi_rvalid => s_axi_rvalid,
			s_axi_rready => s_axi_rready
	);
end Behavioral;
