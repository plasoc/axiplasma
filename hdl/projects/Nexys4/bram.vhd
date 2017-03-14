-------------------------------------------------------
--! @author Andrew Powell
--! @date March 14, 2017
--! @brief Contains the entity and architecture of the 
--! Single Port Block RAM needed to load either the boot
--! loader, jumper loader, or the main application.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.main_pack.all;
use work.jump_pack.all;
use work.boot_pack.all;

--! The Single Port BRAM is effectively defined as an array the 
--! compiler can infer as Block RAM. This methodology is useful for verification
--! purposes since the contents of the array can be observed while in simulation.
--! Moreover, binary can be loaded into the BRAM during static elaboration prior
--! to synthesis, allowing the BRAM to be initialized with a bootloader application
--! for hardware deployment.
--!
--! One out of three types of binary can be statically loaded into the BRAM. The first
--! of which is the Jump binary, whose purpose is to make the Plasma-SoC's CPU jump
--! to a particular place in memory. The Jump binary was made so that the Bootloader
--! binary can be bypassed in simulation, allowing the Main binary to begin its execution
--! faster. The second binary is the Bootloader. The purpose of the Bootloader is to load
--! the Main application into memory and then cause the CPU to jump to the starting address
--! of the Main application. Finally, the Main binary is the application under test. Unlike
--! the Jump and Boot binaries, the Main binary can be located at an address other than 0 if
--! compiled and linked correctly. The Jump and Bootloader binaries need to be built such that
--! they are aware where the Main binary is located and needs to go, respectively.
--!
--! Alternatively, the BRAM can be initialized to zero; in other words, without any binary.
--!
--! It is recommended to read over the documentation presented in the corresponding C sources 
--! to learn more about these applications.
entity bram is
    generic (
        select_app : string := "none";    --! Selects the binary to statically load. "none" refers to no binary. "jump" refers to the Jump binary. "boot" refers to the Bootloader binary. "main" refers to the Main application.
        address_width : integer := 18;    --! Defines the address width.
        data_width : integer := 32;       --! Defines the data width.
        bram_depth : integer := 65536     --! Defines the size of the BRAM in the number of words.
    );
    port(
        bram_rst_a : in std_logic;                                                     --! High reset. Since the binary is loaded statically, this reset effectively behaves like another bram_en_a.
        bram_clk_a : in std_logic;                                                     --! Clock that synchronizes the BRAM's operation.
        bram_en_a : in std_logic;                                                      --! Enables the BRAM when high.
        bram_we_a : in std_logic_vector(data_width/8-1 downto 0);                      --! Each high bit allows the respective byte in bram_wrdata_a to be written into the BRAM.
        bram_addr_a : in std_logic_vector(address_width-1 downto 0);                   --! Specifies the BRAM's location where the memory access operation will occur on the next positive edge clock cycle. Should be a multiple of (2**address_width)/(data_width/8) and less than bram_depth*(data_width/8).
        bram_wrdata_a : in std_logic_vector(data_width-1 downto 0);                    --! The data that will be written on the next positive edge clock cycle provided that bram_rst_a is low, bram_en_a is high, and at least one bit in bram_we_a is high.
        bram_rddata_a : out std_logic_vector(data_width-1 downto 0) := (others=>'0')   --! The data that will be read on the next positive edge clock cycle provided that bram_rst_a is low and bram_en_a is high.
    );
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
