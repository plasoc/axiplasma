library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.plasoc_cpu_pack.all;
use work.plasoc_int_pack.all;
use work.plasoc_timer_pack.all;
use work.plasoc_gpio_pack.all;
use work.plasoc_crossbar_pack.all; 

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
        s_axi_awid : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
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
        s_axi_bid : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_bvalid : OUT STD_LOGIC;
        s_axi_bready : IN STD_LOGIC;
        s_axi_arid : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_araddr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axi_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_arlock : IN STD_LOGIC;
        s_axi_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_arvalid : IN STD_LOGIC;
        s_axi_arready : OUT STD_LOGIC;
        s_axi_rid : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
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
    constant word_width : integer := 32;
    constant int_axi_base_address : std_logic_vector := X"44A00000";
    constant timer_axi_base_address : std_logic_vector := X"44A10000";
    constant gpio_axi_base_address : std_logic_vector := X"44A20000";
    -- global interface.
    signal aclk : std_logic;
    signal aresetn : std_logic_vector(0 downto 0);
    signal interconnect_aresetn : std_logic_vector(0 downto 0);
    signal locked : std_logic;
    -- CPU interface.
    signal axi_awid : std_logic_vector(0 downto 0);
    signal axi_awaddr : std_logic_vector(31 downto 0);
    signal axi_awlen : std_logic_vector(7 downto 0);
    signal axi_awsize : std_logic_vector(2 downto 0);
    signal axi_awburst : std_logic_vector(1 downto 0);
    signal axi_awlock : std_logic_vector(0 downto 0);
    signal axi_awcache : std_logic_vector(3 downto 0);
    signal axi_awprot : std_logic_vector(2 downto 0);
    signal axi_awqos : std_logic_vector(3 downto 0);
    signal axi_awregion : std_logic_vector(3 downto 0);
    signal axi_awvalid : std_logic;
    signal axi_awready : std_logic;
    signal axi_wdata : std_logic_vector(31 downto 0);
    signal axi_wstrb : std_logic_vector(3 downto 0);
    signal axi_wlast : std_logic;
    signal axi_wvalid : std_logic;
    signal axi_wready : std_logic;
    signal axi_bid : std_logic_vector(0 downto 0);
    signal axi_bresp :  std_logic_vector(1 downto 0);
    signal axi_bvalid : std_logic;
    signal axi_bready : std_logic;
    signal axi_arid : std_logic_vector(0 downto 0);
    signal axi_araddr : std_logic_vector(31 downto 0);
    signal axi_arlen : std_logic_vector(7 downto 0);
    signal axi_arsize : std_logic_vector(2 downto 0);
    signal axi_arburst : std_logic_vector(1 downto 0);
    signal axi_arlock : std_logic_vector(0 downto 0);
    signal axi_arcache : std_logic_vector(3 downto 0);
    signal axi_arprot : std_logic_vector(2 downto 0);
    signal axi_arqos : std_logic_vector(3 downto 0);
    signal axi_arregion : std_logic_vector(3 downto 0);
    signal axi_arvalid : std_logic;
    signal axi_arready : std_logic;
    signal axi_rid : std_logic_vector(0 downto 0);
    signal axi_rdata : std_logic_vector(31 downto 0);
    signal axi_rresp : std_logic_vector(1 downto 0);
    signal axi_rlast : std_logic;
    signal axi_rvalid : std_logic;
    signal axi_rready : std_logic;
    -- CDMA interface.
    signal cdma_int : STD_LOGIC;
    signal cdma_s_axi_lite_awready : STD_LOGIC;
    signal cdma_s_axi_lite_awvalid : STD_LOGIC;
    signal cdma_s_axi_lite_awaddr : STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal cdma_s_axi_lite_wready : STD_LOGIC;
    signal cdma_s_axi_lite_wvalid : STD_LOGIC;
    signal cdma_s_axi_lite_wdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal cdma_s_axi_lite_bready : STD_LOGIC;
    signal cdma_s_axi_lite_bvalid : STD_LOGIC;
    signal cdma_s_axi_lite_bresp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal cdma_s_axi_lite_arready : STD_LOGIC;
    signal cdma_s_axi_lite_arvalid : STD_LOGIC;
    signal cdma_s_axi_lite_araddr : STD_LOGIC_VECTOR(5 DOWNTO 0);
    signal cdma_s_axi_lite_rready : STD_LOGIC;
    signal cdma_s_axi_lite_rvalid : STD_LOGIC;
    signal cdma_s_axi_lite_rdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal cdma_s_axi_lite_rresp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal cdma_m_axi_arready : STD_LOGIC;
    signal cdma_m_axi_arvalid : STD_LOGIC;
    signal cdma_m_axi_araddr : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal cdma_m_axi_arlen : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal cdma_m_axi_arsize : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal cdma_m_axi_arburst : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal cdma_m_axi_arprot : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal cdma_m_axi_arcache : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal cdma_m_axi_rready : STD_LOGIC;
    signal cdma_m_axi_rvalid : STD_LOGIC;
    signal cdma_m_axi_rdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal cdma_m_axi_rresp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal cdma_m_axi_rlast : STD_LOGIC;
    signal cdma_m_axi_awready : STD_LOGIC;
    signal cdma_m_axi_awvalid : STD_LOGIC;
    signal cdma_m_axi_awaddr : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal cdma_m_axi_awlen : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal cdma_m_axi_awsize : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal cdma_m_axi_awburst : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal cdma_m_axi_awprot : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal cdma_m_axi_awcache : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal cdma_m_axi_wready : STD_LOGIC;
    signal cdma_m_axi_wvalid : STD_LOGIC;
    signal cdma_m_axi_wdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal cdma_m_axi_wstrb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal cdma_m_axi_wlast : STD_LOGIC;
    signal cdma_m_axi_bready : STD_LOGIC;
    signal cdma_m_axi_bvalid : STD_LOGIC;
    signal cdma_m_axi_bresp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    -- Bram interface.
    signal bram_s_axi_awid : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal bram_s_axi_awaddr : STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal bram_s_axi_awlen : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal bram_s_axi_awsize : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal bram_s_axi_awburst : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal bram_s_axi_awlock : STD_LOGIC;
    signal bram_s_axi_awcache : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal bram_s_axi_awprot : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal bram_s_axi_awvalid : STD_LOGIC;
    signal bram_s_axi_awready : STD_LOGIC;
    signal bram_s_axi_wdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal bram_s_axi_wstrb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal bram_s_axi_wlast : STD_LOGIC;
    signal bram_s_axi_wvalid : STD_LOGIC;
    signal bram_s_axi_wready : STD_LOGIC;
    signal bram_s_axi_bid : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal bram_s_axi_bresp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal bram_s_axi_bvalid : STD_LOGIC;
    signal bram_s_axi_bready : STD_LOGIC;
    signal bram_s_axi_arid : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal bram_s_axi_araddr : STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal bram_s_axi_arlen : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal bram_s_axi_arsize : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal bram_s_axi_arburst : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal bram_s_axi_arlock : STD_LOGIC;
    signal bram_s_axi_arcache : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal bram_s_axi_arprot : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal bram_s_axi_arvalid : STD_LOGIC;
    signal bram_s_axi_arready : STD_LOGIC;
    signal bram_s_axi_rid : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal bram_s_axi_rdata : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal bram_s_axi_rresp : STD_LOGIC_VECTOR(1 DOWNTO 0);
    signal bram_s_axi_rlast : STD_LOGIC;
    signal bram_s_axi_rvalid : STD_LOGIC;
    signal bram_s_axi_rready : STD_LOGIC;
    signal bram_rst_a : std_logic;
    signal bram_clk_a : std_logic;
    signal bram_en_a : std_logic;
    signal bram_we_a : std_logic_vector(3 downto 0);
    signal bram_addr_a : std_logic_vector(15 downto 0);
    signal bram_wrdata_a : std_logic_vector(31 downto 0);
    signal bram_rddata_a : std_logic_vector(31 downto 0);
    -- GPIO interface.
    signal gpio_axi_araddr : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal gpio_axi_arprot : STD_LOGIC_VECTOR ( 2 downto 0 );
    signal gpio_axi_arready : STD_LOGIC;
    signal gpio_axi_arvalid : STD_LOGIC;
    signal gpio_axi_awaddr : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal gpio_axi_awprot : STD_LOGIC_VECTOR ( 2 downto 0 );
    signal gpio_axi_awready : STD_LOGIC;
    signal gpio_axi_awvalid : STD_LOGIC;
    signal gpio_axi_bready : STD_LOGIC;
    signal gpio_axi_bresp : STD_LOGIC_VECTOR ( 1 downto 0 );
    signal gpio_axi_bvalid : STD_LOGIC;
    signal gpio_axi_rdata : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal gpio_axi_rready : STD_LOGIC;
    signal gpio_axi_rresp : STD_LOGIC_VECTOR ( 1 downto 0 );
    signal gpio_axi_rvalid : STD_LOGIC;
    signal gpio_axi_wdata : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal gpio_axi_wready : STD_LOGIC;
    signal gpio_axi_wstrb : STD_LOGIC_VECTOR ( 3 downto 0 );
    signal gpio_axi_wvalid : STD_LOGIC;
    signal gpio_int : std_logic;
    -- interrupt controller interface;
    signal int_axi_araddr : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal int_axi_arprot : STD_LOGIC_VECTOR ( 2 downto 0 );
    signal int_axi_arready : STD_LOGIC;
    signal int_axi_arvalid : STD_LOGIC;
    signal int_axi_awaddr : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal int_axi_awprot : STD_LOGIC_VECTOR ( 2 downto 0 );
    signal int_axi_awready : STD_LOGIC;
    signal int_axi_awvalid : STD_LOGIC;
    signal int_axi_bready : STD_LOGIC;
    signal int_axi_bresp : STD_LOGIC_VECTOR ( 1 downto 0 );
    signal int_axi_bvalid : STD_LOGIC;
    signal int_axi_rdata : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal int_axi_rready : STD_LOGIC;
    signal int_axi_rresp : STD_LOGIC_VECTOR ( 1 downto 0 );
    signal int_axi_rvalid : STD_LOGIC;
    signal int_axi_wdata : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal int_axi_wready : STD_LOGIC;
    signal int_axi_wstrb : STD_LOGIC_VECTOR ( 3 downto 0 );
    signal int_axi_wvalid : STD_LOGIC;
    signal cpu_int : std_logic;
    signal dev_ints : std_logic_vector(default_interrupt_total-1 downto 0);
    -- timer core interface.
    signal timer_axi_araddr : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal timer_axi_arprot : STD_LOGIC_VECTOR ( 2 downto 0 );
    signal timer_axi_arready : STD_LOGIC;
    signal timer_axi_arvalid : STD_LOGIC;
    signal timer_axi_awaddr : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal timer_axi_awprot : STD_LOGIC_VECTOR ( 2 downto 0 );
    signal timer_axi_awready : STD_LOGIC;
    signal timer_axi_awvalid : STD_LOGIC;
    signal timer_axi_bready : STD_LOGIC;
    signal timer_axi_bresp : STD_LOGIC_VECTOR ( 1 downto 0 );
    signal timer_axi_bvalid : STD_LOGIC;
    signal timer_axi_rdata : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal timer_axi_rready : STD_LOGIC;
    signal timer_axi_rresp : STD_LOGIC_VECTOR ( 1 downto 0 );
    signal timer_axi_rvalid : STD_LOGIC;
    signal timer_axi_wdata : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal timer_axi_wready : STD_LOGIC;
    signal timer_axi_wstrb : STD_LOGIC_VECTOR ( 3 downto 0 );
    signal timer_axi_wvalid : STD_LOGIC;
    signal timer_done : std_logic;
