library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.plasoc_cpu_pack.plasoc_cpu;
use work.plasoc_int_pack.plasoc_int;
use work.plasoc_int_pack.default_interrupt_total;
use work.plasoc_timer_pack.plasoc_timer;
use work.plasoc_gpio_pack.plasoc_gpio;
use work.plasoc_gpio_pack.default_data_out_width;
use work.plasoc_gpio_pack.default_data_in_width;
use work.plasoc_0_crossbar_wrap_pack.plasoc_0_crossbar_wrap; 
use work.plasoc_0_crossbar_wrap_pack.clogb2;
use work.plasoc_axi4_full2lite_pack.plasoc_axi4_full2lite;

entity axiplasma_wrapper is
    port( 
        raw_clock : in std_logic; -- 100 MHz on the Nexys 4.
        raw_nreset : in std_logic;
        gpio_output : out std_logic_vector(default_data_out_width-1 downto 0);
        gpio_input : in std_logic_vector(default_data_in_width-1 downto 0));
end axiplasma_wrapper;

architecture Behavioral of axiplasma_wrapper is
    -- Component declarations.
    component ram is      port(
        bram_rst_a : in STD_LOGIC;
        bram_clk_a : in STD_LOGIC;
        bram_en_a : in STD_LOGIC;
        bram_we_a : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        bram_addr_a : in STD_LOGIC_VECTOR(15 DOWNTO 0);
        bram_wrdata_a : in STD_LOGIC_VECTOR(31 DOWNTO 0);
        bram_rddata_a : out STD_LOGIC_VECTOR(31 DOWNTO 0));
    end component; 
    component axi_bram_address_cntrl is
        generic (
            axi_id_width : integer := 1;
            axi_address_width : integer := 16);
        port (
            aclk : in std_logic;
            aresetn : in std_logic;
            m_axi_awid : in std_logic_vector(axi_id_width-1 downto 0);
            m_axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);
            m_axi_awlen : in std_logic_vector(7 downto 0);
            m_axi_awsize : in std_logic_vector(2 downto 0);
            m_axi_awburst : in std_logic_vector(1 downto 0);
            m_axi_awlock : in std_logic;
            m_axi_awcache : in std_logic_vector(3 downto 0);
            m_axi_awprot : in std_logic_vector(2 downto 0);
            m_axi_awvalid : in std_logic;
            m_axi_awready : out std_logic;
            s_axi_awid : out std_logic_vector(axi_id_width-1 downto 0) := (others=>'0');
            s_axi_awaddr : out std_logic_vector(axi_address_width-1 downto 0) := (others=>'0');
            s_axi_awlen : out std_logic_vector(7 downto 0) := (others=>'0');
            s_axi_awsize : out std_logic_vector(2 downto 0) := (others=>'0');
            s_axi_awburst : out std_logic_vector(1 downto 0) := (others=>'0');
            s_axi_awlock : out std_logic := '0';
            s_axi_awcache : out std_logic_vector(3 downto 0) := (others=>'0');
            s_axi_awprot : out std_logic_vector(2 downto 0) := (others=>'0');
            s_axi_awvalid : out std_logic;
            s_axi_awready : in std_logic;
            m_axi_arid : in std_logic_vector(axi_id_width-1 downto 0);
            m_axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
            m_axi_arlen : in std_logic_vector(7 downto 0);
            m_axi_arsize : in std_logic_vector(2 downto 0);
            m_axi_arburst : in std_logic_vector(1 downto 0);
            m_axi_arlock : in std_logic;
            m_axi_arcache : in std_logic_vector(3 downto 0);
            m_axi_arprot : in std_logic_vector(2 downto 0);
            m_axi_arvalid : in std_logic;
            m_axi_arready : out std_logic;
            s_axi_arid : out std_logic_vector(axi_id_width-1 downto 0) := (others=>'0');
            s_axi_araddr : out std_logic_vector(axi_address_width-1 downto 0) := (others=>'0');
            s_axi_arlen : out std_logic_vector(7 downto 0) := (others=>'0');
            s_axi_arsize : out std_logic_vector(2 downto 0) := (others=>'0');
            s_axi_arburst : out std_logic_vector(1 downto 0) := (others=>'0');
            s_axi_arlock : out std_logic := '0';
            s_axi_arcache : out std_logic_vector(3 downto 0) := (others=>'0');
            s_axi_arprot : out std_logic_vector(2 downto 0) := (others=>'0');
            s_axi_arvalid : out std_logic;
            s_axi_arready : in std_logic);
    end component;
    component axi_cdma_0 IS
      PORT (
        m_axi_aclk : IN STD_LOGIC;
        s_axi_lite_aclk : IN STD_LOGIC;
        s_axi_lite_aresetn : IN STD_LOGIC;
        cdma_introut : OUT STD_LOGIC;
        s_axi_lite_awready : OUT STD_LOGIC;
        s_axi_lite_awvalid : IN STD_LOGIC;
        s_axi_lite_awaddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        s_axi_lite_wready : OUT STD_LOGIC;
        s_axi_lite_wvalid : IN STD_LOGIC;
        s_axi_lite_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_lite_bready : IN STD_LOGIC;
        s_axi_lite_bvalid : OUT STD_LOGIC;
        s_axi_lite_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_lite_arready : OUT STD_LOGIC;
        s_axi_lite_arvalid : IN STD_LOGIC;
        s_axi_lite_araddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        s_axi_lite_rready : IN STD_LOGIC;
        s_axi_lite_rvalid : OUT STD_LOGIC;
        s_axi_lite_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_lite_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_arready : IN STD_LOGIC;
        m_axi_arvalid : OUT STD_LOGIC;
        m_axi_araddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_arlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_arsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_arburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_arcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_rready : OUT STD_LOGIC;
        m_axi_rvalid : IN STD_LOGIC;
        m_axi_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_rlast : IN STD_LOGIC;
        m_axi_awready : IN STD_LOGIC;
        m_axi_awvalid : OUT STD_LOGIC;
        m_axi_awaddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_awlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        m_axi_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        m_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        m_axi_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_wready : IN STD_LOGIC;
        m_axi_wvalid : OUT STD_LOGIC;
        m_axi_wdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axi_wstrb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        m_axi_wlast : OUT STD_LOGIC;
        m_axi_bready : OUT STD_LOGIC;
        m_axi_bvalid : IN STD_LOGIC;
        m_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        cdma_tvect_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
    END component;
    component clk_wiz_0 is 
        port (            aclk : out std_logic;
            resetn : in std_logic;
            locked : out std_logic;
            raw_clock : in std_logic
        );
    end component;
    component proc_sys_reset_0 IS
      PORT (
        slowest_sync_clk : IN STD_LOGIC;
        ext_reset_in : IN STD_LOGIC;
        aux_reset_in : IN STD_LOGIC;
        mb_debug_sys_rst : IN STD_LOGIC;
        dcm_locked : IN STD_LOGIC;
        mb_reset : OUT STD_LOGIC;
        bus_struct_reset : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        peripheral_reset : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        interconnect_aresetn : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        peripheral_aresetn : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
      );
    END component;
    component axi_bram_ctrl_0 IS
      PORT (
        s_axi_aclk : IN STD_LOGIC;
        s_axi_aresetn : IN STD_LOGIC;
        s_axi_awid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_awaddr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axi_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_awlock : IN STD_LOGIC;
        s_axi_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_awvalid : IN STD_LOGIC;
        s_axi_awready : OUT STD_LOGIC;
        s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_wlast : IN STD_LOGIC;
        s_axi_wvalid : IN STD_LOGIC;
        s_axi_wready : OUT STD_LOGIC;
        s_axi_bid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_bvalid : OUT STD_LOGIC;
        s_axi_bready : IN STD_LOGIC;
        s_axi_arid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_araddr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axi_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_arlock : IN STD_LOGIC;
        s_axi_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_arvalid : IN STD_LOGIC;
        s_axi_arready : OUT STD_LOGIC;
        s_axi_rid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_rlast : OUT STD_LOGIC;
        s_axi_rvalid : OUT STD_LOGIC;
        s_axi_rready : IN STD_LOGIC;
        bram_rst_a : OUT STD_LOGIC;
        bram_clk_a : OUT STD_LOGIC;
        bram_en_a : OUT STD_LOGIC;
        bram_we_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        bram_addr_a : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        bram_wrdata_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        bram_rddata_a : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
    END component;
    constant axi_address_width : integer := 32;
    constant axi_data_width : integer := 32;
    constant axi_master_amount : integer := 2;
    constant axi_slave_amount : integer := 5;
    constant axi_master_id_width : integer := 0;
    constant axi_slave_id_width : integer := clogb2(axi_master_amount+1)+axi_master_id_width;
    constant axi_lite_address_width : integer := 16;
    signal aclk : std_logic;
    signal aresetn : std_logic_vector(0 downto 0);
    signal cross_aresetn : std_logic_vector(0 downto 0);
    signal dcm_locked : std_logic;
	signal cpu_axi_full_awid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal cpu_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_axi_full_awlen : std_logic_vector(7 downto 0);
    signal cpu_axi_full_awsize : std_logic_vector(2 downto 0);
    signal cpu_axi_full_awburst : std_logic_vector(1 downto 0);
    signal cpu_axi_full_awlock : std_logic;
    signal cpu_axi_full_awcache : std_logic_vector(3 downto 0);
    signal cpu_axi_full_awprot : std_logic_vector(2 downto 0);
    signal cpu_axi_full_awqos : std_logic_vector(3 downto 0);
    signal cpu_axi_full_awregion : std_logic_vector(3 downto 0);
    signal cpu_axi_full_awvalid : std_logic;
    signal cpu_axi_full_awready : std_logic;
    signal cpu_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cpu_axi_full_wlast : std_logic;
    signal cpu_axi_full_wvalid : std_logic;
    signal cpu_axi_full_wready : std_logic;
    signal cpu_axi_full_bid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal cpu_axi_full_bresp : std_logic_vector(1 downto 0);
    signal cpu_axi_full_bvalid : std_logic;
    signal cpu_axi_full_bready : std_logic;
    signal cpu_axi_full_arid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal cpu_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cpu_axi_full_arlen : std_logic_vector(7 downto 0);
    signal cpu_axi_full_arsize : std_logic_vector(2 downto 0);
    signal cpu_axi_full_arburst : std_logic_vector(1 downto 0);
    signal cpu_axi_full_arlock : std_logic;
    signal cpu_axi_full_arcache : std_logic_vector(3 downto 0);
    signal cpu_axi_full_arprot : std_logic_vector(2 downto 0);
    signal cpu_axi_full_arqos : std_logic_vector(3 downto 0);
    signal cpu_axi_full_arregion : std_logic_vector(3 downto 0);
    signal cpu_axi_full_arvalid : std_logic;
    signal cpu_axi_full_arready : std_logic;
    signal cpu_axi_full_rid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal cpu_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cpu_axi_full_rresp : std_logic_vector(1 downto 0);
    signal cpu_axi_full_rlast : std_logic;
    signal cpu_axi_full_rvalid : std_logic;
    signal cpu_axi_full_rready : std_logic;
    signal cdma_axi_full_awid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal cdma_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cdma_axi_full_awlen : std_logic_vector(7 downto 0);
    signal cdma_axi_full_awsize : std_logic_vector(2 downto 0);
    signal cdma_axi_full_awburst : std_logic_vector(1 downto 0);
    signal cdma_axi_full_awlock : std_logic;
    signal cdma_axi_full_awcache : std_logic_vector(3 downto 0);
    signal cdma_axi_full_awprot : std_logic_vector(2 downto 0);
    signal cdma_axi_full_awqos : std_logic_vector(3 downto 0);
    signal cdma_axi_full_awregion : std_logic_vector(3 downto 0);
    signal cdma_axi_full_awvalid : std_logic;
    signal cdma_axi_full_awready : std_logic;
    signal cdma_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cdma_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cdma_axi_full_wlast : std_logic;
    signal cdma_axi_full_wvalid : std_logic;
    signal cdma_axi_full_wready : std_logic;
    signal cdma_axi_full_bid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal cdma_axi_full_bresp : std_logic_vector(1 downto 0);
    signal cdma_axi_full_bvalid : std_logic;
    signal cdma_axi_full_bready : std_logic;
    signal cdma_axi_full_arid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal cdma_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cdma_axi_full_arlen : std_logic_vector(7 downto 0);
    signal cdma_axi_full_arsize : std_logic_vector(2 downto 0);
    signal cdma_axi_full_arburst : std_logic_vector(1 downto 0);
    signal cdma_axi_full_arlock : std_logic;
    signal cdma_axi_full_arcache : std_logic_vector(3 downto 0);
    signal cdma_axi_full_arprot : std_logic_vector(2 downto 0);
    signal cdma_axi_full_arqos : std_logic_vector(3 downto 0);
    signal cdma_axi_full_arregion : std_logic_vector(3 downto 0);
    signal cdma_axi_full_arvalid : std_logic;
    signal cdma_axi_full_arready : std_logic;
    signal cdma_axi_full_rid : std_logic_vector(axi_master_id_width-1 downto 0);
    signal cdma_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cdma_axi_full_rresp : std_logic_vector(1 downto 0);
    signal cdma_axi_full_rlast : std_logic;
    signal cdma_axi_full_rvalid : std_logic;
    signal cdma_axi_full_rready : std_logic;
    signal ram_axi_full_awid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal ram_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal ram_axi_full_awlen : std_logic_vector(7 downto 0);
    signal ram_axi_full_awsize : std_logic_vector(2 downto 0);
    signal ram_axi_full_awburst : std_logic_vector(1 downto 0);
    signal ram_axi_full_awlock : std_logic;
    signal ram_axi_full_awcache : std_logic_vector(3 downto 0);
    signal ram_axi_full_awprot : std_logic_vector(2 downto 0);
    signal ram_axi_full_awqos : std_logic_vector(3 downto 0);
    signal ram_axi_full_awregion : std_logic_vector(3 downto 0);
    signal ram_axi_full_awvalid : std_logic;
    signal ram_axi_full_awready : std_logic;
    signal ram_axi_full_awid_0 : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal ram_axi_full_awaddr_0 : std_logic_vector(axi_address_width-1 downto 0);
    signal ram_axi_full_awlen_0 : std_logic_vector(7 downto 0);
    signal ram_axi_full_awsize_0 : std_logic_vector(2 downto 0);
    signal ram_axi_full_awburst_0 : std_logic_vector(1 downto 0);
    signal ram_axi_full_awlock_0 : std_logic;
    signal ram_axi_full_awcache_0 : std_logic_vector(3 downto 0);
    signal ram_axi_full_awprot_0 : std_logic_vector(2 downto 0);
    signal ram_axi_full_awvalid_0 : std_logic;
    signal ram_axi_full_awready_0 : std_logic;
    signal ram_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal ram_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal ram_axi_full_wlast : std_logic;
    signal ram_axi_full_wvalid : std_logic;
    signal ram_axi_full_wready : std_logic;
    signal ram_axi_full_bid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal ram_axi_full_bresp : std_logic_vector(1 downto 0);
    signal ram_axi_full_bvalid : std_logic;
    signal ram_axi_full_bready : std_logic;
    signal ram_axi_full_arid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal ram_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal ram_axi_full_arlen : std_logic_vector(7 downto 0);
    signal ram_axi_full_arsize : std_logic_vector(2 downto 0);
    signal ram_axi_full_arburst : std_logic_vector(1 downto 0);
    signal ram_axi_full_arlock : std_logic;
    signal ram_axi_full_arcache : std_logic_vector(3 downto 0);
    signal ram_axi_full_arprot : std_logic_vector(2 downto 0);
    signal ram_axi_full_arqos : std_logic_vector(3 downto 0);
    signal ram_axi_full_arregion : std_logic_vector(3 downto 0);
    signal ram_axi_full_arvalid : std_logic;
    signal ram_axi_full_arready : std_logic;
    signal ram_axi_full_arid_0 : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal ram_axi_full_araddr_0 : std_logic_vector(axi_address_width-1 downto 0);
    signal ram_axi_full_arlen_0 : std_logic_vector(7 downto 0);
    signal ram_axi_full_arsize_0 : std_logic_vector(2 downto 0);
    signal ram_axi_full_arburst_0 : std_logic_vector(1 downto 0);
    signal ram_axi_full_arlock_0 : std_logic;
    signal ram_axi_full_arcache_0 : std_logic_vector(3 downto 0);
    signal ram_axi_full_arprot_0 : std_logic_vector(2 downto 0);
    signal ram_axi_full_arvalid_0 : std_logic;
    signal ram_axi_full_arready_0 : std_logic;
    signal ram_axi_full_rid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal ram_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal ram_axi_full_rresp : std_logic_vector(1 downto 0);
    signal ram_axi_full_rlast : std_logic;
    signal ram_axi_full_rvalid : std_logic;
    signal ram_axi_full_rready : std_logic;
    signal ram_bram_rst_a : STD_LOGIC;
    signal ram_bram_clk_a : STD_LOGIC;
    signal ram_bram_en_a : STD_LOGIC;
    signal ram_bram_we_a : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal ram_bram_addr_a : STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal ram_bram_wrdata_a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal ram_bram_rddata_a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal int_axi_full_awid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal int_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal int_axi_full_awlen : std_logic_vector(7 downto 0);
    signal int_axi_full_awsize : std_logic_vector(2 downto 0);
    signal int_axi_full_awburst : std_logic_vector(1 downto 0);
    signal int_axi_full_awlock : std_logic;
    signal int_axi_full_awcache : std_logic_vector(3 downto 0);
    signal int_axi_full_awprot : std_logic_vector(2 downto 0);
    signal int_axi_full_awqos : std_logic_vector(3 downto 0);
    signal int_axi_full_awregion : std_logic_vector(3 downto 0);
    signal int_axi_full_awvalid : std_logic;
    signal int_axi_full_awready : std_logic;
    signal int_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal int_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal int_axi_full_wlast : std_logic;
    signal int_axi_full_wvalid : std_logic;
    signal int_axi_full_wready : std_logic;
    signal int_axi_full_bid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal int_axi_full_bresp : std_logic_vector(1 downto 0);
    signal int_axi_full_bvalid : std_logic;
    signal int_axi_full_bready : std_logic;
    signal int_axi_full_arid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal int_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal int_axi_full_arlen : std_logic_vector(7 downto 0);
    signal int_axi_full_arsize : std_logic_vector(2 downto 0);
    signal int_axi_full_arburst : std_logic_vector(1 downto 0);
    signal int_axi_full_arlock : std_logic;
    signal int_axi_full_arcache : std_logic_vector(3 downto 0);
    signal int_axi_full_arprot : std_logic_vector(2 downto 0);
    signal int_axi_full_arqos : std_logic_vector(3 downto 0);
    signal int_axi_full_arregion : std_logic_vector(3 downto 0);
    signal int_axi_full_arvalid : std_logic;
    signal int_axi_full_arready : std_logic;
    signal int_axi_full_rid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal int_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal int_axi_full_rresp : std_logic_vector(1 downto 0);
    signal int_axi_full_rlast : std_logic;
    signal int_axi_full_rvalid : std_logic;
    signal int_axi_full_rready : std_logic;
    signal timer_axi_full_awid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal timer_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal timer_axi_full_awlen : std_logic_vector(7 downto 0);
    signal timer_axi_full_awsize : std_logic_vector(2 downto 0);
    signal timer_axi_full_awburst : std_logic_vector(1 downto 0);
    signal timer_axi_full_awlock : std_logic;
    signal timer_axi_full_awcache : std_logic_vector(3 downto 0);
    signal timer_axi_full_awprot : std_logic_vector(2 downto 0);
    signal timer_axi_full_awqos : std_logic_vector(3 downto 0);
    signal timer_axi_full_awregion : std_logic_vector(3 downto 0);
    signal timer_axi_full_awvalid : std_logic;
    signal timer_axi_full_awready : std_logic;
    signal timer_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal timer_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal timer_axi_full_wlast : std_logic;
    signal timer_axi_full_wvalid : std_logic;
    signal timer_axi_full_wready : std_logic;
    signal timer_axi_full_bid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal timer_axi_full_bresp : std_logic_vector(1 downto 0);
    signal timer_axi_full_bvalid : std_logic;
    signal timer_axi_full_bready : std_logic;
    signal timer_axi_full_arid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal timer_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal timer_axi_full_arlen : std_logic_vector(7 downto 0);
    signal timer_axi_full_arsize : std_logic_vector(2 downto 0);
    signal timer_axi_full_arburst : std_logic_vector(1 downto 0);
    signal timer_axi_full_arlock : std_logic;
    signal timer_axi_full_arcache : std_logic_vector(3 downto 0);
    signal timer_axi_full_arprot : std_logic_vector(2 downto 0);
    signal timer_axi_full_arqos : std_logic_vector(3 downto 0);
    signal timer_axi_full_arregion : std_logic_vector(3 downto 0);
    signal timer_axi_full_arvalid : std_logic;
    signal timer_axi_full_arready : std_logic;
    signal timer_axi_full_rid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal timer_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal timer_axi_full_rresp : std_logic_vector(1 downto 0);
    signal timer_axi_full_rlast : std_logic;
    signal timer_axi_full_rvalid : std_logic;
    signal timer_axi_full_rready : std_logic;
    signal gpio_axi_full_awid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal gpio_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal gpio_axi_full_awlen : std_logic_vector(7 downto 0);
    signal gpio_axi_full_awsize : std_logic_vector(2 downto 0);
    signal gpio_axi_full_awburst : std_logic_vector(1 downto 0);
    signal gpio_axi_full_awlock : std_logic;
    signal gpio_axi_full_awcache : std_logic_vector(3 downto 0);
    signal gpio_axi_full_awprot : std_logic_vector(2 downto 0);
    signal gpio_axi_full_awqos : std_logic_vector(3 downto 0);
    signal gpio_axi_full_awregion : std_logic_vector(3 downto 0);
    signal gpio_axi_full_awvalid : std_logic;
    signal gpio_axi_full_awready : std_logic;
    signal gpio_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal gpio_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal gpio_axi_full_wlast : std_logic;
    signal gpio_axi_full_wvalid : std_logic;
    signal gpio_axi_full_wready : std_logic;
    signal gpio_axi_full_bid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal gpio_axi_full_bresp : std_logic_vector(1 downto 0);
    signal gpio_axi_full_bvalid : std_logic;
    signal gpio_axi_full_bready : std_logic;
    signal gpio_axi_full_arid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal gpio_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal gpio_axi_full_arlen : std_logic_vector(7 downto 0);
    signal gpio_axi_full_arsize : std_logic_vector(2 downto 0);
    signal gpio_axi_full_arburst : std_logic_vector(1 downto 0);
    signal gpio_axi_full_arlock : std_logic;
    signal gpio_axi_full_arcache : std_logic_vector(3 downto 0);
    signal gpio_axi_full_arprot : std_logic_vector(2 downto 0);
    signal gpio_axi_full_arqos : std_logic_vector(3 downto 0);
    signal gpio_axi_full_arregion : std_logic_vector(3 downto 0);
    signal gpio_axi_full_arvalid : std_logic;
    signal gpio_axi_full_arready : std_logic;
    signal gpio_axi_full_rid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal gpio_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal gpio_axi_full_rresp : std_logic_vector(1 downto 0);
    signal gpio_axi_full_rlast : std_logic;
    signal gpio_axi_full_rvalid : std_logic;
    signal gpio_axi_full_rready : std_logic;
    signal cdmareg_axi_full_awid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal cdmareg_axi_full_awaddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cdmareg_axi_full_awlen : std_logic_vector(7 downto 0);
    signal cdmareg_axi_full_awsize : std_logic_vector(2 downto 0);
    signal cdmareg_axi_full_awburst : std_logic_vector(1 downto 0);
    signal cdmareg_axi_full_awlock : std_logic;
    signal cdmareg_axi_full_awcache : std_logic_vector(3 downto 0);
    signal cdmareg_axi_full_awprot : std_logic_vector(2 downto 0);
    signal cdmareg_axi_full_awqos : std_logic_vector(3 downto 0);
    signal cdmareg_axi_full_awregion : std_logic_vector(3 downto 0);
    signal cdmareg_axi_full_awvalid : std_logic;
    signal cdmareg_axi_full_awready : std_logic;
    signal cdmareg_axi_full_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cdmareg_axi_full_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cdmareg_axi_full_wlast : std_logic;
    signal cdmareg_axi_full_wvalid : std_logic;
    signal cdmareg_axi_full_wready : std_logic;
    signal cdmareg_axi_full_bid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal cdmareg_axi_full_bresp : std_logic_vector(1 downto 0);
    signal cdmareg_axi_full_bvalid : std_logic;
    signal cdmareg_axi_full_bready : std_logic;
    signal cdmareg_axi_full_arid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal cdmareg_axi_full_araddr : std_logic_vector(axi_address_width-1 downto 0);
    signal cdmareg_axi_full_arlen : std_logic_vector(7 downto 0);
    signal cdmareg_axi_full_arsize : std_logic_vector(2 downto 0);
    signal cdmareg_axi_full_arburst : std_logic_vector(1 downto 0);
    signal cdmareg_axi_full_arlock : std_logic;
    signal cdmareg_axi_full_arcache : std_logic_vector(3 downto 0);
    signal cdmareg_axi_full_arprot : std_logic_vector(2 downto 0);
    signal cdmareg_axi_full_arqos : std_logic_vector(3 downto 0);
    signal cdmareg_axi_full_arregion : std_logic_vector(3 downto 0);
    signal cdmareg_axi_full_arvalid : std_logic;
    signal cdmareg_axi_full_arready : std_logic;
    signal cdmareg_axi_full_rid : std_logic_vector((clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);
    signal cdmareg_axi_full_rdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cdmareg_axi_full_rresp : std_logic_vector(1 downto 0);
    signal cdmareg_axi_full_rlast : std_logic;
    signal cdmareg_axi_full_rvalid : std_logic;
    signal cdmareg_axi_full_rready : std_logic;
    signal int_axi_lite_awaddr : std_logic_vector(axi_lite_address_width-1 downto 0);
    signal int_axi_lite_awprot : std_logic_vector(2 downto 0);
    signal int_axi_lite_awvalid : std_logic;
    signal int_axi_lite_awready : std_logic;
    signal int_axi_lite_wvalid : std_logic;
    signal int_axi_lite_wready : std_logic;
    signal int_axi_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal int_axi_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal int_axi_lite_bvalid : std_logic;
    signal int_axi_lite_bready : std_logic;
    signal int_axi_lite_bresp : std_logic_vector(1 downto 0);
    signal int_axi_lite_araddr : std_logic_vector(axi_lite_address_width-1 downto 0);
    signal int_axi_lite_arprot : std_logic_vector(2 downto 0);
    signal int_axi_lite_arvalid : std_logic;
    signal int_axi_lite_arready : std_logic;
    signal int_axi_lite_rdata : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    signal int_axi_lite_rvalid : std_logic;
    signal int_axi_lite_rready : std_logic;
    signal int_axi_lite_rresp : std_logic_vector(1 downto 0);
    signal timer_axi_lite_awaddr : std_logic_vector(axi_lite_address_width-1 downto 0);
    signal timer_axi_lite_awprot : std_logic_vector(2 downto 0);
    signal timer_axi_lite_awvalid : std_logic;
    signal timer_axi_lite_awready : std_logic;
    signal timer_axi_lite_wvalid : std_logic;
    signal timer_axi_lite_wready : std_logic;
    signal timer_axi_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal timer_axi_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal timer_axi_lite_bvalid : std_logic;
    signal timer_axi_lite_bready : std_logic;
    signal timer_axi_lite_bresp : std_logic_vector(1 downto 0);
    signal timer_axi_lite_araddr : std_logic_vector(axi_lite_address_width-1 downto 0);
    signal timer_axi_lite_arprot : std_logic_vector(2 downto 0);
    signal timer_axi_lite_arvalid : std_logic;
    signal timer_axi_lite_arready : std_logic;
    signal timer_axi_lite_rdata : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    signal timer_axi_lite_rvalid : std_logic;
    signal timer_axi_lite_rready : std_logic;
    signal timer_axi_lite_rresp : std_logic_vector(1 downto 0);
    signal gpio_axi_lite_awaddr : std_logic_vector(axi_lite_address_width-1 downto 0);
    signal gpio_axi_lite_awprot : std_logic_vector(2 downto 0);
    signal gpio_axi_lite_awvalid : std_logic;
    signal gpio_axi_lite_awready : std_logic;
    signal gpio_axi_lite_wvalid : std_logic;
    signal gpio_axi_lite_wready : std_logic;
    signal gpio_axi_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal gpio_axi_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal gpio_axi_lite_bvalid : std_logic;
    signal gpio_axi_lite_bready : std_logic;
    signal gpio_axi_lite_bresp : std_logic_vector(1 downto 0);
    signal gpio_axi_lite_araddr : std_logic_vector(axi_lite_address_width-1 downto 0);
    signal gpio_axi_lite_arprot : std_logic_vector(2 downto 0);
    signal gpio_axi_lite_arvalid : std_logic;
    signal gpio_axi_lite_arready : std_logic;
    signal gpio_axi_lite_rdata : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    signal gpio_axi_lite_rvalid : std_logic;
    signal gpio_axi_lite_rready : std_logic;
    signal gpio_axi_lite_rresp : std_logic_vector(1 downto 0);
    signal cdmareg_axi_lite_awaddr : std_logic_vector(axi_lite_address_width-1 downto 0);
    signal cdmareg_axi_lite_awprot : std_logic_vector(2 downto 0);
    signal cdmareg_axi_lite_awvalid : std_logic;
    signal cdmareg_axi_lite_awready : std_logic;
    signal cdmareg_axi_lite_wvalid : std_logic;
    signal cdmareg_axi_lite_wready : std_logic;
    signal cdmareg_axi_lite_wdata : std_logic_vector(axi_data_width-1 downto 0);
    signal cdmareg_axi_lite_wstrb : std_logic_vector(axi_data_width/8-1 downto 0);
    signal cdmareg_axi_lite_bvalid : std_logic;
    signal cdmareg_axi_lite_bready : std_logic;
    signal cdmareg_axi_lite_bresp : std_logic_vector(1 downto 0);
    signal cdmareg_axi_lite_araddr : std_logic_vector(axi_lite_address_width-1 downto 0);
    signal cdmareg_axi_lite_arprot : std_logic_vector(2 downto 0);
    signal cdmareg_axi_lite_arvalid : std_logic;
    signal cdmareg_axi_lite_arready : std_logic;
    signal cdmareg_axi_lite_rdata : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    signal cdmareg_axi_lite_rvalid : std_logic;
    signal cdmareg_axi_lite_rready : std_logic;
    signal cdmareg_axi_lite_rresp : std_logic_vector(1 downto 0);
    signal cpu_int : std_logic;
    signal int_dev_ints : std_logic_vector(default_interrupt_total-1 downto 0);
    signal timer_int : std_logic;
    signal gpio_int : std_logic;
    signal cdma_int : std_logic;
begin
    int_dev_ints(0) <= timer_int;
    int_dev_ints(1) <= gpio_int;
    int_dev_ints(2) <= cdma_int;

    -- Clock instantiation.
     clk_wiz_inst : clk_wiz_0  
        port map (            
            aclk => aclk,
            resetn => raw_nreset,
            locked => dcm_locked,
            raw_clock => raw_clock);
            
    -- Reset core instantiation.
    proc_sys_reset_inst : proc_sys_reset_0 
          PORT map (
            slowest_sync_clk => aclk,
            ext_reset_in => raw_nreset,
            aux_reset_in => '0',
            mb_debug_sys_rst => '0',
            dcm_locked => dcm_locked,
            mb_reset => open,
            bus_struct_reset => open,
            peripheral_reset => open,
            interconnect_aresetn => cross_aresetn,
            peripheral_aresetn => aresetn);
            
    -- Crossbar instantiation.
    plasoc_0_crossbar_wrap_inst : plasoc_0_crossbar_wrap
        port map (
            cpu_m_axi_awid => cpu_axi_full_awid,
            cpu_m_axi_awaddr => cpu_axi_full_awaddr,
            cpu_m_axi_awlen => cpu_axi_full_awlen,
            cpu_m_axi_awsize => cpu_axi_full_awsize,
            cpu_m_axi_awburst => cpu_axi_full_awburst,
            cpu_m_axi_awlock => cpu_axi_full_awlock,
            cpu_m_axi_awcache => cpu_axi_full_awcache,
            cpu_m_axi_awprot => cpu_axi_full_awprot,
            cpu_m_axi_awqos => cpu_axi_full_awqos,
            cpu_m_axi_awregion => cpu_axi_full_awregion,
            cpu_m_axi_awvalid => cpu_axi_full_awvalid,
            cpu_m_axi_awready => cpu_axi_full_awready,
            cpu_m_axi_wdata => cpu_axi_full_wdata,
            cpu_m_axi_wstrb => cpu_axi_full_wstrb,
            cpu_m_axi_wlast => cpu_axi_full_wlast,
            cpu_m_axi_wvalid => cpu_axi_full_wvalid,
            cpu_m_axi_wready => cpu_axi_full_wready,
            cpu_m_axi_bid => cpu_axi_full_bid,
            cpu_m_axi_bresp => cpu_axi_full_bresp,
            cpu_m_axi_bvalid => cpu_axi_full_bvalid,
            cpu_m_axi_bready => cpu_axi_full_bready,
            cpu_m_axi_arid => cpu_axi_full_arid,
            cpu_m_axi_araddr => cpu_axi_full_araddr,
            cpu_m_axi_arlen => cpu_axi_full_arlen,
            cpu_m_axi_arsize => cpu_axi_full_arsize,
            cpu_m_axi_arburst => cpu_axi_full_arburst,
            cpu_m_axi_arlock => cpu_axi_full_arlock,
            cpu_m_axi_arcache => cpu_axi_full_arcache,
            cpu_m_axi_arprot => cpu_axi_full_arprot,
            cpu_m_axi_arqos => cpu_axi_full_arqos,
            cpu_m_axi_arregion => cpu_axi_full_arregion,
            cpu_m_axi_arvalid => cpu_axi_full_arvalid,
            cpu_m_axi_arready => cpu_axi_full_arready,
            cpu_m_axi_rid => cpu_axi_full_rid,
            cpu_m_axi_rdata => cpu_axi_full_rdata,
            cpu_m_axi_rresp => cpu_axi_full_rresp,
            cpu_m_axi_rlast => cpu_axi_full_rlast,
            cpu_m_axi_rvalid => cpu_axi_full_rvalid,
            cpu_m_axi_rready => cpu_axi_full_rready,
            cdma_m_axi_awid => cdma_axi_full_awid,
            cdma_m_axi_awaddr => cdma_axi_full_awaddr,
            cdma_m_axi_awlen => cdma_axi_full_awlen,
            cdma_m_axi_awsize => cdma_axi_full_awsize,
            cdma_m_axi_awburst => cdma_axi_full_awburst,
            cdma_m_axi_awlock => cdma_axi_full_awlock,
            cdma_m_axi_awcache => cdma_axi_full_awcache,
            cdma_m_axi_awprot => cdma_axi_full_awprot,
            cdma_m_axi_awqos => cdma_axi_full_awqos,
            cdma_m_axi_awregion => cdma_axi_full_awregion,
            cdma_m_axi_awvalid => cdma_axi_full_awvalid,
            cdma_m_axi_awready => cdma_axi_full_awready,
            cdma_m_axi_wdata => cdma_axi_full_wdata,
            cdma_m_axi_wstrb => cdma_axi_full_wstrb,
            cdma_m_axi_wlast => cdma_axi_full_wlast,
            cdma_m_axi_wvalid => cdma_axi_full_wvalid,
            cdma_m_axi_wready => cdma_axi_full_wready,
            cdma_m_axi_bid => cdma_axi_full_bid,
            cdma_m_axi_bresp => cdma_axi_full_bresp,
            cdma_m_axi_bvalid => cdma_axi_full_bvalid,
            cdma_m_axi_bready => cdma_axi_full_bready,
            cdma_m_axi_arid => cdma_axi_full_arid,
            cdma_m_axi_araddr => cdma_axi_full_araddr,
            cdma_m_axi_arlen => cdma_axi_full_arlen,
            cdma_m_axi_arsize => cdma_axi_full_arsize,
            cdma_m_axi_arburst => cdma_axi_full_arburst,
            cdma_m_axi_arlock => cdma_axi_full_arlock,
            cdma_m_axi_arcache => cdma_axi_full_arcache,
            cdma_m_axi_arprot => cdma_axi_full_arprot,
            cdma_m_axi_arqos => cdma_axi_full_arqos,
            cdma_m_axi_arregion => cdma_axi_full_arregion,
            cdma_m_axi_arvalid => cdma_axi_full_arvalid,
            cdma_m_axi_arready => cdma_axi_full_arready,
            cdma_m_axi_rid => cdma_axi_full_rid,
            cdma_m_axi_rdata => cdma_axi_full_rdata,
            cdma_m_axi_rresp => cdma_axi_full_rresp,
            cdma_m_axi_rlast => cdma_axi_full_rlast,
            cdma_m_axi_rvalid => cdma_axi_full_rvalid,
            cdma_m_axi_rready => cdma_axi_full_rready,
            ram_s_axi_awid => ram_axi_full_awid,
            ram_s_axi_awaddr => ram_axi_full_awaddr,
            ram_s_axi_awlen => ram_axi_full_awlen,
            ram_s_axi_awsize => ram_axi_full_awsize,
            ram_s_axi_awburst => ram_axi_full_awburst,
            ram_s_axi_awlock => ram_axi_full_awlock,
            ram_s_axi_awcache => ram_axi_full_awcache,
            ram_s_axi_awprot => ram_axi_full_awprot,
            ram_s_axi_awqos => ram_axi_full_awqos,
            ram_s_axi_awregion => ram_axi_full_awregion,
            ram_s_axi_awvalid => ram_axi_full_awvalid,
            ram_s_axi_awready => ram_axi_full_awready,
            ram_s_axi_wdata => ram_axi_full_wdata,
            ram_s_axi_wstrb => ram_axi_full_wstrb,
            ram_s_axi_wlast => ram_axi_full_wlast,
            ram_s_axi_wvalid => ram_axi_full_wvalid,
            ram_s_axi_wready => ram_axi_full_wready,
            ram_s_axi_bid => ram_axi_full_bid,
            ram_s_axi_bresp => ram_axi_full_bresp,
            ram_s_axi_bvalid => ram_axi_full_bvalid,
            ram_s_axi_bready => ram_axi_full_bready,
            ram_s_axi_arid => ram_axi_full_arid,
            ram_s_axi_araddr => ram_axi_full_araddr,
            ram_s_axi_arlen => ram_axi_full_arlen,
            ram_s_axi_arsize => ram_axi_full_arsize,
            ram_s_axi_arburst => ram_axi_full_arburst,
            ram_s_axi_arlock => ram_axi_full_arlock,
            ram_s_axi_arcache => ram_axi_full_arcache,
            ram_s_axi_arprot => ram_axi_full_arprot,
            ram_s_axi_arqos => ram_axi_full_arqos,
            ram_s_axi_arregion => ram_axi_full_arregion,
            ram_s_axi_arvalid => ram_axi_full_arvalid,
            ram_s_axi_arready => ram_axi_full_arready,
            ram_s_axi_rid => ram_axi_full_rid,
            ram_s_axi_rdata => ram_axi_full_rdata,
            ram_s_axi_rresp => ram_axi_full_rresp,
            ram_s_axi_rlast => ram_axi_full_rlast,
            ram_s_axi_rvalid => ram_axi_full_rvalid,
            ram_s_axi_rready => ram_axi_full_rready,
            int_s_axi_awid => int_axi_full_awid,
            int_s_axi_awaddr => int_axi_full_awaddr,
            int_s_axi_awlen => int_axi_full_awlen,
            int_s_axi_awsize => int_axi_full_awsize,
            int_s_axi_awburst => int_axi_full_awburst,
            int_s_axi_awlock => int_axi_full_awlock,
            int_s_axi_awcache => int_axi_full_awcache,
            int_s_axi_awprot => int_axi_full_awprot,
            int_s_axi_awqos => int_axi_full_awqos,
            int_s_axi_awregion => int_axi_full_awregion,
            int_s_axi_awvalid => int_axi_full_awvalid,
            int_s_axi_awready => int_axi_full_awready,
            int_s_axi_wdata => int_axi_full_wdata,
            int_s_axi_wstrb => int_axi_full_wstrb,
            int_s_axi_wlast => int_axi_full_wlast,
            int_s_axi_wvalid => int_axi_full_wvalid,
            int_s_axi_wready => int_axi_full_wready,
            int_s_axi_bid => int_axi_full_bid,
            int_s_axi_bresp => int_axi_full_bresp,
            int_s_axi_bvalid => int_axi_full_bvalid,
            int_s_axi_bready => int_axi_full_bready,
            int_s_axi_arid => int_axi_full_arid,
            int_s_axi_araddr => int_axi_full_araddr,
            int_s_axi_arlen => int_axi_full_arlen,
            int_s_axi_arsize => int_axi_full_arsize,
            int_s_axi_arburst => int_axi_full_arburst,
            int_s_axi_arlock => int_axi_full_arlock,
            int_s_axi_arcache => int_axi_full_arcache,
            int_s_axi_arprot => int_axi_full_arprot,
            int_s_axi_arqos => int_axi_full_arqos,
            int_s_axi_arregion => int_axi_full_arregion,
            int_s_axi_arvalid => int_axi_full_arvalid,
            int_s_axi_arready => int_axi_full_arready,
            int_s_axi_rid => int_axi_full_rid,
            int_s_axi_rdata => int_axi_full_rdata,
            int_s_axi_rresp => int_axi_full_rresp,
            int_s_axi_rlast => int_axi_full_rlast,
            int_s_axi_rvalid => int_axi_full_rvalid,
            int_s_axi_rready => int_axi_full_rready,
            timer_s_axi_awid => timer_axi_full_awid,
            timer_s_axi_awaddr => timer_axi_full_awaddr,
            timer_s_axi_awlen => timer_axi_full_awlen,
            timer_s_axi_awsize => timer_axi_full_awsize,
            timer_s_axi_awburst => timer_axi_full_awburst,
            timer_s_axi_awlock => timer_axi_full_awlock,
            timer_s_axi_awcache => timer_axi_full_awcache,
            timer_s_axi_awprot => timer_axi_full_awprot,
            timer_s_axi_awqos => timer_axi_full_awqos,
            timer_s_axi_awregion => timer_axi_full_awregion,
            timer_s_axi_awvalid => timer_axi_full_awvalid,
            timer_s_axi_awready => timer_axi_full_awready,
            timer_s_axi_wdata => timer_axi_full_wdata,
            timer_s_axi_wstrb => timer_axi_full_wstrb,
            timer_s_axi_wlast => timer_axi_full_wlast,
            timer_s_axi_wvalid => timer_axi_full_wvalid,
            timer_s_axi_wready => timer_axi_full_wready,
            timer_s_axi_bid => timer_axi_full_bid,
            timer_s_axi_bresp => timer_axi_full_bresp,
            timer_s_axi_bvalid => timer_axi_full_bvalid,
            timer_s_axi_bready => timer_axi_full_bready,
            timer_s_axi_arid => timer_axi_full_arid,
            timer_s_axi_araddr => timer_axi_full_araddr,
            timer_s_axi_arlen => timer_axi_full_arlen,
            timer_s_axi_arsize => timer_axi_full_arsize,
            timer_s_axi_arburst => timer_axi_full_arburst,
            timer_s_axi_arlock => timer_axi_full_arlock,
            timer_s_axi_arcache => timer_axi_full_arcache,
            timer_s_axi_arprot => timer_axi_full_arprot,
            timer_s_axi_arqos => timer_axi_full_arqos,
            timer_s_axi_arregion => timer_axi_full_arregion,
            timer_s_axi_arvalid => timer_axi_full_arvalid,
            timer_s_axi_arready => timer_axi_full_arready,
            timer_s_axi_rid => timer_axi_full_rid,
            timer_s_axi_rdata => timer_axi_full_rdata,
            timer_s_axi_rresp => timer_axi_full_rresp,
            timer_s_axi_rlast => timer_axi_full_rlast,
            timer_s_axi_rvalid => timer_axi_full_rvalid,
            timer_s_axi_rready => timer_axi_full_rready,
            gpio_s_axi_awid => gpio_axi_full_awid,
            gpio_s_axi_awaddr => gpio_axi_full_awaddr,
            gpio_s_axi_awlen => gpio_axi_full_awlen,
            gpio_s_axi_awsize => gpio_axi_full_awsize,
            gpio_s_axi_awburst => gpio_axi_full_awburst,
            gpio_s_axi_awlock => gpio_axi_full_awlock,
            gpio_s_axi_awcache => gpio_axi_full_awcache,
            gpio_s_axi_awprot => gpio_axi_full_awprot,
            gpio_s_axi_awqos => gpio_axi_full_awqos,
            gpio_s_axi_awregion => gpio_axi_full_awregion,
            gpio_s_axi_awvalid => gpio_axi_full_awvalid,
            gpio_s_axi_awready => gpio_axi_full_awready,
            gpio_s_axi_wdata => gpio_axi_full_wdata,
            gpio_s_axi_wstrb => gpio_axi_full_wstrb,
            gpio_s_axi_wlast => gpio_axi_full_wlast,
            gpio_s_axi_wvalid => gpio_axi_full_wvalid,
            gpio_s_axi_wready => gpio_axi_full_wready,
            gpio_s_axi_bid => gpio_axi_full_bid,
            gpio_s_axi_bresp => gpio_axi_full_bresp,
            gpio_s_axi_bvalid => gpio_axi_full_bvalid,
            gpio_s_axi_bready => gpio_axi_full_bready,
            gpio_s_axi_arid => gpio_axi_full_arid,
            gpio_s_axi_araddr => gpio_axi_full_araddr,
            gpio_s_axi_arlen => gpio_axi_full_arlen,
            gpio_s_axi_arsize => gpio_axi_full_arsize,
            gpio_s_axi_arburst => gpio_axi_full_arburst,
            gpio_s_axi_arlock => gpio_axi_full_arlock,
            gpio_s_axi_arcache => gpio_axi_full_arcache,
            gpio_s_axi_arprot => gpio_axi_full_arprot,
            gpio_s_axi_arqos => gpio_axi_full_arqos,
            gpio_s_axi_arregion => gpio_axi_full_arregion,
            gpio_s_axi_arvalid => gpio_axi_full_arvalid,
            gpio_s_axi_arready => gpio_axi_full_arready,
            gpio_s_axi_rid => gpio_axi_full_rid,
            gpio_s_axi_rdata => gpio_axi_full_rdata,
            gpio_s_axi_rresp => gpio_axi_full_rresp,
            gpio_s_axi_rlast => gpio_axi_full_rlast,
            gpio_s_axi_rvalid => gpio_axi_full_rvalid,
            gpio_s_axi_rready => gpio_axi_full_rready,
            cdma_s_axi_awid => cdmareg_axi_full_awid,
            cdma_s_axi_awaddr => cdmareg_axi_full_awaddr,
            cdma_s_axi_awlen => cdmareg_axi_full_awlen,
            cdma_s_axi_awsize => cdmareg_axi_full_awsize,
            cdma_s_axi_awburst => cdmareg_axi_full_awburst,
            cdma_s_axi_awlock => cdmareg_axi_full_awlock,
            cdma_s_axi_awcache => cdmareg_axi_full_awcache,
            cdma_s_axi_awprot => cdmareg_axi_full_awprot,
            cdma_s_axi_awqos => cdmareg_axi_full_awqos,
            cdma_s_axi_awregion => cdmareg_axi_full_awregion,
            cdma_s_axi_awvalid => cdmareg_axi_full_awvalid,
            cdma_s_axi_awready => cdmareg_axi_full_awready,
            cdma_s_axi_wdata => cdmareg_axi_full_wdata,
            cdma_s_axi_wstrb => cdmareg_axi_full_wstrb,
            cdma_s_axi_wlast => cdmareg_axi_full_wlast,
            cdma_s_axi_wvalid => cdmareg_axi_full_wvalid,
            cdma_s_axi_wready => cdmareg_axi_full_wready,
            cdma_s_axi_bid => cdmareg_axi_full_bid,
            cdma_s_axi_bresp => cdmareg_axi_full_bresp,
            cdma_s_axi_bvalid => cdmareg_axi_full_bvalid,
            cdma_s_axi_bready => cdmareg_axi_full_bready,
            cdma_s_axi_arid => cdmareg_axi_full_arid,
            cdma_s_axi_araddr => cdmareg_axi_full_araddr,
            cdma_s_axi_arlen => cdmareg_axi_full_arlen,
            cdma_s_axi_arsize => cdmareg_axi_full_arsize,
            cdma_s_axi_arburst => cdmareg_axi_full_arburst,
            cdma_s_axi_arlock => cdmareg_axi_full_arlock,
            cdma_s_axi_arcache => cdmareg_axi_full_arcache,
            cdma_s_axi_arprot => cdmareg_axi_full_arprot,
            cdma_s_axi_arqos => cdmareg_axi_full_arqos,
            cdma_s_axi_arregion => cdmareg_axi_full_arregion,
            cdma_s_axi_arvalid => cdmareg_axi_full_arvalid,
            cdma_s_axi_arready => cdmareg_axi_full_arready,
            cdma_s_axi_rid => cdmareg_axi_full_rid,
            cdma_s_axi_rdata => cdmareg_axi_full_rdata,
            cdma_s_axi_rresp => cdmareg_axi_full_rresp,
            cdma_s_axi_rlast => cdmareg_axi_full_rlast,
            cdma_s_axi_rvalid => cdmareg_axi_full_rvalid,
            cdma_s_axi_rready => cdmareg_axi_full_rready,
            aresetn => cross_aresetn(0),
            aclk => aclk);
        
    plasoc_cpu_inst : plasoc_cpu
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            intr_in => cpu_int,
            axi_awid => cpu_axi_full_awid,
            axi_awaddr => cpu_axi_full_awaddr,
            axi_awlen => cpu_axi_full_awlen,
            axi_awsize => cpu_axi_full_awsize,
            axi_awburst => cpu_axi_full_awburst,
            axi_awlock => cpu_axi_full_awlock,
            axi_awcache => cpu_axi_full_awcache,
            axi_awprot => cpu_axi_full_awprot,
            axi_awqos => cpu_axi_full_awqos,
            axi_awregion => cpu_axi_full_awregion,
            axi_awvalid => cpu_axi_full_awvalid,
            axi_awready => cpu_axi_full_awready,
            axi_wdata => cpu_axi_full_wdata,
            axi_wstrb => cpu_axi_full_wstrb,
            axi_wlast => cpu_axi_full_wlast,
            axi_wvalid => cpu_axi_full_wvalid,
            axi_wready => cpu_axi_full_wready,
            axi_bid => cpu_axi_full_bid,
            axi_bresp => cpu_axi_full_bresp,
            axi_bvalid => cpu_axi_full_bvalid,
            axi_bready => cpu_axi_full_bready,
            axi_arid => cpu_axi_full_arid,
            axi_araddr => cpu_axi_full_araddr,
            axi_arlen => cpu_axi_full_arlen,
            axi_arsize => cpu_axi_full_arsize,
            axi_arburst => cpu_axi_full_arburst,
            axi_arlock => cpu_axi_full_arlock,
            axi_arcache => cpu_axi_full_arcache,
            axi_arprot => cpu_axi_full_arprot,
            axi_arqos => cpu_axi_full_arqos,
            axi_arregion => cpu_axi_full_arregion,
            axi_arvalid => cpu_axi_full_arvalid,
            axi_arready => cpu_axi_full_arready,
            axi_rid => cpu_axi_full_rid,
            axi_rdata => cpu_axi_full_rdata,
            axi_rresp => cpu_axi_full_rresp,
            axi_rlast => cpu_axi_full_rlast,
            axi_rvalid => cpu_axi_full_rvalid,
            axi_rready => cpu_axi_full_rready);
            
    int_full2lite_inst : plasoc_axi4_full2lite
        generic map (
            axi_slave_id_width => axi_slave_id_width,
            axi_address_width => axi_lite_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            s_axi_awid => int_axi_full_awid,
            s_axi_awaddr => int_axi_full_awaddr(axi_lite_address_width-1 downto 0),
            s_axi_awlen => int_axi_full_awlen,
            s_axi_awsize => int_axi_full_awsize,
            s_axi_awburst => int_axi_full_awburst,
            s_axi_awlock => int_axi_full_awlock,
            s_axi_awcache => int_axi_full_awcache,
            s_axi_awprot => int_axi_full_awprot,
            s_axi_awqos => int_axi_full_awqos,
            s_axi_awregion => int_axi_full_awregion,
            s_axi_awvalid => int_axi_full_awvalid,
            s_axi_awready => int_axi_full_awready,
            s_axi_wdata => int_axi_full_wdata,
            s_axi_wstrb => int_axi_full_wstrb,
            s_axi_wlast => int_axi_full_wlast,
            s_axi_wvalid => int_axi_full_wvalid,
            s_axi_wready => int_axi_full_wready,
            s_axi_bid => int_axi_full_bid,
            s_axi_bresp => int_axi_full_bresp,
            s_axi_bvalid => int_axi_full_bvalid,
            s_axi_bready => int_axi_full_bready,
            s_axi_arid => int_axi_full_arid,
            s_axi_araddr => int_axi_full_araddr(axi_lite_address_width-1 downto 0),
            s_axi_arlen => int_axi_full_arlen,
            s_axi_arsize => int_axi_full_arsize,
            s_axi_arburst => int_axi_full_arburst,
            s_axi_arlock => int_axi_full_arlock,
            s_axi_arcache => int_axi_full_arcache,
            s_axi_arprot => int_axi_full_arprot,
            s_axi_arqos => int_axi_full_arqos,
            s_axi_arregion => int_axi_full_arregion,
            s_axi_arvalid => int_axi_full_arvalid,
            s_axi_arready => int_axi_full_arready,
            s_axi_rid => int_axi_full_rid,
            s_axi_rdata => int_axi_full_rdata,
            s_axi_rresp => int_axi_full_rresp,
            s_axi_rlast => int_axi_full_rlast,
            s_axi_rvalid => int_axi_full_rvalid,
            s_axi_rready => int_axi_full_rready,
            m_axi_awaddr => int_axi_lite_awaddr,
            m_axi_awprot => int_axi_lite_awprot,
            m_axi_awvalid => int_axi_lite_awvalid,
            m_axi_awready => int_axi_lite_awready,
            m_axi_wvalid => int_axi_lite_wvalid,
            m_axi_wready => int_axi_lite_wready,
            m_axi_wdata => int_axi_lite_wdata,
            m_axi_wstrb => int_axi_lite_wstrb,
            m_axi_bvalid => int_axi_lite_bvalid,
            m_axi_bready => int_axi_lite_bready,
            m_axi_bresp => int_axi_lite_bresp,
            m_axi_araddr => int_axi_lite_araddr,
            m_axi_arprot => int_axi_lite_arprot,
            m_axi_arvalid => int_axi_lite_arvalid,
            m_axi_arready => int_axi_lite_arready,
            m_axi_rdata => int_axi_lite_rdata,
            m_axi_rvalid => int_axi_lite_rvalid,
            m_axi_rready => int_axi_lite_rready,
            m_axi_rresp => int_axi_lite_rresp);
            
    timer_full2lite_inst : plasoc_axi4_full2lite
        generic map (
            axi_slave_id_width => axi_slave_id_width,
            axi_address_width => axi_lite_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            s_axi_awid => timer_axi_full_awid,
            s_axi_awaddr => timer_axi_full_awaddr(axi_lite_address_width-1 downto 0),
            s_axi_awlen => timer_axi_full_awlen,
            s_axi_awsize => timer_axi_full_awsize,
            s_axi_awburst => timer_axi_full_awburst,
            s_axi_awlock => timer_axi_full_awlock,
            s_axi_awcache => timer_axi_full_awcache,
            s_axi_awprot => timer_axi_full_awprot,
            s_axi_awqos => timer_axi_full_awqos,
            s_axi_awregion => timer_axi_full_awregion,
            s_axi_awvalid => timer_axi_full_awvalid,
            s_axi_awready => timer_axi_full_awready,
            s_axi_wdata => timer_axi_full_wdata,
            s_axi_wstrb => timer_axi_full_wstrb,
            s_axi_wlast => timer_axi_full_wlast,
            s_axi_wvalid => timer_axi_full_wvalid,
            s_axi_wready => timer_axi_full_wready,
            s_axi_bid => timer_axi_full_bid,
            s_axi_bresp => timer_axi_full_bresp,
            s_axi_bvalid => timer_axi_full_bvalid,
            s_axi_bready => timer_axi_full_bready,
            s_axi_arid => timer_axi_full_arid,
            s_axi_araddr => timer_axi_full_araddr(axi_lite_address_width-1 downto 0),
            s_axi_arlen => timer_axi_full_arlen,
            s_axi_arsize => timer_axi_full_arsize,
            s_axi_arburst => timer_axi_full_arburst,
            s_axi_arlock => timer_axi_full_arlock,
            s_axi_arcache => timer_axi_full_arcache,
            s_axi_arprot => timer_axi_full_arprot,
            s_axi_arqos => timer_axi_full_arqos,
            s_axi_arregion => timer_axi_full_arregion,
            s_axi_arvalid => timer_axi_full_arvalid,
            s_axi_arready => timer_axi_full_arready,
            s_axi_rid => timer_axi_full_rid,
            s_axi_rdata => timer_axi_full_rdata,
            s_axi_rresp => timer_axi_full_rresp,
            s_axi_rlast => timer_axi_full_rlast,
            s_axi_rvalid => timer_axi_full_rvalid,
            s_axi_rready => timer_axi_full_rready,
            m_axi_awaddr => timer_axi_lite_awaddr,
            m_axi_awprot => timer_axi_lite_awprot,
            m_axi_awvalid => timer_axi_lite_awvalid,
            m_axi_awready => timer_axi_lite_awready,
            m_axi_wvalid => timer_axi_lite_wvalid,
            m_axi_wready => timer_axi_lite_wready,
            m_axi_wdata => timer_axi_lite_wdata,
            m_axi_wstrb => timer_axi_lite_wstrb,
            m_axi_bvalid => timer_axi_lite_bvalid,
            m_axi_bready => timer_axi_lite_bready,
            m_axi_bresp => timer_axi_lite_bresp,
            m_axi_araddr => timer_axi_lite_araddr,
            m_axi_arprot => timer_axi_lite_arprot,
            m_axi_arvalid => timer_axi_lite_arvalid,
            m_axi_arready => timer_axi_lite_arready,
            m_axi_rdata => timer_axi_lite_rdata,
            m_axi_rvalid => timer_axi_lite_rvalid,
            m_axi_rready => timer_axi_lite_rready,
            m_axi_rresp => timer_axi_lite_rresp);
    
    gpio_full2lite_inst : plasoc_axi4_full2lite
        generic map (
            axi_slave_id_width => axi_slave_id_width,
            axi_address_width => axi_lite_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            s_axi_awid => gpio_axi_full_awid,
            s_axi_awaddr => gpio_axi_full_awaddr(axi_lite_address_width-1 downto 0),
            s_axi_awlen => gpio_axi_full_awlen,
            s_axi_awsize => gpio_axi_full_awsize,
            s_axi_awburst => gpio_axi_full_awburst,
            s_axi_awlock => gpio_axi_full_awlock,
            s_axi_awcache => gpio_axi_full_awcache,
            s_axi_awprot => gpio_axi_full_awprot,
            s_axi_awqos => gpio_axi_full_awqos,
            s_axi_awregion => gpio_axi_full_awregion,
            s_axi_awvalid => gpio_axi_full_awvalid,
            s_axi_awready => gpio_axi_full_awready,
            s_axi_wdata => gpio_axi_full_wdata,
            s_axi_wstrb => gpio_axi_full_wstrb,
            s_axi_wlast => gpio_axi_full_wlast,
            s_axi_wvalid => gpio_axi_full_wvalid,
            s_axi_wready => gpio_axi_full_wready,
            s_axi_bid => gpio_axi_full_bid,
            s_axi_bresp => gpio_axi_full_bresp,
            s_axi_bvalid => gpio_axi_full_bvalid,
            s_axi_bready => gpio_axi_full_bready,
            s_axi_arid => gpio_axi_full_arid,
            s_axi_araddr => gpio_axi_full_araddr(axi_lite_address_width-1 downto 0),
            s_axi_arlen => gpio_axi_full_arlen,
            s_axi_arsize => gpio_axi_full_arsize,
            s_axi_arburst => gpio_axi_full_arburst,
            s_axi_arlock => gpio_axi_full_arlock,
            s_axi_arcache => gpio_axi_full_arcache,
            s_axi_arprot => gpio_axi_full_arprot,
            s_axi_arqos => gpio_axi_full_arqos,
            s_axi_arregion => gpio_axi_full_arregion,
            s_axi_arvalid => gpio_axi_full_arvalid,
            s_axi_arready => gpio_axi_full_arready,
            s_axi_rid => gpio_axi_full_rid,
            s_axi_rdata => gpio_axi_full_rdata,
            s_axi_rresp => gpio_axi_full_rresp,
            s_axi_rlast => gpio_axi_full_rlast,
            s_axi_rvalid => gpio_axi_full_rvalid,
            s_axi_rready => gpio_axi_full_rready,
            m_axi_awaddr => gpio_axi_lite_awaddr,
            m_axi_awprot => gpio_axi_lite_awprot,
            m_axi_awvalid => gpio_axi_lite_awvalid,
            m_axi_awready => gpio_axi_lite_awready,
            m_axi_wvalid => gpio_axi_lite_wvalid,
            m_axi_wready => gpio_axi_lite_wready,
            m_axi_wdata => gpio_axi_lite_wdata,
            m_axi_wstrb => gpio_axi_lite_wstrb,
            m_axi_bvalid => gpio_axi_lite_bvalid,
            m_axi_bready => gpio_axi_lite_bready,
            m_axi_bresp => gpio_axi_lite_bresp,
            m_axi_araddr => gpio_axi_lite_araddr,
            m_axi_arprot => gpio_axi_lite_arprot,
            m_axi_arvalid => gpio_axi_lite_arvalid,
            m_axi_arready => gpio_axi_lite_arready,
            m_axi_rdata => gpio_axi_lite_rdata,
            m_axi_rvalid => gpio_axi_lite_rvalid,
            m_axi_rready => gpio_axi_lite_rready,
            m_axi_rresp => gpio_axi_lite_rresp);
            
    cdmareg_full2lite_inst : plasoc_axi4_full2lite
        generic map (
            axi_slave_id_width => axi_slave_id_width,
            axi_address_width => axi_lite_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            s_axi_awid => cdmareg_axi_full_awid,
            s_axi_awaddr => cdmareg_axi_full_awaddr(axi_lite_address_width-1 downto 0),
            s_axi_awlen => cdmareg_axi_full_awlen,
            s_axi_awsize => cdmareg_axi_full_awsize,
            s_axi_awburst => cdmareg_axi_full_awburst,
            s_axi_awlock => cdmareg_axi_full_awlock,
            s_axi_awcache => cdmareg_axi_full_awcache,
            s_axi_awprot => cdmareg_axi_full_awprot,
            s_axi_awqos => cdmareg_axi_full_awqos,
            s_axi_awregion => cdmareg_axi_full_awregion,
            s_axi_awvalid => cdmareg_axi_full_awvalid,
            s_axi_awready => cdmareg_axi_full_awready,
            s_axi_wdata => cdmareg_axi_full_wdata,
            s_axi_wstrb => cdmareg_axi_full_wstrb,
            s_axi_wlast => cdmareg_axi_full_wlast,
            s_axi_wvalid => cdmareg_axi_full_wvalid,
            s_axi_wready => cdmareg_axi_full_wready,
            s_axi_bid => cdmareg_axi_full_bid,
            s_axi_bresp => cdmareg_axi_full_bresp,
            s_axi_bvalid => cdmareg_axi_full_bvalid,
            s_axi_bready => cdmareg_axi_full_bready,
            s_axi_arid => cdmareg_axi_full_arid,
            s_axi_araddr => cdmareg_axi_full_araddr(axi_lite_address_width-1 downto 0),
            s_axi_arlen => cdmareg_axi_full_arlen,
            s_axi_arsize => cdmareg_axi_full_arsize,
            s_axi_arburst => cdmareg_axi_full_arburst,
            s_axi_arlock => cdmareg_axi_full_arlock,
            s_axi_arcache => cdmareg_axi_full_arcache,
            s_axi_arprot => cdmareg_axi_full_arprot,
            s_axi_arqos => cdmareg_axi_full_arqos,
            s_axi_arregion => cdmareg_axi_full_arregion,
            s_axi_arvalid => cdmareg_axi_full_arvalid,
            s_axi_arready => cdmareg_axi_full_arready,
            s_axi_rid => cdmareg_axi_full_rid,
            s_axi_rdata => cdmareg_axi_full_rdata,
            s_axi_rresp => cdmareg_axi_full_rresp,
            s_axi_rlast => cdmareg_axi_full_rlast,
            s_axi_rvalid => cdmareg_axi_full_rvalid,
            s_axi_rready => cdmareg_axi_full_rready,
            m_axi_awaddr => cdmareg_axi_lite_awaddr,
            m_axi_awprot => cdmareg_axi_lite_awprot,
            m_axi_awvalid => cdmareg_axi_lite_awvalid,
            m_axi_awready => cdmareg_axi_lite_awready,
            m_axi_wvalid => cdmareg_axi_lite_wvalid,
            m_axi_wready => cdmareg_axi_lite_wready,
            m_axi_wdata => cdmareg_axi_lite_wdata,
            m_axi_wstrb => cdmareg_axi_lite_wstrb,
            m_axi_bvalid => cdmareg_axi_lite_bvalid,
            m_axi_bready => cdmareg_axi_lite_bready,
            m_axi_bresp => cdmareg_axi_lite_bresp,
            m_axi_araddr => cdmareg_axi_lite_araddr,
            m_axi_arprot => cdmareg_axi_lite_arprot,
            m_axi_arvalid => cdmareg_axi_lite_arvalid,
            m_axi_arready => cdmareg_axi_lite_arready,
            m_axi_rdata => cdmareg_axi_lite_rdata,
            m_axi_rvalid => cdmareg_axi_lite_rvalid,
            m_axi_rready => cdmareg_axi_lite_rready,
            m_axi_rresp => cdmareg_axi_lite_rresp);
            
    axi_bram_address_cntrl_inst : axi_bram_address_cntrl 
        generic map (
            axi_id_width => axi_slave_id_width,
            axi_address_width => axi_lite_address_width)
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            m_axi_awid => ram_axi_full_awid,
            m_axi_awaddr => ram_axi_full_awaddr(axi_lite_address_width-1 downto 0),
            m_axi_awlen => ram_axi_full_awlen,
            m_axi_awsize => ram_axi_full_awsize,
            m_axi_awburst => ram_axi_full_awburst,
            m_axi_awlock => ram_axi_full_awlock,
            m_axi_awcache => ram_axi_full_awcache,
            m_axi_awprot => ram_axi_full_awprot,
            m_axi_awvalid => ram_axi_full_awvalid,
            m_axi_awready => ram_axi_full_awready,
            s_axi_awid => ram_axi_full_awid_0,
            s_axi_awaddr => ram_axi_full_awaddr_0(axi_lite_address_width-1 downto 0),
            s_axi_awlen => ram_axi_full_awlen_0,
            s_axi_awsize => ram_axi_full_awsize_0,
            s_axi_awburst => ram_axi_full_awburst_0,
            s_axi_awlock => ram_axi_full_awlock_0,
            s_axi_awcache => ram_axi_full_awcache_0,
            s_axi_awprot => ram_axi_full_awprot_0,          
            s_axi_awvalid => ram_axi_full_awvalid_0,
            s_axi_awready => ram_axi_full_awready_0,
            m_axi_arid => ram_axi_full_arid,
            m_axi_araddr => ram_axi_full_araddr(axi_lite_address_width-1 downto 0),
            m_axi_arlen => ram_axi_full_arlen,
            m_axi_arsize => ram_axi_full_arsize,
            m_axi_arburst => ram_axi_full_arburst,
            m_axi_arlock => ram_axi_full_arlock,
            m_axi_arcache => ram_axi_full_arcache,
            m_axi_arprot => ram_axi_full_arprot,
            m_axi_arvalid => ram_axi_full_arvalid,
            m_axi_arready => ram_axi_full_arready,
            s_axi_arid => ram_axi_full_arid_0,
            s_axi_araddr => ram_axi_full_araddr_0(axi_lite_address_width-1 downto 0),
            s_axi_arlen => ram_axi_full_arlen_0,
            s_axi_arsize => ram_axi_full_arsize_0,
            s_axi_arburst => ram_axi_full_arburst_0,
            s_axi_arlock => ram_axi_full_arlock_0,
            s_axi_arcache => ram_axi_full_arcache_0,
            s_axi_arprot => ram_axi_full_arprot_0,          
            s_axi_arvalid => ram_axi_full_arvalid_0,
            s_axi_arready => ram_axi_full_arready_0);
            
    ram_cntrl_inst : axi_bram_ctrl_0
        port map (
            s_axi_aclk => aclk,
            s_axi_aresetn => aresetn(0),
            s_axi_awid => ram_axi_full_awid,
            s_axi_awaddr => ram_axi_full_awaddr_0(axi_lite_address_width-1 downto 0),
            s_axi_awlen => ram_axi_full_awlen_0,
            s_axi_awsize => ram_axi_full_awsize_0,
            s_axi_awburst => ram_axi_full_awburst_0,
            s_axi_awlock => ram_axi_full_awlock_0,
            s_axi_awcache => ram_axi_full_awcache_0,
            s_axi_awprot => ram_axi_full_awprot_0,
            s_axi_awvalid => ram_axi_full_awvalid_0,
            s_axi_awready => ram_axi_full_awready_0,
            s_axi_wdata => ram_axi_full_wdata,
            s_axi_wstrb => ram_axi_full_wstrb,
            s_axi_wlast => ram_axi_full_wlast,
            s_axi_wvalid => ram_axi_full_wvalid,
            s_axi_wready => ram_axi_full_wready,
            s_axi_bid => ram_axi_full_bid,
            s_axi_bresp => ram_axi_full_bresp,
            s_axi_bvalid => ram_axi_full_bvalid,
            s_axi_bready => ram_axi_full_bready,
            s_axi_arid => ram_axi_full_arid,
            s_axi_araddr => ram_axi_full_araddr_0(axi_lite_address_width-1 downto 0),
            s_axi_arlen => ram_axi_full_arlen_0,
            s_axi_arsize => ram_axi_full_arsize_0,
            s_axi_arburst => ram_axi_full_arburst_0,
            s_axi_arlock => ram_axi_full_arlock_0,
            s_axi_arcache => ram_axi_full_arcache_0,
            s_axi_arprot => ram_axi_full_arprot_0,
            s_axi_arvalid => ram_axi_full_arvalid_0,
            s_axi_arready => ram_axi_full_arready_0,
            s_axi_rdata => ram_axi_full_rdata,
            s_axi_rresp => ram_axi_full_rresp,
            s_axi_rlast => ram_axi_full_rlast,
            s_axi_rvalid => ram_axi_full_rvalid,
            s_axi_rready => ram_axi_full_rready,
            bram_rst_a => ram_bram_rst_a,
            bram_clk_a => ram_bram_clk_a,
            bram_en_a => ram_bram_en_a,
            bram_we_a => ram_bram_we_a,
            bram_addr_a => ram_bram_addr_a,
            bram_wrdata_a => ram_bram_wrdata_a,
            bram_rddata_a => ram_bram_rddata_a);
            
    ram_bram_inst : ram 
        port map (
            bram_rst_a => ram_bram_rst_a,
            bram_clk_a => ram_bram_clk_a,
            bram_en_a => ram_bram_en_a,
            bram_we_a => ram_bram_we_a,
            bram_addr_a => ram_bram_addr_a,
            bram_wrdata_a => ram_bram_wrdata_a,
            bram_rddata_a => ram_bram_rddata_a);
            
    plasoc_int_inst : plasoc_int 
        generic map (
            axi_address_width => axi_lite_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            cpu_int => cpu_int,
            dev_ints => int_dev_ints,
            axi_awaddr => int_axi_lite_awaddr,
            axi_awprot => int_axi_lite_awprot,
            axi_awvalid => int_axi_lite_awvalid,
            axi_awready => int_axi_lite_awready,
            axi_wvalid => int_axi_lite_wvalid,
            axi_wready => int_axi_lite_wready,
            axi_wdata => int_axi_lite_wdata,
            axi_wstrb => int_axi_lite_wstrb,
            axi_bvalid => int_axi_lite_bvalid,
            axi_bready => int_axi_lite_bready,
            axi_bresp => int_axi_lite_bresp,
            axi_araddr => int_axi_lite_araddr,
            axi_arprot => int_axi_lite_arprot,
            axi_arvalid => int_axi_lite_arvalid,
            axi_arready => int_axi_lite_arready,
            axi_rdata => int_axi_lite_rdata,
            axi_rvalid => int_axi_lite_rvalid,
            axi_rready => int_axi_lite_rready,
            axi_rresp => int_axi_lite_rresp);    
            
    plasoc_timer_inst : plasoc_timer 
        generic map (
            axi_address_width => axi_lite_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            axi_awaddr => timer_axi_lite_awaddr,
            axi_awprot => timer_axi_lite_awprot,
            axi_awvalid => timer_axi_lite_awvalid,
            axi_awready => timer_axi_lite_awready,
            axi_wvalid => timer_axi_lite_wvalid,
            axi_wready => timer_axi_lite_wready,
            axi_wdata => timer_axi_lite_wdata,
            axi_wstrb => timer_axi_lite_wstrb,
            axi_bvalid => timer_axi_lite_bvalid,
            axi_bready => timer_axi_lite_bready,
            axi_bresp => timer_axi_lite_bresp,
            axi_araddr => timer_axi_lite_araddr,
            axi_arprot => timer_axi_lite_arprot,
            axi_arvalid => timer_axi_lite_arvalid,
            axi_arready => timer_axi_lite_arready,
            axi_rdata => timer_axi_lite_rdata,
            axi_rvalid => timer_axi_lite_rvalid,
            axi_rready => timer_axi_lite_rready,
            axi_rresp => timer_axi_lite_rresp,
            done => timer_int);
            
    plasoc_gpio_inst : plasoc_gpio
        generic map (
            axi_address_width => axi_lite_address_width,
            axi_data_width => axi_data_width)
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            data_in => gpio_input,
            data_out => gpio_output,
            int => gpio_int,
            axi_awaddr => gpio_axi_lite_awaddr,
            axi_awprot => gpio_axi_lite_awprot,
            axi_awvalid => gpio_axi_lite_awvalid,
            axi_awready => gpio_axi_lite_awready,
            axi_wvalid => gpio_axi_lite_wvalid,
            axi_wready => gpio_axi_lite_wready,
            axi_wdata => gpio_axi_lite_wdata,
            axi_wstrb => gpio_axi_lite_wstrb,
            axi_bvalid => gpio_axi_lite_bvalid,
            axi_bready => gpio_axi_lite_bready,
            axi_bresp => gpio_axi_lite_bresp,
            axi_araddr => gpio_axi_lite_araddr,
            axi_arprot => gpio_axi_lite_arprot,
            axi_arvalid => gpio_axi_lite_arvalid,
            axi_arready => gpio_axi_lite_arready,
            axi_rdata => gpio_axi_lite_rdata,
            axi_rvalid => gpio_axi_lite_rvalid,
            axi_rready => gpio_axi_lite_rready,
            axi_rresp => gpio_axi_lite_rresp);
            
   axi_cdma_inst : axi_cdma_0
       PORT map (
         m_axi_aclk => aclk,
         s_axi_lite_aclk => aclk,
         s_axi_lite_aresetn => aresetn(0),
         cdma_introut => cdma_int,
         s_axi_lite_awaddr => cdmareg_axi_lite_awaddr(5 downto 0),
         s_axi_lite_awvalid => cdmareg_axi_lite_awvalid,
         s_axi_lite_awready => cdmareg_axi_lite_awready,
         s_axi_lite_wvalid => cdmareg_axi_lite_wvalid,
         s_axi_lite_wready => cdmareg_axi_lite_wready,
         s_axi_lite_wdata => cdmareg_axi_lite_wdata,
         s_axi_lite_bvalid => cdmareg_axi_lite_bvalid,
         s_axi_lite_bready => cdmareg_axi_lite_bready,
         s_axi_lite_bresp => cdmareg_axi_lite_bresp,
         s_axi_lite_araddr => cdmareg_axi_lite_araddr(5 downto 0),
         s_axi_lite_arvalid => cdmareg_axi_lite_arvalid,
         s_axi_lite_arready => cdmareg_axi_lite_arready,
         s_axi_lite_rdata => cdmareg_axi_lite_rdata,
         s_axi_lite_rvalid => cdmareg_axi_lite_rvalid,
         s_axi_lite_rready => cdmareg_axi_lite_rready,
         s_axi_lite_rresp => cdmareg_axi_lite_rresp,
         m_axi_arready => cdma_axi_full_arready,
         m_axi_arvalid => cdma_axi_full_arvalid,
         m_axi_araddr => cdma_axi_full_araddr,
         m_axi_arlen => cdma_axi_full_arlen,
         m_axi_arsize => cdma_axi_full_arsize,
         m_axi_arburst => cdma_axi_full_arburst,
         m_axi_arprot => cdma_axi_full_arprot,
         m_axi_arcache => cdma_axi_full_arcache,
         m_axi_rready => cdma_axi_full_rready,
         m_axi_rvalid => cdma_axi_full_rvalid,
         m_axi_rdata => cdma_axi_full_rdata,
         m_axi_rresp => cdma_axi_full_rresp,
         m_axi_rlast => cdma_axi_full_rlast,
         m_axi_awready => cdma_axi_full_awready,
         m_axi_awvalid => cdma_axi_full_awvalid,
         m_axi_awaddr => cdma_axi_full_awaddr,
         m_axi_awlen => cdma_axi_full_awlen,
         m_axi_awsize => cdma_axi_full_awsize,
         m_axi_awburst => cdma_axi_full_awburst,
         m_axi_awprot => cdma_axi_full_awprot,
         m_axi_awcache => cdma_axi_full_awcache,
         m_axi_wready => cdma_axi_full_wready,
         m_axi_wvalid => cdma_axi_full_wvalid,
         m_axi_wdata => cdma_axi_full_wdata,
         m_axi_wstrb => cdma_axi_full_wstrb,
         m_axi_wlast => cdma_axi_full_wlast,
         m_axi_bready => cdma_axi_full_bready,
         m_axi_bvalid => cdma_axi_full_bvalid,
         m_axi_bresp => cdma_axi_full_bresp,
         cdma_tvect_out => open);
            
end Behavioral;
