---------------------------------------------------------------------
-- TITLE: Plasma-SoC Baseline Processor with AXI4-Full Interface.
-- AUTHOR: Andrew Powell (andrewandrepowell2@gmail.com)
-- DATE CREATED: 1/07/2017
-- FILENAME: mlitesoc_pack.vhd
-- PROJECT: Plasma-SoC core (extension of the Plasma CPU project)
-- COPYRIGHT: Software placed into the public domain by the author.
--    Software 'as is' without warranty.  Author liable for nothing.
-- DESCRIPTION:
--    The top model of this version of the Plasma-SoC Baseline Processor.
---------------------------------------------------------------------

library ieee;
use work.mlite_pack.all;
use work.mlitesoc_pack.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity axiplasma is
    generic(
        -- cpu constants
        cpu_mult_type       : string  := default_cpu_mult_type; -- DEFAULT --AREA_OPTIMIZED
        cpu_shifter_type    : string  := default_cpu_shifter_type; -- DEFAULT --AREA_OPTIMIZED
        cpu_alu_type        : string  := default_cpu_alu_type; --DEFAULT --AREA_OPTIMIZED
        -- cache constants
        cache_address_width : integer := default_cache_address_width;
        cache_way_width : integer := default_cache_way_width; 
        cache_index_width : integer := default_cache_index_width;
        cache_offset_width : integer := default_cache_offset_width;
        cache_replace_strat : string := default_cache_replace_strat;
        cache_base_address : std_logic_vector := default_cache_base_address;
        cache_enable : boolean := default_cache_enable );
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
end axiplasma;

architecture Behavioral of axiplasma is
    constant cpu_width : integer := 32;
    constant cpu_memory_type     : string  := "DUAL_PORT_"; 
    constant cpu_pipeline_stages : natural := 3; 
    constant cache_tag_width : integer := cache_address_width-cache_index_width-cache_offset_width;
    constant cache_word_offset_width : integer := cache_offset_width-clogb2(cpu_width/8);
    constant cache_line_width : integer := (cache_tag_width+8*2**cache_offset_width);
    constant axi_user_width : integer := 1;
    subtype cache_index_type is std_logic_vector(cache_index_width-1 downto 0);
    subtype cache_data_type is std_logic_vector(cache_line_width*2**cache_way_width-1 downto 0);
    subtype cache_write_block_enable_type is std_logic_vector(2**(cache_way_width+cache_word_offset_width)-1 downto 0);
    -- CPU interface signals.
    signal cpu_write_data : std_logic_vector(cpu_width-1 downto 0);
    signal cpu_read_data : std_logic_vector(cpu_width-1 downto 0);
    signal cpu_address_next : std_logic_vector(cpu_width-1 downto 0);
    signal cpu_strobe_next : std_logic_vector(cpu_width/8-1 downto 0); 
    signal cpu_pause    : std_logic;
    -- Cache interface signals.
    signal cache_write_index : cache_index_type;
    signal cache_write_data : cache_data_type := (others=>'0');
    signal cache_write_tag_enable : std_logic_vector(2**cache_way_width-1 downto 0);
    signal cache_write_block_enable : cache_write_block_enable_type;
    signal cache_read_index : cache_index_type;
    signal cache_read_data :cache_data_type := (others=>'0');
    signal cache_cacheable : std_logic;
    -- Memory interface signals
    signal mem_in_address : std_logic_vector(cpu_width-1 downto 0);
    signal mem_in_data : std_logic_vector(cpu_width-1 downto 0);
    signal mem_in_enable : std_logic;
    signal mem_in_valid : std_logic;
    signal mem_in_ready : std_logic;
    signal mem_out_address : std_logic_vector(cpu_width-1 downto 0);
    signal mem_out_data : std_logic_vector(cpu_width-1 downto 0);
    signal mem_out_strobe : std_logic_vector(cpu_width/8-1 downto 0);
    signal mem_out_enable : std_logic;
    signal mem_out_valid : std_logic;
    signal mem_out_ready : std_logic;