begin
    dev_ints(2 downto 0) <= cdma_int & gpio_int & timer_done;
    dev_ints(default_interrupt_total-1 downto 3) <= (others=>'0');
     
     -- Clock instantiation.
     clk_wiz_inst : clk_wiz_0  
        port map (            
            aclk => aclk,
            resetn => raw_nreset,
            locked => locked,
            raw_clock => raw_clock);
            
    -- Reset core instantiation.
    proc_sys_reset_inst : proc_sys_reset_0 
          PORT map (
            slowest_sync_clk => aclk,
            ext_reset_in => raw_nreset,
            aux_reset_in => '0',
            mb_debug_sys_rst => '0',
            dcm_locked => locked,
            mb_reset => open,
            bus_struct_reset => open,
            peripheral_reset => open,
            interconnect_aresetn => interconnect_aresetn,
            peripheral_aresetn => aresetn);
            
    -- CDMA instantiation.
    axi_cdma_inst : axi_cdma_0 
        port map (
            m_axi_aclk => aclk,
            s_axi_lite_aclk => aclk,
            s_axi_lite_aresetn => aresetn(0),
            cdma_introut => cdma_int,
            s_axi_lite_awready => cdma_s_axi_lite_awready,
            s_axi_lite_awvalid => cdma_s_axi_lite_awvalid,
            s_axi_lite_awaddr => cdma_s_axi_lite_awaddr,
            s_axi_lite_wready => cdma_s_axi_lite_wready,
            s_axi_lite_wvalid => cdma_s_axi_lite_wvalid,
            s_axi_lite_wdata => cdma_s_axi_lite_wdata,
            s_axi_lite_bready => cdma_s_axi_lite_bready,
            s_axi_lite_bvalid => cdma_s_axi_lite_bvalid,
            s_axi_lite_bresp => cdma_s_axi_lite_bresp,
            s_axi_lite_arready => cdma_s_axi_lite_arready,
            s_axi_lite_arvalid => cdma_s_axi_lite_arvalid,
            s_axi_lite_araddr => cdma_s_axi_lite_araddr,
            s_axi_lite_rready => cdma_s_axi_lite_rready,
            s_axi_lite_rvalid => cdma_s_axi_lite_rvalid,
            s_axi_lite_rdata => cdma_s_axi_lite_rdata,
            s_axi_lite_rresp => cdma_s_axi_lite_rresp,
            m_axi_arready => cdma_m_axi_arready,
            m_axi_arvalid => cdma_m_axi_arvalid,
            m_axi_araddr => cdma_m_axi_araddr,
            m_axi_arlen => cdma_m_axi_arlen,
            m_axi_arsize => cdma_m_axi_arsize,
            m_axi_arburst => cdma_m_axi_arburst,
            m_axi_arprot => cdma_m_axi_arprot,
            m_axi_arcache => cdma_m_axi_arcache,
            m_axi_rready => cdma_m_axi_rready,
            m_axi_rvalid => cdma_m_axi_rvalid,
            m_axi_rdata => cdma_m_axi_rdata,
            m_axi_rresp => cdma_m_axi_rresp,
            m_axi_rlast => cdma_m_axi_rlast,
            m_axi_awready => cdma_m_axi_awready,
            m_axi_awvalid => cdma_m_axi_awvalid,
            m_axi_awaddr => cdma_m_axi_awaddr,
            m_axi_awlen => cdma_m_axi_awlen,
            m_axi_awsize => cdma_m_axi_awsize,
            m_axi_awburst => cdma_m_axi_awburst,
            m_axi_awprot => cdma_m_axi_awprot,
            m_axi_awcache => cdma_m_axi_awcache,
            m_axi_wready => cdma_m_axi_wready,
            m_axi_wvalid => cdma_m_axi_wvalid,
            m_axi_wdata => cdma_m_axi_wdata,
            m_axi_wstrb => cdma_m_axi_wstrb,
            m_axi_wlast => cdma_m_axi_wlast,
            m_axi_bready => cdma_m_axi_bready,
            m_axi_bvalid => cdma_m_axi_bvalid,
            m_axi_bresp => cdma_m_axi_bresp,
            cdma_tvect_out => open );
     
     -- CPU instantiation.
    plasoc_cpu_inst :
    plasoc_cpu 
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            axi_awid => axi_awid,
            axi_awaddr => axi_awaddr,
            axi_awlen => axi_awlen,
            axi_awsize => axi_awsize,
            axi_awburst => axi_awburst,
            axi_awlock => axi_awlock(0),
            axi_awcache => axi_awcache,
            axi_awprot => axi_awprot,
            axi_awqos => axi_awqos,
            axi_awregion => axi_awregion,
            axi_awvalid => axi_awvalid,
            axi_awready => axi_awready,
            axi_wdata => axi_wdata,
            axi_wstrb => axi_wstrb,
            axi_wlast => axi_wlast,
            axi_wvalid => axi_wvalid,
            axi_wready => axi_wready,
            axi_bid => axi_bid,
            axi_bresp => axi_bresp,
            axi_bvalid => axi_bvalid,
            axi_bready => axi_bready,
            axi_arid => axi_arid,
            axi_araddr => axi_araddr,
            axi_arlen => axi_arlen,
            axi_arsize => axi_arsize,
            axi_arburst => axi_arburst,
            axi_arlock => axi_arlock(0),
            axi_arcache => axi_arcache,
            axi_arprot => axi_arprot,
            axi_arqos => axi_arqos,
            axi_arregion => axi_arregion,
            axi_arvalid => axi_arvalid,
            axi_arready => axi_arready,
            axi_rid => axi_rid,
            axi_rdata => axi_rdata,
            axi_rresp => axi_rresp,
            axi_rlast => axi_rlast,
            axi_rvalid => axi_rvalid,
            axi_rready => axi_rready,
            intr_in  => cpu_int );
            
    -- AXI Bram instantiation.
    axi_bram_ctrl_inst : axi_bram_ctrl_0 
        PORT map (
            s_axi_aclk => aclk,
            s_axi_aresetn => aresetn(0),
            s_axi_awid => bram_s_axi_awid,
            s_axi_awaddr => bram_s_axi_awaddr,
            s_axi_awlen => bram_s_axi_awlen,
            s_axi_awsize => bram_s_axi_awsize,
            s_axi_awburst => bram_s_axi_awburst,
            s_axi_awlock => bram_s_axi_awlock,
            s_axi_awcache => bram_s_axi_awcache,
            s_axi_awprot => bram_s_axi_awprot,
            s_axi_awvalid => bram_s_axi_awvalid,
            s_axi_awready => bram_s_axi_awready,
            s_axi_wdata => bram_s_axi_wdata,
            s_axi_wstrb => bram_s_axi_wstrb,
            s_axi_wlast => bram_s_axi_wlast,
            s_axi_wvalid => bram_s_axi_wvalid,
            s_axi_wready => bram_s_axi_wready,
            s_axi_bid => bram_s_axi_bid,
            s_axi_bresp => bram_s_axi_bresp,
            s_axi_bvalid => bram_s_axi_bvalid,
            s_axi_bready => bram_s_axi_bready,
            s_axi_arid => bram_s_axi_arid,
            s_axi_araddr => bram_s_axi_araddr,
            s_axi_arlen => bram_s_axi_arlen,
            s_axi_arsize => bram_s_axi_arsize,
            s_axi_arburst => bram_s_axi_arburst,
            s_axi_arlock => bram_s_axi_arlock,
            s_axi_arcache => bram_s_axi_arcache,
            s_axi_arprot => bram_s_axi_arprot,
            s_axi_arvalid => bram_s_axi_arvalid,
            s_axi_arready => bram_s_axi_arready,
            s_axi_rid => bram_s_axi_rid,
            s_axi_rdata => bram_s_axi_rdata,
            s_axi_rresp => bram_s_axi_rresp,
            s_axi_rlast => bram_s_axi_rlast,
            s_axi_rvalid => bram_s_axi_rvalid,
            s_axi_rready => bram_s_axi_rready,
            bram_rst_a => bram_rst_a,
            bram_clk_a => bram_clk_a,
            bram_en_a => bram_en_a,
            bram_we_a => bram_we_a,
            bram_addr_a => bram_addr_a,
            bram_wrdata_a => bram_wrdata_a,
            bram_rddata_a => bram_rddata_a);
            
    -- Ram instantiation. Recall, the ram is actually emulated by bram for this test program.
    ram_inst : 
    ram 
        port map (
            bram_rst_a => bram_rst_a,
            bram_clk_a => bram_clk_a,
            bram_en_a => bram_en_a,
            bram_we_a => bram_we_a,
            bram_addr_a => bram_addr_a,
            bram_wrdata_a => bram_wrdata_a,
            bram_rddata_a => bram_rddata_a);
            
    -- GPIO core instantiation.
    plasoc_gpio_inst : plasoc_gpio 
        generic map (
            axi_address_width => word_width,                   
            axi_data_width => word_width,                      
            axi_base_address => gpio_axi_base_address
        )
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            data_in => gpio_input,
            data_out => gpio_output,
            axi_awaddr => gpio_axi_awaddr,
            axi_awprot => gpio_axi_awprot,
            axi_awvalid => gpio_axi_awvalid,
            axi_awready => gpio_axi_awready,
            axi_wvalid => gpio_axi_wvalid,
            axi_wready => gpio_axi_wready,
            axi_wdata => gpio_axi_wdata,
            axi_wstrb => gpio_axi_wstrb,
            axi_bvalid => gpio_axi_bvalid,
            axi_bready => gpio_axi_bready,
            axi_bresp => gpio_axi_bresp,
            axi_araddr => gpio_axi_araddr,
            axi_arprot => gpio_axi_arprot,
            axi_arvalid => gpio_axi_arvalid,
            axi_arready => gpio_axi_arready,
            axi_rdata => gpio_axi_rdata,
            axi_rvalid => gpio_axi_rvalid,
            axi_rready => gpio_axi_rready,
            axi_rresp => gpio_axi_rresp,
            int => gpio_int );    
            
    -- Interrupt controller instantiation.
    plasoc_int_inst :
    plasoc_int 
        generic map (
            axi_address_width => word_width,
            axi_data_width => word_width,
            axi_base_address => int_axi_base_address )
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            axi_awaddr => int_axi_awaddr,
            axi_awprot => int_axi_awprot,
            axi_awvalid => int_axi_awvalid,
            axi_awready => int_axi_awready,
            axi_wvalid => int_axi_wvalid,
            axi_wready => int_axi_wready,
            axi_wdata => int_axi_wdata,
            axi_wstrb => int_axi_wstrb,
            axi_bvalid => int_axi_bvalid,
            axi_bready => int_axi_bready,
            axi_bresp => int_axi_bresp,
            axi_araddr => int_axi_araddr,
            axi_arprot => int_axi_arprot,
            axi_arvalid => int_axi_arvalid,
            axi_arready => int_axi_arready,
            axi_rdata => int_axi_rdata,
            axi_rvalid => int_axi_rvalid,
            axi_rready => int_axi_rready,
            axi_rresp => int_axi_rresp,
            cpu_int => cpu_int,
            dev_ints => dev_ints);
            
    -- Timer core instantiation.
    plasoc_timer_inst : 
    plasoc_timer
        generic map (
            timer_width => default_timer_width,
            axi_address_width =>  word_width,
            axi_data_width => word_width,
            axi_base_address => timer_axi_base_address )
        port map (
            aclk => aclk,
            aresetn => aresetn(0),
            axi_awaddr => timer_axi_awaddr,
            axi_awprot => timer_axi_awprot,
            axi_awvalid => timer_axi_awvalid,
            axi_awready => timer_axi_awready,
            axi_wvalid => timer_axi_wvalid,
            axi_wready => timer_axi_wready,
            axi_wdata => timer_axi_wdata,
            axi_wstrb => timer_axi_wstrb,
            axi_bvalid => timer_axi_bvalid,
            axi_bready => timer_axi_bready,
            axi_bresp => timer_axi_bresp,
            axi_araddr => timer_axi_araddr,
            axi_arprot => timer_axi_arprot,
            axi_arvalid => timer_axi_arvalid,
            axi_arready => timer_axi_arready,
            axi_rdata => timer_axi_rdata,
            axi_rvalid => timer_axi_rvalid,
            axi_rready => timer_axi_rready,
            axi_rresp => timer_axi_rresp,
            done => timer_done);
        
end Behavioral;
