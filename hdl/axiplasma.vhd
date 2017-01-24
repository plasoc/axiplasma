---------------------------------------------------------------------
-- TITLE: Plasma-SoC Baseline Processor with Mem Interface
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
        cpu_mult_type       : string  := "DEFAULT"; --AREA_OPTIMIZED
        cpu_shifter_type    : string  := "DEFAULT"; --AREA_OPTIMIZED
        cpu_alu_type        : string  := "DEFAULT"; --AREA_OPTIMIZED
        -- cache constants
        cache_address_width : integer := 12;
        cache_way_width : integer := 2; 
        cache_index_width : integer := 4;
        cache_offset_width : integer := 5;
        cache_replace_strat : string := "plru";
        cache_base_address : std_logic_vector := X"10000000";
        cache_enable : boolean := True );
    port(
        -- global signals
        aclk : in std_logic;
        aresetn     : in std_logic;
        -- mem signals
        mem_in_address : out std_logic_vector(31 downto 0);
        mem_in_data : in std_logic_vector(31 downto 0);
        mem_in_enable : out std_logic;
        mem_in_valid : in std_logic;
        mem_in_ready : out std_logic;
        mem_out_address : out std_logic_vector(31 downto 0);
        mem_out_data : out std_logic_vector(31 downto 0);
        mem_out_strobe : out std_logic_vector(3 downto 0);
        mem_out_enable : out std_logic;
        mem_out_valid : out std_logic;
        mem_out_ready : in std_logic;
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
    subtype cache_index_type is std_logic_vector(cache_index_width-1 downto 0);
    subtype cache_data_type is std_logic_vector(cache_line_width*2**cache_way_width-1 downto 0);
    subtype cache_write_block_enable_type is std_logic_vector(2**(cache_way_width+cache_word_offset_width)-1 downto 0);
    signal reset_in : std_logic;
    signal cpu_write_data : std_logic_vector(cpu_width-1 downto 0);
    signal cpu_read_data : std_logic_vector(cpu_width-1 downto 0);
    signal cpu_address_next : std_logic_vector(cpu_width-1 downto 0);
    signal cpu_strobe_next : std_logic_vector(cpu_width/8-1 downto 0); 
    signal cpu_pause    : std_logic;
    signal cache_write_index : cache_index_type;
    signal cache_write_data : cache_data_type := (others=>'0');
    signal cache_write_tag_enable : std_logic_vector(2**cache_way_width-1 downto 0);
    signal cache_write_block_enable : cache_write_block_enable_type;
    signal cache_read_index : cache_index_type;
    signal cache_read_data :cache_data_type := (others=>'0');
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
                cache_cacheable => open,
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
            cache_cacheable => open,
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

end Behavioral;
