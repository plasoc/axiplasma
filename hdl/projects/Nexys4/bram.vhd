library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.main_pack.all;
use work.jump_pack.all;
use work.boot_pack.all;


entity bram is
    generic (
        select_app : string := "none"; -- jump, boot, main
        address_width : integer := 18;
        data_width : integer := 32;
        bram_depth : integer := 65536);
    port(
        bram_rst_a : in std_logic;
        bram_clk_a : in std_logic;
        bram_en_a : in std_logic;
        bram_we_a : in std_logic_vector(data_width/8-1 downto 0);
        bram_addr_a : in std_logic_vector(address_width-1 downto 0);
        bram_wrdata_a : in std_logic_vector(data_width-1 downto 0);
        bram_rddata_a : out std_logic_vector(data_width-1 downto 0) := (others=>'0'));
end bram;

architecture Behavioral of bram is
    constant bytes_per_word : integer := data_width/8;
    type bram_buff_type is array (0 to bram_depth-1) of std_logic_vector(data_width-1 downto 0);
    
    function load_selected_app return bram_buff_type is
        variable bram_buff : bram_buff_type := (others=>(others=>'0'));
        variable boot_buff : work.boot_pack.ram_type;
        variable jump_buff : work.jump_pack.ram_type;
        variable main_buff : work.main_pack.ram_type;
    begin
        case select_app is
            when "none"=>
            when "main"=>
                main_buff := work.main_pack.load_hex;
                for each_word in 0 to work.main_pack.ram_size-1 loop
                    bram_buff(each_word) := main_buff(each_word);
                end loop;
            when "jump"=>
                jump_buff := work.jump_pack.load_hex;
                for each_word in 0 to work.jump_pack.ram_size-1 loop
                    bram_buff(each_word) := jump_buff(each_word);
                end loop;
            when "boot"=>
                boot_buff := work.boot_pack.load_hex;
                for each_word in 0 to work.boot_pack.ram_size-1 loop
                    bram_buff(each_word) := boot_buff(each_word);
                end loop;
            when others=>
                assert false report "Incorrect option for select_app" severity error;
        end case;
        return bram_buff;
    end;
    
    signal bram_buff : bram_buff_type := load_selected_app;
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
