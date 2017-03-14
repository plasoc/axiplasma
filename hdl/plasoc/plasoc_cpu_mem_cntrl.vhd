-------------------------------------------------------
--! @author Andrew Powell
--! @date January 17, 2017
--! @brief Contains the entity and architecture of the 
--! CPU's Noncacheable Memory Controller.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use work.plasoc_cpu_pack.all;

--! The Noncacheable Memory Controller is an alternative to the
--! Cache Controller. As its name suggests, the Noncacheable Memory
--! Controller should be instantiated if the entire address space
--! needs to be noncacheable.
entity plasoc_cpu_mem_cntrl is
    generic (
        -- CPU parameters.
        cpu_address_width : integer := 16;	--! Defines the address width of the CPU. This should normally be equal to the CPU's width.			
        cpu_data_width : integer := 32		--! Defines the data width of the CPU. This should normally be equal to the CPU's width.
	);
    port (
        -- Global interface.
        clock : in std_logic; 				--! Clock. Tested with 50 MHz.
        resetn : in std_logic;				--! Reset on low.	
        -- CPU interface.
        cpu_address : in std_logic_vector(cpu_address_width-1 downto 0); 						--! The requested address of the next word to either be written to or read from memory.
        cpu_in_data : in std_logic_vector(cpu_data_width-1 downto 0);							--! The word that the CPU is writing.
        cpu_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');		--! The word that is written to the CPU.
        cpu_strobe : in std_logic_vector(cpu_data_width/8-1 downto 0);							--! Determines whether a the CPU is writing or reading a word. Each bit that is high enables writing for the corresponding byte in cpu_out_data.
        cpu_pause : out std_logic;																--! Stalls the CPU.
        -- Cache interface.
        cache_cacheable : out std_logic;														--! Indicates whether the requested address of the CPU is cacheable or noncacheable. Should always be noncacheable.
        -- Memory interface.
        mem_in_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');	--! The requested address sent to the read memory controller.
        mem_in_data : in std_logic_vector(cpu_data_width-1 downto 0);							--! The word read from the read memory controller.
        mem_in_enable : out std_logic;															--! Enables the operation of the read memory controller.	
        mem_in_valid : in std_logic;															--! Indicates the read memory controller has a valid word on mem_in_data.
        mem_in_ready : out std_logic;															--! Indicates the cache is ready to sample a word from mem_in_data.	
        mem_out_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');	--! The requested address sent to the write memory controller.
        mem_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');		--! The word written to the write memory controller.
        mem_out_strobe : out std_logic_vector(cpu_data_width/8-1 downto 0) := (others=>'0');	--! Each bit that is high enables writing for the corresponding byte in mem_out_data.
        mem_out_enable : out std_logic := '0';													--! Enables the operation of the write memory controller.
        mem_out_valid : out std_logic;															--! Indicates the cache has a valid word on mem_out_data.
        mem_out_ready : in std_logic															--! Indicates the read memory controller is ready to sample a word from mem_out_data.	
	);
end plasoc_cpu_mem_cntrl;

architecture Behavioral of plasoc_cpu_mem_cntrl is
    subtype address_type is std_logic_vector(cpu_address_width-1 downto 0);
    subtype strobe_type is std_logic_vector(cpu_data_width/8-1 downto 0);
    subtype flag_type is std_logic;
    signal cpu_pause_enable : boolean := False;
    signal cpu_write_access : boolean;
    signal mem_in_ready_buff : std_logic := '0';
    signal mem_out_valid_buff : std_logic := '0';
begin

    cache_cacheable <= '0';
    cpu_pause <= '1' when cpu_pause_enable else '0';
    cpu_write_access <= True when or_reduce(cpu_strobe)/='0' else False;
    mem_in_ready <= mem_in_ready_buff;
    mem_out_valid <= mem_out_valid_buff;

    process (clock)
        variable write_occurred : boolean;
        variable read_occurred : boolean;
        procedure reset_state is
        begin
            mem_in_ready_buff <= '0';
            mem_out_valid_buff <= '0';
            mem_out_enable <= '0';
            mem_in_enable <= '0';
            cpu_pause_enable <= False;
        end procedure;
    begin
        if rising_edge(clock) then
            if resetn='0' then
                reset_state;
            else
                if not cpu_pause_enable then
                    cpu_pause_enable <= True;
                    if cpu_write_access then
                        mem_out_address <= cpu_address;
                        mem_out_strobe <= cpu_strobe;
                        mem_out_enable <= '1';
                        mem_out_valid_buff <= '1';
                        mem_out_data <= cpu_in_data;
                    else
                        mem_in_address <= cpu_address;
                        mem_in_enable <= '1';
                        mem_in_ready_buff <= '1';
                    end if;
                else
                    write_occurred := mem_out_valid_buff='1' and mem_out_ready='1';
                    read_occurred := mem_in_valid='1' and mem_in_ready_buff='1';
                    if not cpu_write_access and read_occurred then
                        cpu_out_data <= mem_in_data;
                    end if;
                    if write_occurred or read_occurred then
                        reset_state;
                    end if;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
