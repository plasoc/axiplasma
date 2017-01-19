---------------------------------------------------------------------
-- TITLE: L1 Cache Buffer of Plasma-SoC Baseline Processor 
-- AUTHOR: Andrew Powell (andrewandrepowell2@gmail.com)
-- DATE CREATED: 1/17/2017
-- FILENAME: l1_cache_buff.vhd
-- PROJECT: Plasma-SoC core (extension of the Plasma CPU project)
-- COPYRIGHT: Software placed into the public domain by the author.
--    Software 'as is' without warranty.  Author liable for nothing.
-- DESCRIPTION:
--    Defines the buffer to the L1 Write-Back Cache. In future versions
--    of this description, I may move some of the combinatorial logic
--    from the cache controller to the buffer description.
---------------------------------------------------------------------

library ieee;
use work.mlitesoc_pack.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.mlitesoc_pack.all;

entity l1_cache_buff is
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
end entity l1_cache_buff;

architecture Behavioral of l1_cache_buff is
    constant cache_word_offset_width : integer := cache_offset_width-clogb2(glb_data_width/8);
    constant cache_line_width : integer := (cache_tag_width+8*2**cache_offset_width);
    subtype cache_address_type is std_logic_vector(cache_index_width-1 downto 0);
    subtype cache_data_type is std_logic_vector(cache_line_width*2**cache_way_width-1 downto 0);
    subtype cache_line_type is std_logic_vector(cache_line_width-1 downto 0);
    type cache_buffer_type is array(0 to 2**cache_index_width-1) of cache_data_type;
    signal cache_buffer : cache_buffer_type := (others=>(others=>'0'));
begin

    cache_out_data <= cache_buffer(to_integer(unsigned(cache_out_index)));
    
    process (clock)
        variable address : integer range 0 to 2**cache_index_width-1;
        variable buff_lineset : cache_data_type;
        variable buff_line : cache_line_type;
        variable write_lineset : cache_data_type;
        variable write_line : cache_line_type;
    begin
        if rising_edge(clock) then
             address := to_integer(unsigned(cache_in_index));
             buff_lineset := cache_buffer(address);
             write_lineset := cache_in_data;
             for each_way in 0 to 2**cache_way_width-1 loop
                buff_line := buff_lineset((each_way+1)*cache_line_width-1 downto each_way*cache_line_width);
                write_line := write_lineset((each_way+1)*cache_line_width-1 downto each_way*cache_line_width);
                if cache_in_tag_enable(each_way)='1' then
                    buff_line(cache_line_width-1 downto cache_line_width-cache_tag_width) :=
                        write_line(cache_line_width-1 downto cache_line_width-cache_tag_width);
                end if;
                for each_word in 0 to 2**cache_word_offset_width-1 loop
                    if cache_in_offset_enable(each_way*2**cache_word_offset_width+each_word)='1' then
                        buff_line((each_word+1)*glb_data_width-1 downto each_word*glb_data_width) := 
                            write_line((each_word+1)*glb_data_width-1 downto each_word*glb_data_width);
                    end if;
                end loop;
                buff_lineset((each_way+1)*cache_line_width-1 downto each_way*cache_line_width) := buff_line;
             end loop;
             cache_buffer(address) <= buff_lineset;
        end if;
    end process;

end Behavioral;
