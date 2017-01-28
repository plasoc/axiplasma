library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use work.mlitesoc_pack.all;

entity plasoc_int_cntrl is
    generic (
        interrupt_total : integer := 8 );
    port (
        -- global interface.
        clock : in std_logic;
        nreset : in std_logic;
        -- cpu interface.
        cpu_int : out std_logic := '0';
        cpu_int_id : out std_logic_vector(clogb2(interrupt_total)-1 downto 0) := (others=>'0');
        cpu_int_enables : in std_logic_vector(interrupt_total-1 downto 0);
        -- device interface.
        dev_ints : in std_logic_vector(interrupt_total-1 downto 0));
end plasoc_int_cntrl;

architecture Behavioral of plasoc_int_cntrl is
    signal dev_enabled_ints : std_logic_vector(interrupt_total-1 downto 0);
    signal dev_triggered_int : std_logic_vector(clogb2(interrupt_total)-1 downto 0);
    signal dev_int_occurred : boolean;
begin
    -- Look for the triggered enabled interrupts.
    dev_enabled_ints <= dev_ints and cpu_int_enables;
    -- Determine whether or not an interrupt occurred.
    dev_int_occurred <= True when or_reduce(dev_enabled_ints)='1' else False;
    -- Generate interrupt id for devices, for which the
    -- lower the id the higher the priority.
    process (dev_enabled_ints)
        variable triggerred_int : integer range 0 to interrupt_total-1;
    begin
        triggerred_int := 0;
        for each_int in dev_enabled_ints'low to dev_enabled_ints'high loop
            if dev_enabled_ints(each_int)='1' then
                triggerred_int := each_int;
                exit;
            end if;
        end loop;
        dev_triggered_int <= std_logic_vector(to_unsigned(triggerred_int,dev_triggered_int'length));
    end process;
    -- This process block generates the interrupt for the CPU and also
    -- sets which interrupt is occurring.
    process (clock)
    begin
        -- All operations occur on positive edge of the clock.
        if rising_edge(clock) then
            if nreset='0' then
                cpu_int <= '0';
                cpu_int_id <= (others=>'0');
            else
                -- Wait until an enabled interrupt occurs.
                if dev_int_occurred then
                    -- Interrupt the process of the CPU, and let it know
                    -- which interrupt occurred with priority on the lowest interrupt.
                    cpu_int <= '1';
                    cpu_int_id <= dev_triggered_int;
                -- If no enabled interrupts are occurring, no need to
                -- let the CPU anything is happening.
                else
                    cpu_int <= '0';
                end if;
            end if;
        end if;
    end process;

end Behavioral;
