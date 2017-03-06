
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.bram_pack.all;

entity ram is
    port(
        bram_rst_a : in STD_LOGIC;
        bram_clk_a : in STD_LOGIC;
        bram_en_a : in STD_LOGIC;
        bram_we_a : in STD_LOGIC_VECTOR(3 DOWNTO 0);
        bram_addr_a : in STD_LOGIC_VECTOR(15 DOWNTO 0);
        bram_wrdata_a : in STD_LOGIC_VECTOR(31 DOWNTO 0);
        bram_rddata_a : out STD_LOGIC_VECTOR(31 DOWNTO 0) := (others=>'0'));
end ram;

architecture Behavioral of ram is
    constant cpu_width : integer := 32;
    constant bytes_per_word : integer := (cpu_width/8);
    signal base_index : integer;
    signal ram_buffer : ram_type := load_hex;
begin

    base_index <= to_integer(unsigned(bram_addr_a))/bytes_per_word;
    process (bram_clk_a) 
    begin
        if rising_edge(bram_clk_a) then
            if bram_rst_a='0' then
                if bram_en_a='1' then
                    for each_byte in 0 to bytes_per_word-1 loop
                        if bram_we_a(each_byte)='1' then
                            ram_buffer(base_index)(each_byte*8+7 downto each_byte*8) <= 
                                bram_wrdata_a(each_byte*8+7 downto each_byte*8);
                        end if;
                    end loop;
                    bram_rddata_a <= ram_buffer(base_index);
                end if;
            end if;
        end if;
    end process;

end Behavioral;
