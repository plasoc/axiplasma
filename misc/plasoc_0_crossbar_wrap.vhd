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
		axi_slave_id_width : integer := 0;
		axi_master_amount : integer := 5;
		axi_slave_amount : integer := 2;
		axi_master_base_address : std_logic_vector := X"44a3000044a2000044a1000044a0000000000000";
		axi_master_high_address : std_logic_vector := X"44a3ffff44a2ffff44a1ffff44a0ffff0000ffff"
	);
	port
	(
		cpu_s_axi_awid :  in  std_logic_vector(axi_slave_id_width-1 downto 0);
		cpu_s_axi_awaddr :  in  std_logic_vector(axi_address_width-1 downto 0);
		cpu_s_axi_awlen :  in  std_logic_vector(7 downto 0);
		cpu_s_axi_awsize :  in  std_logic_vector(2 downto 0);
		cpu_s_axi_awburst :  in  std_logic_vector(1 downto 0);
		cpu_s_axi_awlock :  in  std_logic;
		cpu_s_axi_awcache :  in  std_logic_vector(3 downto 0);
		cpu_s_axi_awprot :  in  std_logic_vector(2 downto 0);
		cpu_s_axi_awqos :  in  std_logic_vector(3 downto 0);
		cpu_s_axi_awregion :  in  std_logic_vector(3 downto 0);
		cpu_s_axi_awvalid :  in  std_logic;
		cpu_s_axi_awready :  out  std_logic;
		cpu_s_axi_wdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		cpu_s_axi_wstrb :  in  std_logic_vector(axi_data_width/8-1 downto 0);
		cpu_s_axi_wlast :  in  std_logic;
		cpu_s_axi_wvalid :  in  std_logic;
		cpu_s_axi_wready :  out  std_logic;
		cpu_s_axi_bid :  out  std_logic_vector(axi_slave_id_width-1 downto 0);
		cpu_s_axi_bresp :  out  std_logic_vector(1 downto 0);
		cpu_s_axi_bvalid :  out  std_logic;
		cpu_s_axi_bready :  in  std_logic;
		cpu_s_axi_arid :  in  std_logic_vector(axi_slave_id_width-1 downto 0);
		cpu_s_axi_araddr :  in  std_logic_vector(axi_address_width-1 downto 0);
		cpu_s_axi_arlen :  in  std_logic_vector(7 downto 0);
		cpu_s_axi_arsize :  in  std_logic_vector(2 downto 0);
		cpu_s_axi_arburst :  in  std_logic_vector(1 downto 0);
		cpu_s_axi_arlock :  in  std_logic;
		cpu_s_axi_arcache :  in  std_logic_vector(3 downto 0);
		cpu_s_axi_arprot :  in  std_logic_vector(2 downto 0);
		cpu_s_axi_arqos :  in  std_logic_vector(3 downto 0);
		cpu_s_axi_arregion :  in  std_logic_vector(3 downto 0);
		cpu_s_axi_arvalid :  in  std_logic;
		cpu_s_axi_arready :  out  std_logic;
		cpu_s_axi_rid :  out  std_logic_vector(axi_slave_id_width-1 downto 0);
		cpu_s_axi_rdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		cpu_s_axi_rresp :  out  std_logic_vector(1 downto 0);
		cpu_s_axi_rlast :  out  std_logic;
		cpu_s_axi_rvalid :  out  std_logic;
		cpu_s_axi_rready :  in  std_logic;
		cdma_s_axi_awid :  in  std_logic_vector(axi_slave_id_width-1 downto 0);
		cdma_s_axi_awaddr :  in  std_logic_vector(axi_address_width-1 downto 0);
		cdma_s_axi_awlen :  in  std_logic_vector(7 downto 0);
		cdma_s_axi_awsize :  in  std_logic_vector(2 downto 0);
		cdma_s_axi_awburst :  in  std_logic_vector(1 downto 0);
		cdma_s_axi_awlock :  in  std_logic;
		cdma_s_axi_awcache :  in  std_logic_vector(3 downto 0);
		cdma_s_axi_awprot :  in  std_logic_vector(2 downto 0);
		cdma_s_axi_awqos :  in  std_logic_vector(3 downto 0);
		cdma_s_axi_awregion :  in  std_logic_vector(3 downto 0);
		cdma_s_axi_awvalid :  in  std_logic;
		cdma_s_axi_awready :  out  std_logic;
		cdma_s_axi_wdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		cdma_s_axi_wstrb :  in  std_logic_vector(axi_data_width/8-1 downto 0);
		cdma_s_axi_wlast :  in  std_logic;
		cdma_s_axi_wvalid :  in  std_logic;
		cdma_s_axi_wready :  out  std_logic;
		cdma_s_axi_bid :  out  std_logic_vector(axi_slave_id_width-1 downto 0);
		cdma_s_axi_bresp :  out  std_logic_vector(1 downto 0);
		cdma_s_axi_bvalid :  out  std_logic;
		cdma_s_axi_bready :  in  std_logic;
		cdma_s_axi_arid :  in  std_logic_vector(axi_slave_id_width-1 downto 0);
		cdma_s_axi_araddr :  in  std_logic_vector(axi_address_width-1 downto 0);
		cdma_s_axi_arlen :  in  std_logic_vector(7 downto 0);
		cdma_s_axi_arsize :  in  std_logic_vector(2 downto 0);
		cdma_s_axi_arburst :  in  std_logic_vector(1 downto 0);
		cdma_s_axi_arlock :  in  std_logic;
		cdma_s_axi_arcache :  in  std_logic_vector(3 downto 0);
		cdma_s_axi_arprot :  in  std_logic_vector(2 downto 0);
		cdma_s_axi_arqos :  in  std_logic_vector(3 downto 0);
		cdma_s_axi_arregion :  in  std_logic_vector(3 downto 0);
		cdma_s_axi_arvalid :  in  std_logic;
		cdma_s_axi_arready :  out  std_logic;
		cdma_s_axi_rid :  out  std_logic_vector(axi_slave_id_width-1 downto 0);
		cdma_s_axi_rdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		cdma_s_axi_rresp :  out  std_logic_vector(1 downto 0);
		cdma_s_axi_rlast :  out  std_logic;
		cdma_s_axi_rvalid :  out  std_logic;
		cdma_s_axi_rready :  in  std_logic;
		ram_m_axi_awid :  out  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		ram_m_axi_awaddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		ram_m_axi_awlen :  out  std_logic_vector(7 downto 0);
		ram_m_axi_awsize :  out  std_logic_vector(2 downto 0);
		ram_m_axi_awburst :  out  std_logic_vector(1 downto 0);
		ram_m_axi_awlock :  out  std_logic;
		ram_m_axi_awcache :  out  std_logic_vector(3 downto 0);
		ram_m_axi_awprot :  out  std_logic_vector(2 downto 0);
		ram_m_axi_awqos :  out  std_logic_vector(3 downto 0);
		ram_m_axi_awregion :  out  std_logic_vector(3 downto 0);
		ram_m_axi_awvalid :  out  std_logic;
		ram_m_axi_awready :  in  std_logic;
		ram_m_axi_wdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		ram_m_axi_wstrb :  out  std_logic_vector(axi_data_width/8-1 downto 0);
		ram_m_axi_wlast :  out  std_logic;
		ram_m_axi_wvalid :  out  std_logic;
		ram_m_axi_wready :  in  std_logic;
		ram_m_axi_bid :  in  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		ram_m_axi_bresp :  in  std_logic_vector(1 downto 0);
		ram_m_axi_bvalid :  in  std_logic;
		ram_m_axi_bready :  out  std_logic;
		ram_m_axi_arid :  out  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		ram_m_axi_araddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		ram_m_axi_arlen :  out  std_logic_vector(7 downto 0);
		ram_m_axi_arsize :  out  std_logic_vector(2 downto 0);
		ram_m_axi_arburst :  out  std_logic_vector(1 downto 0);
		ram_m_axi_arlock :  out  std_logic;
		ram_m_axi_arcache :  out  std_logic_vector(3 downto 0);
		ram_m_axi_arprot :  out  std_logic_vector(2 downto 0);
		ram_m_axi_arqos :  out  std_logic_vector(3 downto 0);
		ram_m_axi_arregion :  out  std_logic_vector(3 downto 0);
		ram_m_axi_arvalid :  out  std_logic;
		ram_m_axi_arready :  in  std_logic;
		ram_m_axi_rid :  in  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		ram_m_axi_rdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		ram_m_axi_rresp :  in  std_logic_vector(1 downto 0);
		ram_m_axi_rlast :  in  std_logic;
		ram_m_axi_rvalid :  in  std_logic;
		ram_m_axi_rready :  out  std_logic;
		int_m_axi_awid :  out  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		int_m_axi_awaddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		int_m_axi_awlen :  out  std_logic_vector(7 downto 0);
		int_m_axi_awsize :  out  std_logic_vector(2 downto 0);
		int_m_axi_awburst :  out  std_logic_vector(1 downto 0);
		int_m_axi_awlock :  out  std_logic;
		int_m_axi_awcache :  out  std_logic_vector(3 downto 0);
		int_m_axi_awprot :  out  std_logic_vector(2 downto 0);
		int_m_axi_awqos :  out  std_logic_vector(3 downto 0);
		int_m_axi_awregion :  out  std_logic_vector(3 downto 0);
		int_m_axi_awvalid :  out  std_logic;
		int_m_axi_awready :  in  std_logic;
		int_m_axi_wdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		int_m_axi_wstrb :  out  std_logic_vector(axi_data_width/8-1 downto 0);
		int_m_axi_wlast :  out  std_logic;
		int_m_axi_wvalid :  out  std_logic;
		int_m_axi_wready :  in  std_logic;
		int_m_axi_bid :  in  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		int_m_axi_bresp :  in  std_logic_vector(1 downto 0);
		int_m_axi_bvalid :  in  std_logic;
		int_m_axi_bready :  out  std_logic;
		int_m_axi_arid :  out  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		int_m_axi_araddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		int_m_axi_arlen :  out  std_logic_vector(7 downto 0);
		int_m_axi_arsize :  out  std_logic_vector(2 downto 0);
		int_m_axi_arburst :  out  std_logic_vector(1 downto 0);
		int_m_axi_arlock :  out  std_logic;
		int_m_axi_arcache :  out  std_logic_vector(3 downto 0);
		int_m_axi_arprot :  out  std_logic_vector(2 downto 0);
		int_m_axi_arqos :  out  std_logic_vector(3 downto 0);
		int_m_axi_arregion :  out  std_logic_vector(3 downto 0);
		int_m_axi_arvalid :  out  std_logic;
		int_m_axi_arready :  in  std_logic;
		int_m_axi_rid :  in  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		int_m_axi_rdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		int_m_axi_rresp :  in  std_logic_vector(1 downto 0);
		int_m_axi_rlast :  in  std_logic;
		int_m_axi_rvalid :  in  std_logic;
		int_m_axi_rready :  out  std_logic;
		timer_m_axi_awid :  out  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		timer_m_axi_awaddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		timer_m_axi_awlen :  out  std_logic_vector(7 downto 0);
		timer_m_axi_awsize :  out  std_logic_vector(2 downto 0);
		timer_m_axi_awburst :  out  std_logic_vector(1 downto 0);
		timer_m_axi_awlock :  out  std_logic;
		timer_m_axi_awcache :  out  std_logic_vector(3 downto 0);
		timer_m_axi_awprot :  out  std_logic_vector(2 downto 0);
		timer_m_axi_awqos :  out  std_logic_vector(3 downto 0);
		timer_m_axi_awregion :  out  std_logic_vector(3 downto 0);
		timer_m_axi_awvalid :  out  std_logic;
		timer_m_axi_awready :  in  std_logic;
		timer_m_axi_wdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		timer_m_axi_wstrb :  out  std_logic_vector(axi_data_width/8-1 downto 0);
		timer_m_axi_wlast :  out  std_logic;
		timer_m_axi_wvalid :  out  std_logic;
		timer_m_axi_wready :  in  std_logic;
		timer_m_axi_bid :  in  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		timer_m_axi_bresp :  in  std_logic_vector(1 downto 0);
		timer_m_axi_bvalid :  in  std_logic;
		timer_m_axi_bready :  out  std_logic;
		timer_m_axi_arid :  out  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		timer_m_axi_araddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		timer_m_axi_arlen :  out  std_logic_vector(7 downto 0);
		timer_m_axi_arsize :  out  std_logic_vector(2 downto 0);
		timer_m_axi_arburst :  out  std_logic_vector(1 downto 0);
		timer_m_axi_arlock :  out  std_logic;
		timer_m_axi_arcache :  out  std_logic_vector(3 downto 0);
		timer_m_axi_arprot :  out  std_logic_vector(2 downto 0);
		timer_m_axi_arqos :  out  std_logic_vector(3 downto 0);
		timer_m_axi_arregion :  out  std_logic_vector(3 downto 0);
		timer_m_axi_arvalid :  out  std_logic;
		timer_m_axi_arready :  in  std_logic;
		timer_m_axi_rid :  in  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		timer_m_axi_rdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		timer_m_axi_rresp :  in  std_logic_vector(1 downto 0);
		timer_m_axi_rlast :  in  std_logic;
		timer_m_axi_rvalid :  in  std_logic;
		timer_m_axi_rready :  out  std_logic;
		gpio_m_axi_awid :  out  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		gpio_m_axi_awaddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		gpio_m_axi_awlen :  out  std_logic_vector(7 downto 0);
		gpio_m_axi_awsize :  out  std_logic_vector(2 downto 0);
		gpio_m_axi_awburst :  out  std_logic_vector(1 downto 0);
		gpio_m_axi_awlock :  out  std_logic;
		gpio_m_axi_awcache :  out  std_logic_vector(3 downto 0);
		gpio_m_axi_awprot :  out  std_logic_vector(2 downto 0);
		gpio_m_axi_awqos :  out  std_logic_vector(3 downto 0);
		gpio_m_axi_awregion :  out  std_logic_vector(3 downto 0);
		gpio_m_axi_awvalid :  out  std_logic;
		gpio_m_axi_awready :  in  std_logic;
		gpio_m_axi_wdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		gpio_m_axi_wstrb :  out  std_logic_vector(axi_data_width/8-1 downto 0);
		gpio_m_axi_wlast :  out  std_logic;
		gpio_m_axi_wvalid :  out  std_logic;
		gpio_m_axi_wready :  in  std_logic;
		gpio_m_axi_bid :  in  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		gpio_m_axi_bresp :  in  std_logic_vector(1 downto 0);
		gpio_m_axi_bvalid :  in  std_logic;
		gpio_m_axi_bready :  out  std_logic;
		gpio_m_axi_arid :  out  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		gpio_m_axi_araddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		gpio_m_axi_arlen :  out  std_logic_vector(7 downto 0);
		gpio_m_axi_arsize :  out  std_logic_vector(2 downto 0);
		gpio_m_axi_arburst :  out  std_logic_vector(1 downto 0);
		gpio_m_axi_arlock :  out  std_logic;
		gpio_m_axi_arcache :  out  std_logic_vector(3 downto 0);
		gpio_m_axi_arprot :  out  std_logic_vector(2 downto 0);
		gpio_m_axi_arqos :  out  std_logic_vector(3 downto 0);
		gpio_m_axi_arregion :  out  std_logic_vector(3 downto 0);
		gpio_m_axi_arvalid :  out  std_logic;
		gpio_m_axi_arready :  in  std_logic;
		gpio_m_axi_rid :  in  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		gpio_m_axi_rdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		gpio_m_axi_rresp :  in  std_logic_vector(1 downto 0);
		gpio_m_axi_rlast :  in  std_logic;
		gpio_m_axi_rvalid :  in  std_logic;
		gpio_m_axi_rready :  out  std_logic;
		cdma_m_axi_awid :  out  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		cdma_m_axi_awaddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		cdma_m_axi_awlen :  out  std_logic_vector(7 downto 0);
		cdma_m_axi_awsize :  out  std_logic_vector(2 downto 0);
		cdma_m_axi_awburst :  out  std_logic_vector(1 downto 0);
		cdma_m_axi_awlock :  out  std_logic;
		cdma_m_axi_awcache :  out  std_logic_vector(3 downto 0);
		cdma_m_axi_awprot :  out  std_logic_vector(2 downto 0);
		cdma_m_axi_awqos :  out  std_logic_vector(3 downto 0);
		cdma_m_axi_awregion :  out  std_logic_vector(3 downto 0);
		cdma_m_axi_awvalid :  out  std_logic;
		cdma_m_axi_awready :  in  std_logic;
		cdma_m_axi_wdata :  out  std_logic_vector(axi_data_width-1 downto 0);
		cdma_m_axi_wstrb :  out  std_logic_vector(axi_data_width/8-1 downto 0);
		cdma_m_axi_wlast :  out  std_logic;
		cdma_m_axi_wvalid :  out  std_logic;
		cdma_m_axi_wready :  in  std_logic;
		cdma_m_axi_bid :  in  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		cdma_m_axi_bresp :  in  std_logic_vector(1 downto 0);
		cdma_m_axi_bvalid :  in  std_logic;
		cdma_m_axi_bready :  out  std_logic;
		cdma_m_axi_arid :  out  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		cdma_m_axi_araddr :  out  std_logic_vector(axi_address_width-1 downto 0);
		cdma_m_axi_arlen :  out  std_logic_vector(7 downto 0);
		cdma_m_axi_arsize :  out  std_logic_vector(2 downto 0);
		cdma_m_axi_arburst :  out  std_logic_vector(1 downto 0);
		cdma_m_axi_arlock :  out  std_logic;
		cdma_m_axi_arcache :  out  std_logic_vector(3 downto 0);
		cdma_m_axi_arprot :  out  std_logic_vector(2 downto 0);
		cdma_m_axi_arqos :  out  std_logic_vector(3 downto 0);
		cdma_m_axi_arregion :  out  std_logic_vector(3 downto 0);
		cdma_m_axi_arvalid :  out  std_logic;
		cdma_m_axi_arready :  in  std_logic;
		cdma_m_axi_rid :  in  std_logic_vector((clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
		cdma_m_axi_rdata :  in  std_logic_vector(axi_data_width-1 downto 0);
		cdma_m_axi_rresp :  in  std_logic_vector(1 downto 0);
		cdma_m_axi_rlast :  in  std_logic;
		cdma_m_axi_rvalid :  in  std_logic;
		cdma_m_axi_rready :  out  std_logic;
		aclk : in std_logic;
		aresetn : in std_logic
	);
end plasoc_0_crossbar_wrap;

architecture Behavioral of plasoc_0_crossbar_wrap is
	constant axi_master_id_width : integer := clogb2(axi_slave_amount+1)+axi_slave_id_width;
	signal s_axi_awid : std_logic_vector(axi_slave_amount*axi_slave_id_width-1 downto 0);
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
	signal s_axi_bid : std_logic_vector(axi_slave_amount*axi_slave_id_width-1 downto 0);
	signal s_axi_bresp : std_logic_vector(axi_slave_amount*2-1 downto 0);
	signal s_axi_bvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_bready : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_arid : std_logic_vector(axi_slave_amount*axi_slave_id_width-1 downto 0);
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
	signal s_axi_rid : std_logic_vector(axi_slave_amount*axi_slave_id_width-1 downto 0);
	signal s_axi_rdata : std_logic_vector(axi_slave_amount*axi_data_width-1 downto 0);
	signal s_axi_rresp : std_logic_vector(axi_slave_amount*2-1 downto 0);
	signal s_axi_rlast : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_rvalid : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal s_axi_rready : std_logic_vector(axi_slave_amount*1-1 downto 0);
	signal m_axi_awid : std_logic_vector(axi_master_amount*(clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
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
	signal m_axi_bid : std_logic_vector(axi_master_amount*(clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
	signal m_axi_bresp : std_logic_vector(axi_master_amount*2-1 downto 0);
	signal m_axi_bvalid : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_bready : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_arid : std_logic_vector(axi_master_amount*(clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
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
	signal m_axi_rid : std_logic_vector(axi_master_amount*(clogb2(axi_slave_amount+1)+axi_slave_id_width)-1 downto 0);
	signal m_axi_rdata : std_logic_vector(axi_master_amount*axi_data_width-1 downto 0);
	signal m_axi_rresp : std_logic_vector(axi_master_amount*2-1 downto 0);
	signal m_axi_rlast : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_rvalid : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal m_axi_rready : std_logic_vector(axi_master_amount*1-1 downto 0);
	signal s_address_write_connected : std_logic_vector(axi_slave_amount-1 downto 0);
	signal s_data_write_connected : std_logic_vector(axi_slave_amount-1 downto 0);
	signal s_response_write_connected : std_logic_vector(axi_slave_amount-1 downto 0);
	signal s_address_read_connected : std_logic_vector(axi_slave_amount-1 downto 0);
	signal s_data_read_connected : std_logic_vector(axi_slave_amount-1 downto 0);
	signal m_address_write_connected : std_logic_vector(axi_master_amount-1 downto 0);
	signal m_data_write_connected : std_logic_vector(axi_master_amount-1 downto 0);
	signal m_response_write_connected : std_logic_vector(axi_master_amount-1 downto 0);
	signal m_address_read_connected : std_logic_vector(axi_master_amount-1 downto 0);
	signal m_data_read_connected : std_logic_vector(axi_master_amount-1 downto 0); 
begin
	s_axi_awid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awid & cpu_s_axi_awid;
	s_axi_awaddr <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awaddr & cpu_s_axi_awaddr;
	s_axi_awlen <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awlen & cpu_s_axi_awlen;
	s_axi_awsize <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awsize & cpu_s_axi_awsize;
	s_axi_awburst <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awburst & cpu_s_axi_awburst;
	s_axi_awlock <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awlock & cpu_s_axi_awlock;
	s_axi_awcache <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awcache & cpu_s_axi_awcache;
	s_axi_awprot <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awprot & cpu_s_axi_awprot;
	s_axi_awqos <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awqos & cpu_s_axi_awqos;
	s_axi_awregion <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awregion & cpu_s_axi_awregion;
	s_axi_awvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_awvalid & cpu_s_axi_awvalid;
	s_axi_wdata <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_wdata & cpu_s_axi_wdata;
	s_axi_wstrb <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_wstrb & cpu_s_axi_wstrb;
	s_axi_wlast <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_wlast & cpu_s_axi_wlast;
	s_axi_wvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_wvalid & cpu_s_axi_wvalid;
	s_axi_bready <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_bready & cpu_s_axi_bready;
	s_axi_arid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arid & cpu_s_axi_arid;
	s_axi_araddr <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_araddr & cpu_s_axi_araddr;
	s_axi_arlen <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arlen & cpu_s_axi_arlen;
	s_axi_arsize <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arsize & cpu_s_axi_arsize;
	s_axi_arburst <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arburst & cpu_s_axi_arburst;
	s_axi_arlock <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arlock & cpu_s_axi_arlock;
	s_axi_arcache <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arcache & cpu_s_axi_arcache;
	s_axi_arprot <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arprot & cpu_s_axi_arprot;
	s_axi_arqos <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arqos & cpu_s_axi_arqos;
	s_axi_arregion <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arregion & cpu_s_axi_arregion;
	s_axi_arvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_arvalid & cpu_s_axi_arvalid;
	s_axi_rready <= std_logic_vector(to_unsigned(0,0)) & cdma_s_axi_rready & cpu_s_axi_rready;
	m_axi_awready <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_awready & gpio_m_axi_awready & timer_m_axi_awready & int_m_axi_awready & ram_m_axi_awready;
	m_axi_wready <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_wready & gpio_m_axi_wready & timer_m_axi_wready & int_m_axi_wready & ram_m_axi_wready;
	m_axi_bid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_bid & gpio_m_axi_bid & timer_m_axi_bid & int_m_axi_bid & ram_m_axi_bid;
	m_axi_bresp <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_bresp & gpio_m_axi_bresp & timer_m_axi_bresp & int_m_axi_bresp & ram_m_axi_bresp;
	m_axi_bvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_bvalid & gpio_m_axi_bvalid & timer_m_axi_bvalid & int_m_axi_bvalid & ram_m_axi_bvalid;
	m_axi_arready <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_arready & gpio_m_axi_arready & timer_m_axi_arready & int_m_axi_arready & ram_m_axi_arready;
	m_axi_rid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_rid & gpio_m_axi_rid & timer_m_axi_rid & int_m_axi_rid & ram_m_axi_rid;
	m_axi_rdata <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_rdata & gpio_m_axi_rdata & timer_m_axi_rdata & int_m_axi_rdata & ram_m_axi_rdata;
	m_axi_rresp <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_rresp & gpio_m_axi_rresp & timer_m_axi_rresp & int_m_axi_rresp & ram_m_axi_rresp;
	m_axi_rlast <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_rlast & gpio_m_axi_rlast & timer_m_axi_rlast & int_m_axi_rlast & ram_m_axi_rlast;
	m_axi_rvalid <= std_logic_vector(to_unsigned(0,0)) & cdma_m_axi_rvalid & gpio_m_axi_rvalid & timer_m_axi_rvalid & int_m_axi_rvalid & ram_m_axi_rvalid;
	cpu_s_axi_awready <= '0' when s_address_write_connected(0)='0' else s_axi_awready(0);
	cdma_s_axi_awready <= '0' when s_address_write_connected(1)='0' else s_axi_awready(1);
	cpu_s_axi_wready <= '0' when s_data_write_connected(0)='0' else s_axi_wready(0);
	cdma_s_axi_wready <= '0' when s_data_write_connected(1)='0' else s_axi_wready(1);
	cpu_s_axi_bid <= (others=>'0') when s_response_write_connected(0)='0' else s_axi_bid((1+0)*axi_slave_id_width-1 downto 0*axi_slave_id_width);
	cdma_s_axi_bid <= (others=>'0') when s_response_write_connected(1)='0' else s_axi_bid((1+1)*axi_slave_id_width-1 downto 1*axi_slave_id_width);
	cpu_s_axi_bresp <= (others=>'0') when s_response_write_connected(0)='0' else s_axi_bresp((1+0)*2-1 downto 0*2);
	cdma_s_axi_bresp <= (others=>'0') when s_response_write_connected(1)='0' else s_axi_bresp((1+1)*2-1 downto 1*2);
	cpu_s_axi_bvalid <= '0' when s_response_write_connected(0)='0' else s_axi_bvalid(0);
	cdma_s_axi_bvalid <= '0' when s_response_write_connected(1)='0' else s_axi_bvalid(1);
	cpu_s_axi_arready <= '0' when s_address_read_connected(0)='0' else s_axi_arready(0);
	cdma_s_axi_arready <= '0' when s_address_read_connected(1)='0' else s_axi_arready(1);
	cpu_s_axi_rid <= (others=>'0') when s_data_read_connected(0)='0' else s_axi_rid((1+0)*axi_slave_id_width-1 downto 0*axi_slave_id_width);
	cdma_s_axi_rid <= (others=>'0') when s_data_read_connected(1)='0' else s_axi_rid((1+1)*axi_slave_id_width-1 downto 1*axi_slave_id_width);
	cpu_s_axi_rdata <= (others=>'0') when s_data_read_connected(0)='0' else s_axi_rdata((1+0)*axi_data_width-1 downto 0*axi_data_width);
	cdma_s_axi_rdata <= (others=>'0') when s_data_read_connected(1)='0' else s_axi_rdata((1+1)*axi_data_width-1 downto 1*axi_data_width);
	cpu_s_axi_rresp <= (others=>'0') when s_data_read_connected(0)='0' else s_axi_rresp((1+0)*2-1 downto 0*2);
	cdma_s_axi_rresp <= (others=>'0') when s_data_read_connected(1)='0' else s_axi_rresp((1+1)*2-1 downto 1*2);
	cpu_s_axi_rlast <= '0' when s_data_read_connected(0)='0' else s_axi_rlast(0);
	cdma_s_axi_rlast <= '0' when s_data_read_connected(1)='0' else s_axi_rlast(1);
	cpu_s_axi_rvalid <= '0' when s_data_read_connected(0)='0' else s_axi_rvalid(0);
	cdma_s_axi_rvalid <= '0' when s_data_read_connected(1)='0' else s_axi_rvalid(1);
	ram_m_axi_awid <= (others=>'0') when m_address_write_connected(0)='0' else m_axi_awid((1+0)*axi_master_id_width-1 downto 0*axi_master_id_width);
	int_m_axi_awid <= (others=>'0') when m_address_write_connected(1)='0' else m_axi_awid((1+1)*axi_master_id_width-1 downto 1*axi_master_id_width);
	timer_m_axi_awid <= (others=>'0') when m_address_write_connected(2)='0' else m_axi_awid((1+2)*axi_master_id_width-1 downto 2*axi_master_id_width);
	gpio_m_axi_awid <= (others=>'0') when m_address_write_connected(3)='0' else m_axi_awid((1+3)*axi_master_id_width-1 downto 3*axi_master_id_width);
	cdma_m_axi_awid <= (others=>'0') when m_address_write_connected(4)='0' else m_axi_awid((1+4)*axi_master_id_width-1 downto 4*axi_master_id_width);
	ram_m_axi_awaddr <= (others=>'0') when m_address_write_connected(0)='0' else m_axi_awaddr((1+0)*axi_address_width-1 downto 0*axi_address_width);
	int_m_axi_awaddr <= (others=>'0') when m_address_write_connected(1)='0' else m_axi_awaddr((1+1)*axi_address_width-1 downto 1*axi_address_width);
	timer_m_axi_awaddr <= (others=>'0') when m_address_write_connected(2)='0' else m_axi_awaddr((1+2)*axi_address_width-1 downto 2*axi_address_width);
	gpio_m_axi_awaddr <= (others=>'0') when m_address_write_connected(3)='0' else m_axi_awaddr((1+3)*axi_address_width-1 downto 3*axi_address_width);
	cdma_m_axi_awaddr <= (others=>'0') when m_address_write_connected(4)='0' else m_axi_awaddr((1+4)*axi_address_width-1 downto 4*axi_address_width);
	ram_m_axi_awlen <= (others=>'0') when m_address_write_connected(0)='0' else m_axi_awlen((1+0)*8-1 downto 0*8);
	int_m_axi_awlen <= (others=>'0') when m_address_write_connected(1)='0' else m_axi_awlen((1+1)*8-1 downto 1*8);
	timer_m_axi_awlen <= (others=>'0') when m_address_write_connected(2)='0' else m_axi_awlen((1+2)*8-1 downto 2*8);
	gpio_m_axi_awlen <= (others=>'0') when m_address_write_connected(3)='0' else m_axi_awlen((1+3)*8-1 downto 3*8);
	cdma_m_axi_awlen <= (others=>'0') when m_address_write_connected(4)='0' else m_axi_awlen((1+4)*8-1 downto 4*8);
	ram_m_axi_awsize <= (others=>'0') when m_address_write_connected(0)='0' else m_axi_awsize((1+0)*3-1 downto 0*3);
	int_m_axi_awsize <= (others=>'0') when m_address_write_connected(1)='0' else m_axi_awsize((1+1)*3-1 downto 1*3);
	timer_m_axi_awsize <= (others=>'0') when m_address_write_connected(2)='0' else m_axi_awsize((1+2)*3-1 downto 2*3);
	gpio_m_axi_awsize <= (others=>'0') when m_address_write_connected(3)='0' else m_axi_awsize((1+3)*3-1 downto 3*3);
	cdma_m_axi_awsize <= (others=>'0') when m_address_write_connected(4)='0' else m_axi_awsize((1+4)*3-1 downto 4*3);
	ram_m_axi_awburst <= (others=>'0') when m_address_write_connected(0)='0' else m_axi_awburst((1+0)*2-1 downto 0*2);
	int_m_axi_awburst <= (others=>'0') when m_address_write_connected(1)='0' else m_axi_awburst((1+1)*2-1 downto 1*2);
	timer_m_axi_awburst <= (others=>'0') when m_address_write_connected(2)='0' else m_axi_awburst((1+2)*2-1 downto 2*2);
	gpio_m_axi_awburst <= (others=>'0') when m_address_write_connected(3)='0' else m_axi_awburst((1+3)*2-1 downto 3*2);
	cdma_m_axi_awburst <= (others=>'0') when m_address_write_connected(4)='0' else m_axi_awburst((1+4)*2-1 downto 4*2);
	ram_m_axi_awlock <= '0' when m_address_write_connected(0)='0' else m_axi_awlock(0);
	int_m_axi_awlock <= '0' when m_address_write_connected(1)='0' else m_axi_awlock(1);
	timer_m_axi_awlock <= '0' when m_address_write_connected(2)='0' else m_axi_awlock(2);
	gpio_m_axi_awlock <= '0' when m_address_write_connected(3)='0' else m_axi_awlock(3);
	cdma_m_axi_awlock <= '0' when m_address_write_connected(4)='0' else m_axi_awlock(4);
	ram_m_axi_awcache <= (others=>'0') when m_address_write_connected(0)='0' else m_axi_awcache((1+0)*4-1 downto 0*4);
	int_m_axi_awcache <= (others=>'0') when m_address_write_connected(1)='0' else m_axi_awcache((1+1)*4-1 downto 1*4);
	timer_m_axi_awcache <= (others=>'0') when m_address_write_connected(2)='0' else m_axi_awcache((1+2)*4-1 downto 2*4);
	gpio_m_axi_awcache <= (others=>'0') when m_address_write_connected(3)='0' else m_axi_awcache((1+3)*4-1 downto 3*4);
	cdma_m_axi_awcache <= (others=>'0') when m_address_write_connected(4)='0' else m_axi_awcache((1+4)*4-1 downto 4*4);
	ram_m_axi_awprot <= (others=>'0') when m_address_write_connected(0)='0' else m_axi_awprot((1+0)*3-1 downto 0*3);
	int_m_axi_awprot <= (others=>'0') when m_address_write_connected(1)='0' else m_axi_awprot((1+1)*3-1 downto 1*3);
	timer_m_axi_awprot <= (others=>'0') when m_address_write_connected(2)='0' else m_axi_awprot((1+2)*3-1 downto 2*3);
	gpio_m_axi_awprot <= (others=>'0') when m_address_write_connected(3)='0' else m_axi_awprot((1+3)*3-1 downto 3*3);
	cdma_m_axi_awprot <= (others=>'0') when m_address_write_connected(4)='0' else m_axi_awprot((1+4)*3-1 downto 4*3);
	ram_m_axi_awqos <= (others=>'0') when m_address_write_connected(0)='0' else m_axi_awqos((1+0)*4-1 downto 0*4);
	int_m_axi_awqos <= (others=>'0') when m_address_write_connected(1)='0' else m_axi_awqos((1+1)*4-1 downto 1*4);
	timer_m_axi_awqos <= (others=>'0') when m_address_write_connected(2)='0' else m_axi_awqos((1+2)*4-1 downto 2*4);
	gpio_m_axi_awqos <= (others=>'0') when m_address_write_connected(3)='0' else m_axi_awqos((1+3)*4-1 downto 3*4);
	cdma_m_axi_awqos <= (others=>'0') when m_address_write_connected(4)='0' else m_axi_awqos((1+4)*4-1 downto 4*4);
	ram_m_axi_awregion <= (others=>'0') when m_address_write_connected(0)='0' else m_axi_awregion((1+0)*4-1 downto 0*4);
	int_m_axi_awregion <= (others=>'0') when m_address_write_connected(1)='0' else m_axi_awregion((1+1)*4-1 downto 1*4);
	timer_m_axi_awregion <= (others=>'0') when m_address_write_connected(2)='0' else m_axi_awregion((1+2)*4-1 downto 2*4);
	gpio_m_axi_awregion <= (others=>'0') when m_address_write_connected(3)='0' else m_axi_awregion((1+3)*4-1 downto 3*4);
	cdma_m_axi_awregion <= (others=>'0') when m_address_write_connected(4)='0' else m_axi_awregion((1+4)*4-1 downto 4*4);
	ram_m_axi_awvalid <= '0' when m_address_write_connected(0)='0' else m_axi_awvalid(0);
	int_m_axi_awvalid <= '0' when m_address_write_connected(1)='0' else m_axi_awvalid(1);
	timer_m_axi_awvalid <= '0' when m_address_write_connected(2)='0' else m_axi_awvalid(2);
	gpio_m_axi_awvalid <= '0' when m_address_write_connected(3)='0' else m_axi_awvalid(3);
	cdma_m_axi_awvalid <= '0' when m_address_write_connected(4)='0' else m_axi_awvalid(4);
	ram_m_axi_wdata <= (others=>'0') when m_data_write_connected(0)='0' else m_axi_wdata((1+0)*axi_data_width-1 downto 0*axi_data_width);
	int_m_axi_wdata <= (others=>'0') when m_data_write_connected(1)='0' else m_axi_wdata((1+1)*axi_data_width-1 downto 1*axi_data_width);
	timer_m_axi_wdata <= (others=>'0') when m_data_write_connected(2)='0' else m_axi_wdata((1+2)*axi_data_width-1 downto 2*axi_data_width);
	gpio_m_axi_wdata <= (others=>'0') when m_data_write_connected(3)='0' else m_axi_wdata((1+3)*axi_data_width-1 downto 3*axi_data_width);
	cdma_m_axi_wdata <= (others=>'0') when m_data_write_connected(4)='0' else m_axi_wdata((1+4)*axi_data_width-1 downto 4*axi_data_width);
	ram_m_axi_wstrb <= (others=>'0') when m_data_write_connected(0)='0' else m_axi_wstrb((1+0)*axi_data_width/8-1 downto 0*axi_data_width/8);
	int_m_axi_wstrb <= (others=>'0') when m_data_write_connected(1)='0' else m_axi_wstrb((1+1)*axi_data_width/8-1 downto 1*axi_data_width/8);
	timer_m_axi_wstrb <= (others=>'0') when m_data_write_connected(2)='0' else m_axi_wstrb((1+2)*axi_data_width/8-1 downto 2*axi_data_width/8);
	gpio_m_axi_wstrb <= (others=>'0') when m_data_write_connected(3)='0' else m_axi_wstrb((1+3)*axi_data_width/8-1 downto 3*axi_data_width/8);
	cdma_m_axi_wstrb <= (others=>'0') when m_data_write_connected(4)='0' else m_axi_wstrb((1+4)*axi_data_width/8-1 downto 4*axi_data_width/8);
	ram_m_axi_wlast <= '0' when m_data_write_connected(0)='0' else m_axi_wlast(0);
	int_m_axi_wlast <= '0' when m_data_write_connected(1)='0' else m_axi_wlast(1);
	timer_m_axi_wlast <= '0' when m_data_write_connected(2)='0' else m_axi_wlast(2);
	gpio_m_axi_wlast <= '0' when m_data_write_connected(3)='0' else m_axi_wlast(3);
	cdma_m_axi_wlast <= '0' when m_data_write_connected(4)='0' else m_axi_wlast(4);
	ram_m_axi_wvalid <= '0' when m_data_write_connected(0)='0' else m_axi_wvalid(0);
	int_m_axi_wvalid <= '0' when m_data_write_connected(1)='0' else m_axi_wvalid(1);
	timer_m_axi_wvalid <= '0' when m_data_write_connected(2)='0' else m_axi_wvalid(2);
	gpio_m_axi_wvalid <= '0' when m_data_write_connected(3)='0' else m_axi_wvalid(3);
	cdma_m_axi_wvalid <= '0' when m_data_write_connected(4)='0' else m_axi_wvalid(4);
	ram_m_axi_bready <= '0' when m_response_write_connected(0)='0' else m_axi_bready(0);
	int_m_axi_bready <= '0' when m_response_write_connected(1)='0' else m_axi_bready(1);
	timer_m_axi_bready <= '0' when m_response_write_connected(2)='0' else m_axi_bready(2);
	gpio_m_axi_bready <= '0' when m_response_write_connected(3)='0' else m_axi_bready(3);
	cdma_m_axi_bready <= '0' when m_response_write_connected(4)='0' else m_axi_bready(4);
	ram_m_axi_arid <= (others=>'0') when m_address_read_connected(0)='0' else m_axi_arid((1+0)*axi_master_id_width-1 downto 0*axi_master_id_width);
	int_m_axi_arid <= (others=>'0') when m_address_read_connected(1)='0' else m_axi_arid((1+1)*axi_master_id_width-1 downto 1*axi_master_id_width);
	timer_m_axi_arid <= (others=>'0') when m_address_read_connected(2)='0' else m_axi_arid((1+2)*axi_master_id_width-1 downto 2*axi_master_id_width);
	gpio_m_axi_arid <= (others=>'0') when m_address_read_connected(3)='0' else m_axi_arid((1+3)*axi_master_id_width-1 downto 3*axi_master_id_width);
	cdma_m_axi_arid <= (others=>'0') when m_address_read_connected(4)='0' else m_axi_arid((1+4)*axi_master_id_width-1 downto 4*axi_master_id_width);
	ram_m_axi_araddr <= (others=>'0') when m_address_read_connected(0)='0' else m_axi_araddr((1+0)*axi_address_width-1 downto 0*axi_address_width);
	int_m_axi_araddr <= (others=>'0') when m_address_read_connected(1)='0' else m_axi_araddr((1+1)*axi_address_width-1 downto 1*axi_address_width);
	timer_m_axi_araddr <= (others=>'0') when m_address_read_connected(2)='0' else m_axi_araddr((1+2)*axi_address_width-1 downto 2*axi_address_width);
	gpio_m_axi_araddr <= (others=>'0') when m_address_read_connected(3)='0' else m_axi_araddr((1+3)*axi_address_width-1 downto 3*axi_address_width);
	cdma_m_axi_araddr <= (others=>'0') when m_address_read_connected(4)='0' else m_axi_araddr((1+4)*axi_address_width-1 downto 4*axi_address_width);
	ram_m_axi_arlen <= (others=>'0') when m_address_read_connected(0)='0' else m_axi_arlen((1+0)*8-1 downto 0*8);
	int_m_axi_arlen <= (others=>'0') when m_address_read_connected(1)='0' else m_axi_arlen((1+1)*8-1 downto 1*8);
	timer_m_axi_arlen <= (others=>'0') when m_address_read_connected(2)='0' else m_axi_arlen((1+2)*8-1 downto 2*8);
	gpio_m_axi_arlen <= (others=>'0') when m_address_read_connected(3)='0' else m_axi_arlen((1+3)*8-1 downto 3*8);
	cdma_m_axi_arlen <= (others=>'0') when m_address_read_connected(4)='0' else m_axi_arlen((1+4)*8-1 downto 4*8);
	ram_m_axi_arsize <= (others=>'0') when m_address_read_connected(0)='0' else m_axi_arsize((1+0)*3-1 downto 0*3);
	int_m_axi_arsize <= (others=>'0') when m_address_read_connected(1)='0' else m_axi_arsize((1+1)*3-1 downto 1*3);
	timer_m_axi_arsize <= (others=>'0') when m_address_read_connected(2)='0' else m_axi_arsize((1+2)*3-1 downto 2*3);
	gpio_m_axi_arsize <= (others=>'0') when m_address_read_connected(3)='0' else m_axi_arsize((1+3)*3-1 downto 3*3);
	cdma_m_axi_arsize <= (others=>'0') when m_address_read_connected(4)='0' else m_axi_arsize((1+4)*3-1 downto 4*3);
	ram_m_axi_arburst <= (others=>'0') when m_address_read_connected(0)='0' else m_axi_arburst((1+0)*2-1 downto 0*2);
	int_m_axi_arburst <= (others=>'0') when m_address_read_connected(1)='0' else m_axi_arburst((1+1)*2-1 downto 1*2);
	timer_m_axi_arburst <= (others=>'0') when m_address_read_connected(2)='0' else m_axi_arburst((1+2)*2-1 downto 2*2);
	gpio_m_axi_arburst <= (others=>'0') when m_address_read_connected(3)='0' else m_axi_arburst((1+3)*2-1 downto 3*2);
	cdma_m_axi_arburst <= (others=>'0') when m_address_read_connected(4)='0' else m_axi_arburst((1+4)*2-1 downto 4*2);
	ram_m_axi_arlock <= '0' when m_address_read_connected(0)='0' else m_axi_arlock(0);
	int_m_axi_arlock <= '0' when m_address_read_connected(1)='0' else m_axi_arlock(1);
	timer_m_axi_arlock <= '0' when m_address_read_connected(2)='0' else m_axi_arlock(2);
	gpio_m_axi_arlock <= '0' when m_address_read_connected(3)='0' else m_axi_arlock(3);
	cdma_m_axi_arlock <= '0' when m_address_read_connected(4)='0' else m_axi_arlock(4);
	ram_m_axi_arcache <= (others=>'0') when m_address_read_connected(0)='0' else m_axi_arcache((1+0)*4-1 downto 0*4);
	int_m_axi_arcache <= (others=>'0') when m_address_read_connected(1)='0' else m_axi_arcache((1+1)*4-1 downto 1*4);
	timer_m_axi_arcache <= (others=>'0') when m_address_read_connected(2)='0' else m_axi_arcache((1+2)*4-1 downto 2*4);
	gpio_m_axi_arcache <= (others=>'0') when m_address_read_connected(3)='0' else m_axi_arcache((1+3)*4-1 downto 3*4);
	cdma_m_axi_arcache <= (others=>'0') when m_address_read_connected(4)='0' else m_axi_arcache((1+4)*4-1 downto 4*4);
	ram_m_axi_arprot <= (others=>'0') when m_address_read_connected(0)='0' else m_axi_arprot((1+0)*3-1 downto 0*3);
	int_m_axi_arprot <= (others=>'0') when m_address_read_connected(1)='0' else m_axi_arprot((1+1)*3-1 downto 1*3);
	timer_m_axi_arprot <= (others=>'0') when m_address_read_connected(2)='0' else m_axi_arprot((1+2)*3-1 downto 2*3);
	gpio_m_axi_arprot <= (others=>'0') when m_address_read_connected(3)='0' else m_axi_arprot((1+3)*3-1 downto 3*3);
	cdma_m_axi_arprot <= (others=>'0') when m_address_read_connected(4)='0' else m_axi_arprot((1+4)*3-1 downto 4*3);
	ram_m_axi_arqos <= (others=>'0') when m_address_read_connected(0)='0' else m_axi_arqos((1+0)*4-1 downto 0*4);
	int_m_axi_arqos <= (others=>'0') when m_address_read_connected(1)='0' else m_axi_arqos((1+1)*4-1 downto 1*4);
	timer_m_axi_arqos <= (others=>'0') when m_address_read_connected(2)='0' else m_axi_arqos((1+2)*4-1 downto 2*4);
	gpio_m_axi_arqos <= (others=>'0') when m_address_read_connected(3)='0' else m_axi_arqos((1+3)*4-1 downto 3*4);
	cdma_m_axi_arqos <= (others=>'0') when m_address_read_connected(4)='0' else m_axi_arqos((1+4)*4-1 downto 4*4);
	ram_m_axi_arregion <= (others=>'0') when m_address_read_connected(0)='0' else m_axi_arregion((1+0)*4-1 downto 0*4);
	int_m_axi_arregion <= (others=>'0') when m_address_read_connected(1)='0' else m_axi_arregion((1+1)*4-1 downto 1*4);
	timer_m_axi_arregion <= (others=>'0') when m_address_read_connected(2)='0' else m_axi_arregion((1+2)*4-1 downto 2*4);
	gpio_m_axi_arregion <= (others=>'0') when m_address_read_connected(3)='0' else m_axi_arregion((1+3)*4-1 downto 3*4);
	cdma_m_axi_arregion <= (others=>'0') when m_address_read_connected(4)='0' else m_axi_arregion((1+4)*4-1 downto 4*4);
	ram_m_axi_arvalid <= '0' when m_address_read_connected(0)='0' else m_axi_arvalid(0);
	int_m_axi_arvalid <= '0' when m_address_read_connected(1)='0' else m_axi_arvalid(1);
	timer_m_axi_arvalid <= '0' when m_address_read_connected(2)='0' else m_axi_arvalid(2);
	gpio_m_axi_arvalid <= '0' when m_address_read_connected(3)='0' else m_axi_arvalid(3);
	cdma_m_axi_arvalid <= '0' when m_address_read_connected(4)='0' else m_axi_arvalid(4);
	ram_m_axi_rready <= '0' when m_data_read_connected(0)='0' else m_axi_rready(0);
	int_m_axi_rready <= '0' when m_data_read_connected(1)='0' else m_axi_rready(1);
	timer_m_axi_rready <= '0' when m_data_read_connected(2)='0' else m_axi_rready(2);
	gpio_m_axi_rready <= '0' when m_data_read_connected(3)='0' else m_axi_rready(3);
	cdma_m_axi_rready <= '0' when m_data_read_connected(4)='0' else m_axi_rready(4);
	plasoc_crossbar_inst : plasoc_crossbar
		generic map
		(
			axi_address_width => axi_address_width,
			axi_data_width => axi_data_width,
			axi_master_amount => axi_master_amount,
			axi_slave_id_width => axi_slave_id_width,
			axi_slave_amount => axi_slave_amount,
			axi_master_base_address => axi_master_base_address,
			axi_master_high_address => axi_master_high_address
		)
		port map
		(
			aclk => aclk,
			aresetn => aresetn,
			s_address_write_connected => s_address_write_connected,
			s_data_write_connected => s_data_write_connected,
			s_response_write_connected => s_response_write_connected,
			s_address_read_connected => s_address_read_connected,
			s_data_read_connected => s_data_read_connected,
			m_address_write_connected => m_address_write_connected,
			m_data_write_connected => m_data_write_connected,
			m_response_write_connected => m_response_write_connected,
			m_address_read_connected => m_address_read_connected,
			m_data_read_connected => m_data_read_connected,
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
			s_axi_rready => s_axi_rready,
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
			m_axi_rready => m_axi_rready
	);
end Behavioral;
