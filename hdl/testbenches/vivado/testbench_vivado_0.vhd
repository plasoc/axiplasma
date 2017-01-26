library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use work.mlite_pack.all;
use work.mlitesoc_pack.all;

entity testbench_vivado_0 is
    generic (indelay : time := 0 ns);
end testbench_vivado_0;

architecture Behavioral of testbench_vivado_0 is
    component axiplasma_wrapper is
        port(
            aclk : in std_logic;
            aresetn     : in std_logic;
            bram_rst_a : OUT STD_LOGIC;
            bram_clk_a : OUT STD_LOGIC;
            bram_en_a : OUT STD_LOGIC;
            bram_we_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            bram_addr_a : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            bram_wrdata_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            bram_rddata_a : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            debug_cpu_pause : out std_logic);
    end component;
    constant binary_name : string := "main.bin";
    constant cpu_width : integer := 32;
    constant bytes_per_word : integer := (cpu_width/8);
    constant ram_address_width : integer := 16;
    constant ram_size : integer := 2**ram_address_width/bytes_per_word;
    subtype word_type is std_logic_vector(cpu_width-1 downto 0);
    type ram_type is array(0 to ram_size-1) of word_type;
    -- Signal declarations.
    signal aclk : std_logic;
    signal aresetn : std_logic;
    signal debug_cpu_pause : std_logic;
    signal bram_rst_a : STD_LOGIC;
    signal bram_clk_a : STD_LOGIC;
    signal bram_en_a : STD_LOGIC;
    signal bram_we_a : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal bram_addr_a : STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal bram_wrdata_a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal bram_rddata_a : STD_LOGIC_VECTOR(31 DOWNTO 0);
    signal mlite_address_next : std_logic_vector(31 downto 0);
    signal mlite_strobe_next : std_logic_vector(3 downto 0);
    signal mlite_data_w : std_logic_vector(31 downto 0);
    signal mlite_data_r: std_logic_vector(31 downto 0);
    signal mlite_ram_buffer : ram_type;
    signal axiplasma_ram_buffer : ram_type;
    -- function declarations.
    function load_binary ( binary_name : in string ) return ram_type is
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
begin
    -- axiplasma/axibram instantiation.
    axiplasma_wrapper_inst : 
    axiplasma_wrapper 
        port map(
            aclk => aclk,
            aresetn => aresetn,
            bram_rst_a => bram_rst_a,
            bram_clk_a => bram_clk_a,
            bram_en_a => bram_en_a,
            bram_we_a => bram_we_a,
            bram_addr_a => bram_addr_a,
            bram_wrdata_a => bram_wrdata_a,
            bram_rddata_a => bram_rddata_a,
            debug_cpu_pause => debug_cpu_pause);
    -- Mlite instantiation.
    mlite_cpu_inst:  
    mlite_cpu 
        generic map (
            memory_type => "DUAL_PORT_",
            mult_type => default_cpu_mult_type,
            shifter_type => default_cpu_shifter_type,
            alu_type => default_cpu_alu_type,
            pipeline_stages => 3 )
        port map (
            clk => aclk,
            reset_in => "not" (aresetn),
            intr_in => '0',
            address_next => mlite_address_next(31 downto 2),
            byte_we_next => mlite_strobe_next,
            address => open,
            byte_we => open,
            data_w => mlite_data_w,
            data_r => mlite_data_r,
            mem_pause => debug_cpu_pause );
    -- Drive ram interface for axiplasma. The ram is implemented with a combination of the Xilinx
    -- axi bram controller and an array into which the binary is uplosed.
    bram_rddata_a <= axiplasma_ram_buffer(to_integer(unsigned(bram_addr_a))/bytes_per_word) after indelay;
    process (bram_clk_a) 
        variable base_index : integer;
        variable ram_loaded : boolean := False;
    begin
        -- Perform operation on rising clock edge.
        if rising_edge(bram_clk_a) then
            -- Load image on reset.
            if bram_rst_a='1' then
                -- Image only needs to be loaded once.
                if not ram_loaded then
                    axiplasma_ram_buffer <= load_binary(binary_name);
                    ram_loaded := True;
                end if;
            -- Drive interface to axi bram controller.
            else
                -- If the ram ever goes back to reset, the binary should be loaded again.
                ram_loaded := False;
                -- Check to see if bram is enabled.
                if bram_en_a='1' then
                    -- Acquire index into array. Every memory access should be aligned,
                    -- so this shouldn't cause any problems.
                    base_index := to_integer(unsigned(bram_addr_a))/bytes_per_word;
                    -- Write data according to which bytes are enabled.
                    for each_byte in bram_we_a'low to bram_we_a'high loop
                        if bram_we_a(each_byte)='1' then
                            axiplasma_ram_buffer(base_index)(each_byte*8+7 downto each_byte*8) <= 
                                bram_wrdata_a(each_byte*8+7 downto each_byte*8);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;
    -- Driver ram interface for mlite, the original CPU.
    mlite_address_next(1 downto 0) <= "00";
    mlite_data_r <= axiplasma_ram_buffer(to_integer(unsigned(mlite_address_next))/bytes_per_word);
    process (aclk)
        variable base_index : integer;
        variable ram_loaded : boolean := False;
    begin
        -- Perform operation on rising clock edge.
        if rising_edge(aclk) then
            -- Load image on reset.
            if aresetn='0' then
                -- Image only needs to be loaded once.
                if not ram_loaded then
                    mlite_ram_buffer <= load_binary(binary_name);
                    ram_loaded := True;
                end if;
            -- Drive interface to mlite.
            else
                -- If the ram ever goes back to reset, the binary should be loaded again.
                ram_loaded := False;
                -- Acquire index into array. Every memory access should be aligned,
                -- so this shouldn't cause any problems.
                base_index := to_integer(unsigned(mlite_address_next))/bytes_per_word;
                -- Write data according to which bytes are enabled.
                for each_byte in bram_we_a'low to bram_we_a'high loop
                    if mlite_strobe_next(each_byte)='1' then
                        mlite_ram_buffer(base_index)(each_byte*8+7 downto each_byte*8) <= 
                            mlite_data_w(each_byte*8+7 downto each_byte*8);
                    end if;
                end loop;
            end if;
        end if;
    end process;
    -- Drive clock and reset.
    aclk <= not aclk after 50 ns;
    aresetn <= '1' after 500ns + indelay;
end Behavioral;
