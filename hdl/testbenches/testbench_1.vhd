---------------------------------------------------------------------
-- TITLE: Testbench 1 
-- AUTHOR: Andrew Powell (andrewandrepowell2@gmail.com)
-- DATE CREATED: 1/23/2017
-- FILENAME: mlitesoc_pack.vhd
-- PROJECT: Plasma-SoC core (extension of the Plasma CPU project)
-- COPYRIGHT: Software placed into the public domain by the author.
--    Software 'as is' without warranty.  Author liable for nothing.
-- DESCRIPTION:
--    Runs a testbench to verify the Plasma-SoC Baseline Processor 
--    with Mem Interface.
---------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use work.mlite_pack.all;
use work.mlitesoc_pack.all;

entity testbench_1 is
end testbench_1;

architecture Behavioral of testbench_1 is
    component memplasma is
        port(
            aclk : in std_logic;
            aresetn     : in std_logic;
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
            intr_in      : in std_logic;
            debug_cpu_pause : out std_logic );
    end component;
    constant binary_name : string := "main.bin";
    constant cpu_width : integer := 32;
    constant bytes_per_word : integer := (cpu_width/8);
    constant ram_address_width : integer := 16;
    constant ram_size : integer := 2**ram_address_width/bytes_per_word;
    subtype word_type is std_logic_vector(cpu_width-1 downto 0);
    type ram_type is array(0 to ram_size-1) of word_type;
    signal clock : std_logic := '1';
    signal resetn : std_logic := '0';
    signal debug_cpu_pause : std_logic;
    signal mem_in_address : word_type;
    signal mem_in_data : word_type := (others=>'0');
    signal mem_in_enable : std_logic;
    signal mem_in_valid : std_logic := '0';
    signal mem_in_ready : std_logic;
    signal mem_out_address : word_type;
    signal mem_out_data : word_type;
    signal mem_out_strobe : std_logic_vector(3 downto 0);
    signal mem_out_enable : std_logic;
    signal mem_out_valid : std_logic;
    signal mem_out_ready : std_logic := '0';
    signal ram_buffer : ram_type;
    signal cpu0_address_next : std_logic_vector(31 downto 2);
    signal cpu0_strobe_next : std_logic_vector(3 downto 0);
    signal cpu0_data_write : word_type;
    signal cpu0_data_read : word_type;
    signal cpu0_pause : std_logic;
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
    clock <= not clock after 50 ns;
    resetn <= '1' after 500 ns;
    cpu0_pause <= debug_cpu_pause;
    
    -- CPU
    memplasma_inst : memplasma 
        port map(
            aclk => clock,
            aresetn => resetn,
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
            mem_out_ready => mem_out_ready,
            intr_in => '0',
            debug_cpu_pause => debug_cpu_pause );
    
    -- CPU0
    mlite_cpu_inst:  mlite_cpu 
        generic map (
            memory_type => "DUAL_PORT_",
            mult_type => default_cpu_mult_type,
            shifter_type => default_cpu_shifter_type,
            alu_type => default_cpu_alu_type,
            pipeline_stages => 3 )
        port map (
            clk => clock,
            reset_in => "not" (resetn),
            intr_in => '0',
            address_next => cpu0_address_next,
            byte_we_next => cpu0_strobe_next,
            address => open,
            byte_we => open,
            data_w => cpu0_data_write,
            data_r => cpu0_data_read,
            mem_pause => cpu0_pause );
    
    -- Drive read memory interface
    process (clock)
        -- Variables for reading operation.
        variable counter : integer range 0 to 2**default_cache_offset_width-1 := 0;
        variable base_index : integer range 0 to 2**ram_size-1;
        variable base_loaded : boolean := False;
    begin
        -- Perform operation on rising edge.
        if rising_edge(clock) then
            -- Check to see if the reading interface is enabled.
            if mem_in_enable='1' then
                -- Perform read operation from memory when the base address is acquired.
                if base_loaded then
                    -- Upon handshake, immediately load more data to be read.
                    -- The counter is incremented to point to the next address.
                    if mem_in_valid='1' and mem_in_ready='1' then
                        mem_in_data <= ram_buffer(base_index+counter);
                        counter := counter+1;
                    end if;
                    -- The reading interface always has valid data.
                    mem_in_valid <= '1';
                -- Acquire base address, load first word, and reset counter if block is needed.
                else
                    base_index := to_integer(unsigned(mem_in_address))/bytes_per_word;
                    base_loaded := True;
                    mem_in_data <= ram_buffer(base_index);
                    counter := 1;
                end if;
            -- If writing interface is disabled, ensure control signals are left in reset.
            else
                mem_in_valid <= '0';
                base_loaded := False;
            end if;
        end if;     
    end process;
    
    -- Drive write memory interface
    process (clock)
        -- Cache addresses to ignore.
        constant cache_address_0 : integer := to_integer(unsigned(default_cache_base_address))/bytes_per_word;
        constant cache_address_1 : integer := cache_address_0+1;
        -- Variables for loading operation.
        variable ram_loaded : boolean := False;
        -- Variables for writing operation.
        variable counter : integer range 0 to 2**default_cache_offset_width-1 := 0;
        variable base_index : integer;
        variable base_loaded : boolean := False;
    begin
        --Load in the ram executable image
        if not ram_loaded then
            ram_loaded := True;
            ram_buffer <= load_binary(binary_name);
        end if;
        -- Perform operation on rising edge.
        if rising_edge(clock) then
            -- Check to see if the writing interface is enabled.
            if mem_out_enable='1' then
                -- Perform write operation into memory when the base address is acquired.
                if base_loaded then
                    -- Upon handshake, sample data into main memory.
                    if mem_out_valid='1' and mem_out_ready='1' then
                        -- In case cache is disabled, only sample data if the base address
                        -- doesn't refer to the cache.
                        if base_index/=cache_address_0 and base_index/=cache_address_1 then
                            -- Sample data according to which bytes are enabled.
                            for each_byte in 0 to cpu_width/8-1 loop
                                if mem_out_strobe(each_byte)='1' then
                                    ram_buffer(base_index+counter)(7+each_byte*8 downto each_byte*8) <= 
                                        mem_out_data(7+each_byte*8 downto each_byte*8);
                                end if;
                            end loop;
                        end if;
                        -- Increment counter to point to the next address.
                        counter := counter+1;
                    end if;
                    -- The writing interface is always ready.
                    mem_out_ready <= '1';
                -- Acquire base address and reset counter if block is needed.
                else
                    base_index := to_integer(unsigned(mem_out_address))/bytes_per_word;
                    base_loaded := True;
                    counter := 0;
                end if;
            -- If writing interface is disabled, ensure control signals are left in reset.
            else
                mem_out_ready <= '0';
                base_loaded := False;
            end if;
        end if;
    end process;
    
    -- Drive memory for CPU0
    ram_proc: 
    process(clock) 
        -- Variables for loading operation.
        variable ram_loaded : boolean := False;
        -- Variables for driving CPU memory access port.
        variable index : natural := 0;
        variable data : word_type; 
        variable mem_size : natural := 2 ** ram_address_width;
        variable storage : ram_type := ((others=> (others=>'0')));
    begin
        --Load in the ram executable image
        if ram_loaded = False then
            ram_loaded := True;
            storage := load_binary(binary_name);
        end if;
        -- Drive RAM
        if rising_edge(clock) then
            if resetn='1' then
                index := conv_integer(cpu0_address_next(ram_address_width-1 downto 2));
                data := storage(index);
                if cpu0_strobe_next(0) = '1' then
                    data(7 downto 0) := cpu0_data_write(7 downto 0);
                end if;
                if cpu0_strobe_next(1) = '1' then
                    data(15 downto 8) := cpu0_data_write(15 downto 8);
                end if;
                if cpu0_strobe_next(2) = '1' then
                    data(23 downto 16) := cpu0_data_write(23 downto 16);
                end if;
                if cpu0_strobe_next(3) = '1' then
                    data(31 downto 24) := cpu0_data_write(31 downto 24);
                end if;
                if cpu0_strobe_next /= "0000" then
                    storage(index) := data;
                end if;
            end if;
        end if;
        cpu0_data_read <= data;
    end process;
    
end Behavioral;
