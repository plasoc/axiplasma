-------------------------------------------------------
--! @author Andrew Powell
--! @date January 17, 2017
--! @brief Contains the entity and architecture of the 
--! CPU's Cache Buffer.
-------------------------------------------------------

library ieee;
use work.plasoc_pack.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--! The cache buffer is implemented separately from the
--! cache controller in order to ensure that the synthesizer
--! infers BRAM. 
--!
--! Most likely due to the complexity of the enables
--! needed for the writing new tags and words, the synthesizer 
--! (for at least Xilinx Vivado 2016.2) implements the cache buffer
--! as distributed RAM. Investigation in the future will be done to
--! see if there any advantages or disadvantages. 
entity plasoc_cpu_l1_cache_buff is
    generic (
        -- Global parameters.
        glb_data_width : integer := 32;			--! Defines the data width of the CPU. This should normally be equal to the CPU's width.	
        -- Cache parameters.
        cache_tag_width : integer := 22;		--! CPU (address) width = cache_tag_width+cache_index_width+cache_offset_width.
        cache_index_width : integer := 5;		--! Cache Size (rows) = 2^cache_index_width.
        cache_offset_width : integer := 4;		--! Line Size (bytes) = 2^cache_offset_width.
        cache_way_width : integer := 2 			--! Associativity = 2^cache_way_width.
	);
    port(
        -- Global interface.
        clock : in std_logic;					--! Clock. Tested with 50 MHz.
        -- Cache controller interface.
        cache_in_data : in std_logic_vector((cache_tag_width+8*2**cache_offset_width)*2**cache_way_width-1 downto 0); --! The cache data when the cache controller is writing to the cache buffer.
        cache_in_index : in std_logic_vector(cache_index_width-1 downto 0); --! The requested cache index when the cache controller is writing to the cache buffer. 
        cache_in_tag_enable : in std_logic_vector(2**cache_way_width-1 downto 0); --! Enables the writing of a new tag for a specified way. Each bit refers to a corresponding way.
        cache_in_offset_enable : in std_logic_vector(2**cache_way_width*2**cache_offset_width/(glb_data_width/8)-1 downto 0); --! Enables the writing of a word for a specifided way and offset. Each bit refers a corresponding way and offset.
        cache_out_data : out std_logic_vector((cache_tag_width+8*2**cache_offset_width)*2**cache_way_width-1 downto 0); --! The cache data when the cache controller is reading from the cache buffer.
        cache_out_index : in std_logic_vector(cache_index_width-1 downto 0)); --! The requested cache index when reading from the cache buffer. 
end entity plasoc_cpu_l1_cache_buff;

architecture Behavioral of plasoc_cpu_l1_cache_buff is
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
