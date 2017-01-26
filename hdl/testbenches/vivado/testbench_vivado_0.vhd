library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use work.mlite_pack.all;
use work.mlitesoc_pack.all;

entity testbench_vivado_0 is
    generic (indelay : time := 2 ns);
end testbench_vivado_0;

architecture Behavioral of testbench_vivado_0 is
    -- Component declaration of the Plasma-SoC
    component axiplasma is
        port(
            -- global signals
            aclk : in std_logic;
            aresetn     : in std_logic;
            -- axi write interface.
            axi_awid : out std_logic_vector(0 downto 0);
            axi_awaddr : out std_logic_vector(31 downto 0);
            axi_awlen : out std_logic_vector(7 downto 0);
            axi_awsize : out std_logic_vector(2 downto 0);
            axi_awburst : out std_logic_vector(1 downto 0);
            axi_awlock : out std_logic;
            axi_awcache : out std_logic_vector(3 downto 0);
            axi_awprot : out std_logic_vector(2 downto 0);
            axi_awqos : out std_logic_vector(3 downto 0);
            axi_awvalid : out std_logic;
            axi_awready : in std_logic;
            axi_wdata : out std_logic_vector(31 downto 0);
            axi_wstrb : out std_logic_vector(3 downto 0);
            axi_wlast : out std_logic;
            axi_wvalid : out std_logic;
            axi_wready : in std_logic;
            axi_bid : in std_logic_vector(0 downto 0);
            axi_bresp : in  std_logic_vector(1 downto 0);
            axi_bvalid : in std_logic;
            axi_bready : out std_logic;
            -- axi read interface.
            axi_arid : out std_logic_vector(0 downto 0);
            axi_araddr : out std_logic_vector(31 downto 0);
            axi_arlen : out std_logic_vector(7 downto 0);
            axi_arsize : out std_logic_vector(2 downto 0);
            axi_arburst : out std_logic_vector(1 downto 0);
            axi_arlock : out std_logic;
            axi_arcache : out std_logic_vector(3 downto 0);
            axi_arprot : out std_logic_vector(2 downto 0);
            axi_arqos : out std_logic_vector(3 downto 0);
            axi_arvalid : out std_logic;
            axi_arready : in std_logic;
            axi_rid : in std_logic_vector(0 downto 0);
            axi_rdata : in std_logic_vector(31 downto 0);
            axi_rresp : in std_logic_vector(1 downto 0);
            axi_rlast : in std_logic;
            axi_rvalid : in std_logic;
            axi_rready : out std_logic;
            -- cpu signals
            intr_in      : in std_logic;
            -- debug signals.
            debug_cpu_pause : out std_logic );
    end component;
    -- axi bram controller component declaration.
    component axi_bram_ctrl_0 is
      PORT (
        s_axi_aclk : IN STD_LOGIC;
        s_axi_aresetn : IN STD_LOGIC;
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
        s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_bvalid : OUT STD_LOGIC;
        s_axi_bready : IN STD_LOGIC;
        s_axi_araddr : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s_axi_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        s_axi_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        s_axi_arlock : IN STD_LOGIC;
        s_axi_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        s_axi_arvalid : IN STD_LOGIC;
        s_axi_arready : OUT STD_LOGIC;
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
    end component;
    -- Signal declarations.
    signal aclk : std_logic;
    signal aresetn     : std_logic;
    signal axi_awid : std_logic_vector(0 downto 0);
    signal axi_awaddr : std_logic_vector(31 downto 0);
    signal axi_awlen : std_logic_vector(7 downto 0);
    signal axi_awsize : std_logic_vector(2 downto 0);
    signal axi_awburst : std_logic_vector(1 downto 0);
    signal axi_awlock : std_logic;
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
    signal axi_arlock : std_logic;
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
    signal intr_in      : std_logic;
    signal debug_cpu_pause : std_logic;
    signal bram_rst_a : STD_LOGIC;
    signal bram_clk_a : STD_LOGIC;
    signal bram_en_a : STD_LOGIC;
    signal bram_we_a : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal bram_addr_a : STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal bram_wrdata_a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal bram_rddata_a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal mlite_address_next : std_logic_vector(31 downto 0);
    signal mlite_strobe_next : std_logic_vector(3 downto 0);
    signal mlite_data_w : std_logic_vector(31 downto 0);
    signal mlite_data_r: std_logic_vector(31 downto 0);
begin
    -- axiplasma instantiation.
    axiplasma_inst :
    axiplasma 
        port map (
            aclk => aclk,
            aresetn => aresetn,
            axi_awid => axi_awid,
            axi_awaddr => axi_awaddr,
            axi_awlen => axi_awlen,
            axi_awsize => axi_awsize,
            axi_awburst => axi_awburst,
            axi_awlock => axi_arlock,
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
            axi_bid => axi_bid,
            axi_bresp => axi_bresp,
            axi_bvalid => axi_bvalid,
            axi_bready => axi_bready,
            axi_arid => axi_arid,
            axi_araddr => axi_araddr,
            axi_arlen => axi_arlen,
            axi_arsize => axi_arsize,
            axi_arburst => axi_arburst,
            axi_arlock => axi_arlock,
            axi_arcache => axi_arcache,
            axi_arprot => axi_arprot,
            axi_arqos => axi_arqos,
            axi_arvalid => axi_arvalid,
            axi_arready => axi_arready,
            axi_rid => axi_rid,
            axi_rdata => axi_rdata,
            axi_rresp => axi_rresp,
            axi_rlast => axi_rlast,
            axi_rvalid => axi_rvalid,
            axi_rready => axi_rready,
            intr_in  => '0',
            debug_cpu_pause => debug_cpu_pause );
    -- axi bram controller instantiation.
    axi_bram_ctrl_0_inst : 
    axi_bram_ctrl_0 
          port map (
            s_axi_aclk => aclk,
            s_axi_aresetn => aresetn,
            s_axi_awaddr => axi_awaddr(15 downto 0),
            s_axi_awlen => axi_awlen,
            s_axi_awsize => axi_awsize,
            s_axi_awburst => axi_awburst,
            s_axi_awlock => axi_awlock,
            s_axi_awcache => axi_awcache,
            s_axi_awprot => axi_awprot,
            s_axi_awvalid => axi_awvalid,
            s_axi_awready => axi_awready,
            s_axi_wdata => axi_wdata,
            s_axi_wstrb => axi_wstrb,
            s_axi_wlast => axi_wlast,
            s_axi_wvalid => axi_wvalid,
            s_axi_wready => axi_wready,
            s_axi_bresp => axi_bresp,
            s_axi_bvalid => axi_bvalid,
            s_axi_bready => axi_bready,
            s_axi_araddr => axi_araddr(15 downto 0),
            s_axi_arlen => axi_arlen,
            s_axi_arsize => axi_arsize,
            s_axi_arburst => axi_arburst,
            s_axi_arlock => axi_arlock,
            s_axi_arcache => axi_arcache,
            s_axi_arprot => axi_arprot,
            s_axi_arvalid => axi_arvalid,
            s_axi_arready => axi_arready,
            s_axi_rdata => axi_rdata,
            s_axi_rresp => axi_rresp,
            s_axi_rlast => axi_rlast,
            s_axi_rvalid => axi_rvalid,
            s_axi_rready => axi_rready,
            bram_rst_a => bram_rst_a,
            bram_clk_a => aclk,
            bram_en_a => bram_en_a,
            bram_we_a => bram_we_a,
            bram_addr_a => bram_addr_a,
            bram_wrdata_a => bram_wrdata_a,
            bram_rddata_a => bram_rddata_a);
    -- Mlite instantiation.
    mlite_cpu_inst:  
    mlite_cpu 
        generic map (
            memory_type => "DUAL_PORT_",
            mult_type => default_cpu_mult_type,
            shifter_type => default_cpu_shifter_type,
            alu_type => default_cpu_alu_type,
            pipeline_stages => 3 )
        port map (
            clk => aclk,
            reset_in => "not" (aresetn),
            intr_in => '0',
            address_next => mlite_address_next,
            byte_we_next => mlite_strobe_next,
            address => open,
            byte_we => open,
            data_w => mlite_data_w,
            data_r => mlite_data_r,
            mem_pause => debug_cpu_pause );

end Behavioral;
