library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.mlitesoc_pack.all;


entity axiplasma_wrapper is
    port( 
        raw_clock : in std_logic; -- 100 MHz on the Nexys 4.
        raw_nreset : in std_logic;
        gpio_output : out std_logic_vector(15 downto 0);
        gpio_input : in std_logic_vector(15 downto 0));
end axiplasma_wrapper;

architecture Behavioral of axiplasma_wrapper is
    -- Component declarations.
    component ip_block_design_wrapper is
      port (
        aclk : out STD_LOGIC;
        aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
        axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
        axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
        axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
        axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
        axi_arlock : in STD_LOGIC_VECTOR ( 0 to 0 );
        axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
        axi_arqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
        axi_arready : out STD_LOGIC;
        axi_arregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
        axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
        axi_arvalid : in STD_LOGIC;
        axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
        axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
        axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
        axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
        axi_awlock : in STD_LOGIC_VECTOR ( 0 to 0 );
        axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
        axi_awqos : in STD_LOGIC_VECTOR ( 3 downto 0 );
        axi_awready : out STD_LOGIC;
        axi_awregion : in STD_LOGIC_VECTOR ( 3 downto 0 );
        axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
        axi_awvalid : in STD_LOGIC;
        axi_bready : in STD_LOGIC;
        axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
        axi_bvalid : out STD_LOGIC;
        axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
        axi_rlast : out STD_LOGIC;
        axi_rready : in STD_LOGIC;
        axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
        axi_rvalid : out STD_LOGIC;
        axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
        axi_wlast : in STD_LOGIC;
        axi_wready : out STD_LOGIC;
        axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
        axi_wvalid : in STD_LOGIC;
        gpio_input_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
        gpio_input_1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
        gpio_output : out STD_LOGIC_VECTOR ( 15 downto 0 );
        int_0 : out STD_LOGIC;
        int_1 : out STD_LOGIC;
        int_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
        int_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
        int_axi_arready : in STD_LOGIC;
        int_axi_arvalid : out STD_LOGIC;
        int_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
        int_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
        int_axi_awready : in STD_LOGIC;
        int_axi_awvalid : out STD_LOGIC;
        int_axi_bready : out STD_LOGIC;
        int_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
        int_axi_bvalid : in STD_LOGIC;
        int_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
        int_axi_rready : out STD_LOGIC;
        int_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
        int_axi_rvalid : in STD_LOGIC;
        int_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
        int_axi_wready : in STD_LOGIC;
        int_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
        int_axi_wvalid : out STD_LOGIC;
        ram_addr : out STD_LOGIC_VECTOR ( 15 downto 0 );
        ram_clk : out STD_LOGIC;
        ram_din : out STD_LOGIC_VECTOR ( 31 downto 0 );
        ram_dout : in STD_LOGIC_VECTOR ( 31 downto 0 );
        ram_en : out STD_LOGIC;
        ram_rst : out STD_LOGIC;
        ram_we : out STD_LOGIC_VECTOR ( 3 downto 0 );
        raw_clock : in STD_LOGIC;
        raw_nreset : in STD_LOGIC
      );
    end component;
    component ram is
        port(
            bram_rst_a : in STD_LOGIC;
            bram_clk_a : in STD_LOGIC;
            bram_en_a : in STD_LOGIC;
            bram_we_a : in STD_LOGIC_VECTOR(3 DOWNTO 0);
            bram_addr_a : in STD_LOGIC_VECTOR(15 DOWNTO 0);
            bram_wrdata_a : in STD_LOGIC_VECTOR(31 DOWNTO 0);
            bram_rddata_a : out STD_LOGIC_VECTOR(31 DOWNTO 0));
    end component;
    -- global interface.
    signal aclk : std_logic;
    signal aresetn : std_logic_vector(0 downto 0);
    -- axi interface between master axiplasma and slave bram.
    signal axi_awid : std_logic_vector(0 downto 0);
    signal axi_awaddr : std_logic_vector(31 downto 0);
    signal axi_awlen : std_logic_vector(7 downto 0);
    signal axi_awsize : std_logic_vector(2 downto 0);
    signal axi_awburst : std_logic_vector(1 downto 0);
    signal axi_awlock : std_logic_vector(0 downto 0);
    signal axi_awcache : std_logic_vector(3 downto 0);
    signal axi_awprot : std_logic_vector(2 downto 0);
    signal axi_awqos : std_logic_vector(3 downto 0);
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
    signal axi_arvalid : std_logic;
    signal axi_arready : std_logic;
    signal axi_rid : std_logic_vector(0 downto 0);
    signal axi_rdata : std_logic_vector(31 downto 0);
    signal axi_rresp : std_logic_vector(1 downto 0);
    signal axi_rlast : std_logic;
    signal axi_rvalid : std_logic;
    signal axi_rready : std_logic;
    -- bram interface between axi bram controller and bram. The bram emulates rams.
    signal bram_rst_a : std_logic;
    signal bram_clk_a : std_logic;
    signal bram_en_a : std_logic;
    signal bram_we_a : std_logic_vector(3 downto 0);
    signal bram_addr_a : std_logic_vector(15 downto 0);
    signal bram_wrdata_a : std_logic_vector(31 downto 0);
    signal bram_rddata_a : std_logic_vector(31 downto 0);
    -- gpio interface.
    signal gpio_input_0 : STD_LOGIC_VECTOR ( 7 downto 0 );
    signal gpio_input_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
    signal gpio_int_0 : STD_LOGIC;
    signal gpio_int_1 : STD_LOGIC;
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
begin
    gpio_input_0 <= gpio_input(7 downto 0);
    gpio_input_1 <= gpio_input(15 downto 8);
    dev_ints(1 downto 0) <= gpio_int_1 & gpio_int_0;
    dev_ints(default_interrupt_total-1 downto 2) <= (others=>'0');
     
    -- The IP block design contains all of the xilinx ip needed 
    -- to complete this verification application.
    ip_block_design_wrapper_inst : 
    ip_block_design_wrapper
    port map (
        aclk => aclk,
        aresetn => aresetn,
        axi_araddr => axi_araddr,
        axi_arburst => axi_arburst,
        axi_arcache => axi_arcache,
        axi_arlen => axi_arlen,
        axi_arlock => axi_arlock,
        axi_arprot => axi_arprot,
        axi_arqos => axi_arqos,
        axi_arready => axi_arready,
        axi_arregion => X"0",
        axi_arsize => axi_arsize,
        axi_arvalid => axi_arvalid,
        axi_awaddr => axi_awaddr,
        axi_awburst => axi_awburst,
        axi_awcache => axi_awcache,
        axi_awlen => axi_awlen,
        axi_awlock => axi_awlock,
        axi_awprot => axi_awprot,
        axi_awqos => axi_awqos,
        axi_awready => axi_awready,
        axi_awsize => axi_awsize,
        axi_awvalid => axi_awvalid,
        axi_awregion => X"0",
        axi_bready => axi_bready,
        axi_bresp => axi_bresp,
        axi_bvalid => axi_bvalid,
        axi_rdata => axi_rdata,
        axi_rlast => axi_rlast,
        axi_rready => axi_rready,
        axi_rresp => axi_rresp,
        axi_rvalid => axi_rvalid,
        axi_wdata => axi_wdata,
        axi_wlast => axi_wlast,
        axi_wready => axi_wready,
        axi_wstrb => axi_wstrb,
        axi_wvalid => axi_wvalid,
        gpio_input_0 => gpio_input_0,
        gpio_input_1 => gpio_input_1,
        gpio_output => gpio_output,
        int_0 => gpio_int_0,
        int_1 => gpio_int_1,
        int_axi_araddr => int_axi_araddr,
        int_axi_arprot => int_axi_arprot,
        int_axi_arready => int_axi_arready,
        int_axi_arvalid => int_axi_arvalid,
        int_axi_awaddr => int_axi_awaddr,
        int_axi_awprot => int_axi_awprot,
        int_axi_awready => int_axi_awready,
        int_axi_awvalid => int_axi_awvalid,
        int_axi_bready => int_axi_bready,
        int_axi_bresp => int_axi_bresp,
        int_axi_bvalid => int_axi_bvalid,
        int_axi_rdata => int_axi_rdata,
        int_axi_rready => int_axi_rready,
        int_axi_rresp => int_axi_rresp,
        int_axi_rvalid => int_axi_rvalid,
        int_axi_wdata => int_axi_wdata,
        int_axi_wready => int_axi_wready,
        int_axi_wstrb => int_axi_wstrb,
        int_axi_wvalid => int_axi_wvalid,
        ram_addr => bram_addr_a,
        ram_clk => bram_clk_a,
        ram_din => bram_wrdata_a,
        ram_dout => bram_rddata_a,
        ram_en => bram_en_a,
        ram_rst => bram_rst_a,
        ram_we => bram_we_a,
        raw_clock => raw_clock,
        raw_nreset => raw_nreset);
    -- axiplasma instantiation.
    axiplasma_inst :
    axiplasma 
        generic map (
            cpu_mult_type => default_cpu_mult_type,
            cpu_shifter_type => default_cpu_shifter_type,
            cpu_alu_type  => default_cpu_alu_type,
            cache_address_width => default_cache_address_width,
            cache_way_width => default_cache_way_width, 
            cache_index_width => default_cache_index_width,
            cache_offset_width => default_cache_offset_width,
            cache_replace_strat => default_cache_replace_strat,
            cache_base_address => default_cache_base_address,
            cache_enable => default_cache_enable)
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
            axi_awvalid => axi_awvalid,
            axi_awready => axi_awready,
            axi_wdata => axi_wdata,
            axi_wstrb => axi_wstrb,
            axi_wlast => axi_wlast,
            axi_wvalid => axi_wvalid,
            axi_wready => axi_wready,
            axi_bid => (others=>'0'),
            axi_bresp => axi_bresp,
            axi_bvalid => axi_bvalid,
            axi_bready => axi_bready,
            axi_arid => open,
            axi_araddr => axi_araddr,
            axi_arlen => axi_arlen,
            axi_arsize => axi_arsize,
            axi_arburst => axi_arburst,
            axi_arlock => axi_arlock(0),
            axi_arcache => axi_arcache,
            axi_arprot => axi_arprot,
            axi_arqos => axi_arqos,
            axi_arvalid => axi_arvalid,
            axi_arready => axi_arready,
            axi_rid => (others=>'0'),
            axi_rdata => axi_rdata,
            axi_rresp => axi_rresp,
            axi_rlast => axi_rlast,
            axi_rvalid => axi_rvalid,
            axi_rready => axi_rready,
            intr_in  => cpu_int,
            debug_cpu_pause => open );
    -- ram instantiation. Recall, the ram is actually emulated by bram for this test program.
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
    -- interrupt controller instantiation.
    plasoc_int_inst :
    plasoc_int 
        generic map (
            axi_address_width => 32,
            axi_data_width => 32,
            interrupt_total => default_interrupt_total,
            int_id_address => default_int_id_offset,
            int_enables_address => default_int_enables_offset,
            int_active_address => default_int_active_address )
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
        
end Behavioral;
