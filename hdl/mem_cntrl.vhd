library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use work.mlitesoc_pack.all;

entity mem_cntrl is
    generic (
        -- cpu constants
        cpu_address_width : integer := 16;
        cpu_data_width : integer := 32);
    port (
        -- global interface.
        clock : in std_logic; 
        resetn : in std_logic;
        -- cpu interface.
        cpu_address : in std_logic_vector(cpu_address_width-1 downto 0); 
        cpu_in_data : in std_logic_vector(cpu_data_width-1 downto 0);
        cpu_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
        cpu_strobe : in std_logic_vector(cpu_data_width/8-1 downto 0);
        cpu_pause : out std_logic;
        -- simple mem interface
        mem_in_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
        mem_in_data : in std_logic_vector(cpu_data_width-1 downto 0);
        mem_in_enable : out std_logic;
        mem_in_valid : in std_logic;
        mem_in_ready : out std_logic;
        mem_out_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
        mem_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
        mem_out_strobe : out std_logic_vector(cpu_data_width/8-1 downto 0) := (others=>'0');
        mem_out_enable : out std_logic := '0';
        mem_out_valid : out std_logic;
        mem_out_ready : in std_logic);
end mem_cntrl;

architecture Behavioral of mem_cntrl is
    subtype address_type is std_logic_vector(cpu_address_width-1 downto 0);
    subtype strobe_type is std_logic_vector(cpu_data_width/8-1 downto 0);
    subtype flag_type is std_logic;
    signal cpu_pause_enable : boolean := False;
    signal cpu_write_access : boolean;
    signal mem_in_ready_buff : std_logic := '0';
    signal mem_out_valid_buff : std_logic := '0';
begin

    cpu_pause <= '1' when cpu_pause_enable else '0';
    cpu_write_access <= True when or_reduce(cpu_strobe)/='0' else False;
    mem_in_ready <= mem_in_ready_buff;
    mem_out_valid <= mem_out_valid_buff;

    process (clock)
        variable write_occurred : boolean;
        variable read_occurred : boolean;
        procedure reset_state is
        begin
            -- Clear handshake control signals.
            mem_in_ready_buff <= '0';
            mem_out_valid_buff <= '0';
            -- Clear memory enables.
            mem_out_enable <= '0';
            mem_in_enable <= '0';
            -- Resume CPU.
            cpu_pause_enable <= False;
        end procedure;
    begin
        if rising_edge(clock) then
            if resetn='0' then
                reset_state;
            else
                -- Acquire memory access request from CPU.
                if not cpu_pause_enable then
                    -- Make sure the CPU is stalled.
                    cpu_pause_enable <= True;
                    -- Check to see what the operation is.
                    if cpu_write_access then
                        -- Set write control information.
                        mem_out_address <= cpu_address;
                        mem_out_strobe <= cpu_strobe;
                        mem_out_enable <= '1';
                        mem_out_valid_buff <= '1';
                        -- Set write data.
                        mem_out_data <= cpu_in_data;
                    else
                        -- Set read control information.
                        mem_in_address <= cpu_address;
                        mem_in_enable <= '1';
                        mem_in_ready_buff <= '1';
                    end if;
                -- Perform memory access.
                else
                    -- Check and see if handshakes occurred.
                    write_occurred := mem_out_valid_buff='1' and mem_out_ready='1';
                    read_occurred := mem_in_valid='1' and mem_in_ready_buff='1';
                    -- Perform read operation on handshake.
                    if not cpu_write_access and read_occurred then
                        cpu_out_data <= mem_in_data;
                    end if;
                    -- Once handshake completes, resume the CPU.
                    if write_occurred or read_occurred then
                        reset_state;
                    end if;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
