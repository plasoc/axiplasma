
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.ram_pack.all;

entity empty_ram is
    generic (
        load_flag : Boolean := False;
        address_width : integer := 18;
        data_width : integer := 32;
        bram_depth : integer := 65536);
    port(
        bram_rst_a : in STD_LOGIC;
        bram_clk_a : in STD_LOGIC;
        bram_en_a : in STD_LOGIC;
        bram_we_a : in STD_LOGIC_VECTOR(data_width/8-1 DOWNTO 0);
        bram_addr_a : in STD_LOGIC_VECTOR(address_width-1 DOWNTO 0);
        bram_wrdata_a : in STD_LOGIC_VECTOR(data_width-1 DOWNTO 0);
        bram_rddata_a : out STD_LOGIC_VECTOR(data_width-1 DOWNTO 0) := (others=>'0'));
end empty_ram;

architecture Behavioral of empty_ram is
    constant bytes_per_word : integer := data_width/8;
    type empty_bram_buff_type is array (0 to bram_depth-1) of std_logic_vector(data_width-1 downto 0);
    
    function select_hex return empty_bram_buff_type is
        variable bram_buff : empty_bram_buff_type := (others=>(others=>'0'));
        variable code_type : ram_type := load_hex;
    begin
        if not load_flag then
            return bram_buff;
        else
            for each_word in 0 to ram_size-1 loop
                bram_buff(each_word) := code_type(each_word);
            end loop;
            return bram_buff;
        end if;
    end;
    
    signal bram_buff : empty_bram_buff_type := select_hex;
begin

    process (bram_clk_a)
        variable base_index : integer; 
    begin
        if rising_edge(bram_clk_a) then
            if bram_rst_a='0' then
                if bram_en_a='1' then
                    base_index := to_integer(unsigned(bram_addr_a))/bytes_per_word;
                    for each_byte in 0 to bytes_per_word-1 loop
                        if bram_we_a(each_byte)='1' then
                            bram_buff(base_index)(each_byte*8+7 downto each_byte*8) <= 
                                bram_wrdata_a(each_byte*8+7 downto each_byte*8);
                        end if;
                    end loop;
                    bram_rddata_a <= bram_buff(base_index);
                end if;
            end if;
        end if;
    end process;

end Behavioral;
