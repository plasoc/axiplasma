-------------------------------------------------------
--! @author Andrew Powell
--! @date January 28, 2017
--! @brief Contains the entity and architecture of the 
--! Interrupt Controller's main functionality.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use work.plasoc_int_pack.all;

--! The functionality of the Interrupt Controller is defined
--! in this entity. For more information on how the Interrupt Controller
--! operates as a whole, please see the hardware description of the top entity 
--! plasoc_int. 
entity plasoc_int_cntrl is
    generic (
        interrupt_total : integer := 8 		--! Defines the number of available device interrupts.
	);
    port (
        -- Global interface.
        clock : in std_logic;													--! Clock. Tested with 50 MHz.
        nreset : in std_logic;													--! Reset on low.
        -- CPU interface.
        cpu_int : out std_logic := '0';											--! CPU interrupt. This signal is set high when there is an active interrupt.
        cpu_int_id : out std_logic_vector(clogb2(interrupt_total) downto 0);	--! Interrupt Identifier. This signal is set to the the identifier of the lowest identifier of the active interrupt, otherwise it is set to interrupt_total.  
        cpu_int_enables : in std_logic_vector(interrupt_total-1 downto 0);		--! Interrupt Enables. Each bit enables the corresponding device interrupt.
        cpu_int_active : out std_logic_vector(interrupt_total-1 downto 0);		--! Interrupt Active. Each bit refers to an active interrupt.
        -- Device interface.
        dev_ints : in std_logic_vector(interrupt_total-1 downto 0)				--! Device interrupts. The devices must set their corresponding device interrupt high to signal an interrupt.
	);			
end plasoc_int_cntrl;

architecture Behavioral of plasoc_int_cntrl is
    signal cpu_int_active_buff : std_logic_vector(interrupt_total-1 downto 0);
    signal cpu_int_id_buff : std_logic_vector(clogb2(interrupt_total) downto 0);
    signal dev_int_occurred : boolean;
begin
    -- Look for the active enabled interrupts.
    cpu_int_active_buff <= dev_ints and cpu_int_enables;
    cpu_int_active <= cpu_int_active_buff;
    -- Determine whether or not an interrupt occurred.
    dev_int_occurred <= True when or_reduce(cpu_int_active_buff)='1' else False;
    -- Generate interrupt id for devices, for which the
    -- lower the id the higher the priority.
    process (cpu_int_active_buff)
        variable triggerred_int : integer range 0 to interrupt_total;
    begin
        triggerred_int := interrupt_total;
        for each_int in cpu_int_active_buff'low to cpu_int_active_buff'high loop
            if cpu_int_active_buff(each_int)='1' then
                triggerred_int := each_int;
                exit;
            end if;
        end loop;
        cpu_int_id_buff <= std_logic_vector(to_unsigned(triggerred_int,cpu_int_id_buff'length));
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
                -- If no enabled interrupts are occurring, no need to
                -- let the CPU anything is happening.
                else
                    cpu_int <= '0';
                end if;
                cpu_int_id <= cpu_int_id_buff;
            end if;
        end if;
    end process;

end Behavioral;
