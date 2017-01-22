---------------------------------------------------------------------
-- TITLE: Plasma-SoC Misc. Package
-- AUTHOR: Andrew Powell (andrewandrepowell2@gmail.com)
-- DATE CREATED: 1/07/2017
-- FILENAME: mlitesoc_pack.vhd
-- PROJECT: Plasma-SoC core (extension of the Plasma CPU project)
-- COPYRIGHT: Software placed into the public domain by the author.
--    Software 'as is' without warranty.  Author liable for nothing.
-- DESCRIPTION:
--    Data types, constants, and add functions needed for the Plasma-SoC CPU.
---------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

package mlitesoc_pack is

    function clogb2(bit_depth : in integer ) return integer;
    function add_offset2base( base_address : in std_logic_vector; offset : in integer ) return std_logic_vector;

    component memplasma is
        generic(
            -- cpu constants
            cpu_mult_type       : string  := "DEFAULT"; --AREA_OPTIMIZED
            cpu_shifter_type    : string  := "DEFAULT"; --AREA_OPTIMIZED
            cpu_alu_type        : string  := "DEFAULT"; --AREA_OPTIMIZED
            -- cache constants
            cache_address_width : integer := 11;
            cache_way_width : integer := 1; 
            cache_index_width : integer := 4;
            cache_offset_width : integer := 5;
            cache_replace_strat : string := "plru";
            -- cpu addresses
            cache_base_address : std_logic_vector := X"10000000" );
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
    end component;

   component l1_cache_cntrl is
        generic (
            -- cpu constants
            cpu_address_width : integer := 16;
            cpu_data_width : integer := 32;
            -- cache constants
            cache_address_width : integer := 10;
            cache_way_width : integer := 1; 
            cache_index_width : integer := 4;
            cache_offset_width : integer := 4;
            cache_replace_strat : string := "plru";
            cache_base_address : std_logic_vector := X"0000" ); 
        port ( 
            -- global interface.
            clock : in std_logic; 
            resetn : in std_logic;
            -- cpu interface.
            cpu_address : in std_logic_vector(cpu_address_width-1 downto 0); 
            cpu_in_data : in std_logic_vector(cpu_data_width-1 downto 0);
            cpu_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
            cpu_strobe : in std_logic_vector(cpu_data_width/8-1 downto 0);
            cpu_pause : out std_logic;
            -- cache interface.
            cache_out_address: out std_logic_vector(cache_index_width-1 downto 0);
            cache_out_data : out std_logic_vector(((cache_address_width-cache_index_width-cache_offset_width)+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
            cache_out_tag_enable : out std_logic_vector(2**cache_way_width-1 downto 0);
            cache_out_block_enable : out std_logic_vector(2**cache_way_width*2**cache_offset_width/(cpu_data_width/8)-1 downto 0);
            cache_in_address : out std_logic_vector(cache_index_width-1 downto 0);
            cache_in_data : in std_logic_vector(((cache_address_width-cache_index_width-cache_offset_width)+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
            -- simple mem interface
            mem_in_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
            mem_in_data : in std_logic_vector(cpu_data_width-1 downto 0);
            mem_in_enable : out std_logic;
            mem_in_valid : in std_logic;
            mem_in_ready : out std_logic;
            mem_out_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
            mem_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
            mem_out_strobe : out std_logic_vector(cpu_data_width/8-1 downto 0);
            mem_out_enable : out std_logic;
            mem_out_valid : out std_logic;
            mem_out_ready : in std_logic); 
    end component;
    
    component l1_cache_buff is
        generic (
            -- Global parameters.
            glb_data_width : integer := 32;
            -- Cache related parameters.
            cache_tag_width : integer := 22;
            cache_index_width : integer := 5;
            cache_offset_width : integer := 4;
            cache_way_width : integer := 2 );
        port(
            -- Global interface.
            clock : in std_logic;
            -- Cache controller interface.
            cache_in_data : in std_logic_vector((cache_tag_width+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
            cache_in_index : in std_logic_vector(cache_index_width-1 downto 0);
            cache_in_tag_enable : in std_logic_vector(2**cache_way_width-1 downto 0);
            cache_in_offset_enable : in std_logic_vector(2**cache_way_width*2**cache_offset_width/(glb_data_width/8)-1 downto 0);
            cache_out_data : out std_logic_vector((cache_tag_width+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
            cache_out_index : in std_logic_vector(cache_index_width-1 downto 0));
    end component;

end; --package body

package body mlitesoc_pack is

	function clogb2(bit_depth : in natural ) return integer is
		variable result : integer := 0;
		variable bit_depth_buff : integer := bit_depth;
	begin
		while bit_depth_buff>1 loop
			bit_depth_buff := bit_depth_buff/2;
			result := result+1;
		end loop; 
		return result;
	end; --function
	
	function add_offset2base( base_address : in std_logic_vector; offset : in integer ) return std_logic_vector is
        variable result : std_logic_vector(base_address'length-1 downto 0);
    begin
        result := std_logic_vector(to_unsigned(to_integer(unsigned(base_address))+offset,base_address'length));
        return result;
    end;

end; --package body
