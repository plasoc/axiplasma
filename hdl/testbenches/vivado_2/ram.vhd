
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use work.mlitesoc_pack.all;

entity ram is
    port(
        bram_rst_a : in STD_LOGIC;
        bram_clk_a : in STD_LOGIC;
        bram_en_a : in STD_LOGIC;
        bram_we_a : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        bram_addr_a : in STD_LOGIC_VECTOR(15 DOWNTO 0);
        bram_wrdata_a : in STD_LOGIC_VECTOR(31 DOWNTO 0);
        bram_rddata_a : out STD_LOGIC_VECTOR(31 DOWNTO 0));
end ram;

architecture Behavioral of ram is
    constant binary_name : string := "main.bin";
    constant cpu_width : integer := 32;
    constant bytes_per_word : integer := (cpu_width/8);
    constant ram_address_width : integer := 16;
    constant ram_size : integer := 2**ram_address_width/bytes_per_word;
    constant cache_address_0 : integer := to_integer(unsigned(default_cache_base_address))/bytes_per_word;
    constant cache_address_1 : integer := cache_address_0+1;
    subtype word_type is std_logic_vector(cpu_width-1 downto 0);
    type ram_type is array(0 to ram_size-1) of word_type;
    function load_binary return ram_type is
        type file_char is file of character;
        file load_file : file_char open read_mode is binary_name;
        variable index : integer := 0;
        variable char_buff : character;
        variable word_buff : word_type; 
        variable byte_buff : std_logic_vector(7 downto 0);
        variable word : word_type;
        variable ram_buffer : ram_type;
    begin
        while not endfile(load_file) and index<ram_size loop
            for each_byte in 0 to bytes_per_word-1 loop
                read(load_file,char_buff);
                byte_buff := std_logic_vector(to_unsigned(character'pos(char_buff),8));
                for each_bit in byte_buff'low to byte_buff'high loop
                    word(each_bit+(bytes_per_word-1-each_byte)*8) 
                    := byte_buff(each_bit);
                end loop;
            end loop;
            ram_buffer(index) := word;
            index := index+1;
        end loop;
        return ram_buffer;
    end;
    signal ram_buffer : ram_type := load_binary;
begin
    -- Drive ram interface for axiplasma. The ram is implemented with a combination of the Xilinx
    -- axi bram controller and an array into which the binary is uplosed.
    process (bram_clk_a) 
        variable base_index : integer;
    begin
        -- Perform operation on rising clock edge.
        if rising_edge(bram_clk_a) then
            -- Drive interface to axi bram controller.
            if bram_rst_a='0' then
                -- Check to see if bram is enabled.
                if bram_en_a='1' then
                    -- Acquire index into array. Every memory access should be aligned,
                    -- so this shouldn't cause any problems.
                    base_index := to_integer(unsigned(bram_addr_a))/bytes_per_word;
                    -- Make sure cache addresses are ignored.
                    if base_index/=cache_address_0 and base_index/=cache_address_1 then
                        -- Write data according to which bytes are enabled.
                        for each_byte in 0 to bytes_per_word-1 loop
                            if bram_we_a(each_byte)='1' then
                                ram_buffer(base_index)(each_byte*8+7 downto each_byte*8) <= 
                                    bram_wrdata_a(each_byte*8+7 downto each_byte*8);
                            end if;
                        end loop;
                        -- Write word to BRAM read interface, as well.
                        bram_rddata_a <= ram_buffer(base_index);
                    else
                        -- Default value of bram read interface.
                        bram_rddata_a <= (others=>'0');
                    end if;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