begin
    cpu_address_next(1 downto 0) <= "00";
    debug_cpu_pause <= cpu_pause;
    -- CPU instantiation.
    mlite_cpu_inst:  
    mlite_cpu 
        generic map (
            memory_type => cpu_memory_type,
            mult_type => cpu_mult_type,
            shifter_type => cpu_shifter_type,
            alu_type => cpu_alu_type,
            pipeline_stages => cpu_pipeline_stages )
        port map (
            clk => aclk,
            reset_in => "not" (aresetn),
            intr_in => intr_in,
            address_next => cpu_address_next(cpu_width-1 downto 2),
            byte_we_next => cpu_strobe_next,
            address => open,
            byte_we => open,
            data_w => cpu_write_data,
            data_r => cpu_read_data,
            mem_pause => cpu_pause );
    -- If cache is enabled, instantiate controller and buffer.
    gen_cache :
    if cache_enable=True generate
        -- Cache controller instantiation.
        l1_cache_cntrl_inst: 
        l1_cache_cntrl 
            generic map (
                cpu_address_width => cpu_width,
                cpu_data_width => cpu_width,
                cache_address_width => cache_address_width,
                cache_way_width => cache_way_width, 
                cache_index_width => cache_index_width,
                cache_offset_width => cache_offset_width,
                cache_replace_strat => cache_replace_strat,
                cache_base_address => cache_base_address)
             port map ( 
                clock => aclk,
                resetn => aresetn,
                cpu_address => cpu_address_next,
                cpu_in_data => cpu_write_data,
                cpu_out_data => cpu_read_data,
                cpu_strobe => cpu_strobe_next,
                cpu_pause => cpu_pause,
                cache_cacheable => cache_cacheable,
                cache_out_address => cache_write_index,
                cache_out_data => cache_write_data,
                cache_out_tag_enable => cache_write_tag_enable,
                cache_out_block_enable => cache_write_block_enable,
                cache_in_address => cache_read_index,
                cache_in_data => cache_read_data,
                mem_in_address => mem_in_address,
                mem_in_data => mem_in_data,
                mem_in_enable => mem_in_enable,
                mem_in_valid => mem_in_valid,
                mem_in_ready => mem_in_ready,
                mem_out_address => mem_out_address,
                mem_out_data => mem_out_data,
                mem_out_strobe => mem_out_strobe,
                mem_out_enable => mem_out_enable,
                mem_out_valid => mem_out_valid,
                mem_out_ready => mem_out_ready);
        -- Cache buffer instantiation.
        l1_cache_buff_inst : 
        l1_cache_buff 
            generic map (
                glb_data_width => cpu_width,
                cache_tag_width => cache_tag_width,
                cache_index_width => cache_index_width,
                cache_offset_width => cache_offset_width,
                cache_way_width => cache_way_width )
            port map (
                clock => aclk,
                cache_in_data => cache_write_data,
                cache_in_index => cache_write_index,
                cache_in_tag_enable => cache_write_tag_enable,
                cache_in_offset_enable => cache_write_block_enable,
                cache_out_data => cache_read_data,
                cache_out_index => cache_read_index);
    end generate;
    -- If cache is disabled, instantiate memory controller.
    gen_no_cache :
    if cache_enable=False generate
        -- Memory controller instantiation.
        mem_cntrl_inst :
        mem_cntrl 
            generic map (
                cpu_address_width => cpu_width,
                cpu_data_width => cpu_width )
            port map (
                clock => aclk,
                resetn => aresetn,
                cpu_address => cpu_address_next,
                cpu_in_data => cpu_write_data,
                cpu_out_data => cpu_read_data,
                cpu_strobe => cpu_strobe_next,
                cpu_pause => cpu_pause,
                cache_cacheable => cache_cacheable,
                mem_in_address => mem_in_address,
                mem_in_data => mem_in_data,
                mem_in_enable => mem_in_enable,
                mem_in_valid => mem_in_valid,
                mem_in_ready => mem_in_ready,
                mem_out_address => mem_out_address,
                mem_out_data => mem_out_data,
                mem_out_strobe => mem_out_strobe,
                mem_out_enable => mem_out_enable,
                mem_out_valid => mem_out_valid,
                mem_out_ready => mem_out_ready);
    end generate;
    -- axi write controller.
    plasoc_axi4_write_cntrl_inst : 
    plasoc_axi4_write_cntrl 
        generic map (
            cpu_address_width => cpu_width,
            cpu_data_width => cpu_width,
            cache_offset_width => cache_offset_width,
            axi_awuser_width => axi_user_width,
            axi_wuser_width => axi_user_width,
            axi_buser_width => axi_user_width)
        port map (
            clock => aclk,
            nreset => aresetn,
            mem_write_address => mem_out_address,
            mem_write_data => mem_out_data,
            mem_write_strobe => mem_out_strobe,
            mem_write_enable => mem_out_enable,
            mem_write_valid => mem_out_valid,
            mem_write_ready => mem_out_ready,
            cache_cacheable => cache_cacheable,
            axi_awid => axi_awid,
            axi_awaddr => axi_awaddr,
            axi_awlen => axi_awlen,
            axi_awsize => axi_awsize,
            axi_awburst => axi_awburst,
            axi_awlock => axi_awlock,
            axi_awcache => axi_awcache,
            axi_awprot => axi_awprot,
            axi_awqos => axi_awqos,
            axi_awuser => open,
            axi_awvalid => axi_awvalid,
            axi_awready => axi_awready,
            axi_wdata => axi_wdata,
            axi_wstrb => axi_wstrb,
            axi_wlast => axi_wlast,
            axi_wuser => open,
            axi_wvalid => axi_wvalid,
            axi_wready => axi_wready,
            axi_bid => axi_bid,
            axi_bresp => axi_bresp,
            axi_buser => (others=>'0'),
            axi_bvalid => axi_bvalid,
            axi_bready => axi_bready,
            error_data => open);
    -- axi read controller.
    plasoc_axi4_read_cntrl_inst :
    plasoc_axi4_read_cntrl 
        generic map (
            cpu_address_width => cpu_width,
            cpu_data_width => cpu_width,
            cache_offset_width => cache_offset_width,
            axi_aruser_width => axi_user_width,
            axi_ruser_width => axi_user_width)
        port map (
            clock => aclk,
            nreset => aresetn,
            mem_read_address => mem_in_address,
            mem_read_data => mem_in_data,
            mem_read_enable => mem_in_enable,
            mem_read_valid => mem_in_valid,
            mem_read_ready => mem_in_ready,
            cache_cacheable => cache_cacheable,
            axi_arid => axi_arid,
            axi_araddr => axi_araddr,
            axi_arlen => axi_arlen,
            axi_arsize => axi_arsize,
            axi_arburst => axi_arburst,
            axi_arlock => axi_arlock,
            axi_arcache => axi_arcache,
            axi_arprot => axi_arprot,
            axi_arqos => axi_arqos,
            axi_aruser => open,
            axi_arvalid => axi_arvalid,
            axi_arready => axi_arready,
            axi_rid => axi_rid,
            axi_rdata => axi_rdata,
            axi_rresp => axi_rresp,
            axi_rlast => axi_rlast,
            axi_ruser => (others=>'0'),
            axi_rvalid => axi_rvalid,
            axi_rready => axi_rready,
            error_data => open);
end Behavioral;
