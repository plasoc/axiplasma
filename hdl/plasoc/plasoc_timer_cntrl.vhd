-------------------------------------------------------
--! @author Andrew Powell
--! @date January 31, 2017
--! @brief Contains the entity and architecture of the 
--! Timer Core's Controller.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

--! The functionality of the Timer Core is defined in this entity and respective
--! architecture. For more information on how the Timer Core operates as a whole, 
--! please see the hardware description of the top entity plasoc_timer.
entity plasoc_timer_cntrl is
    generic (
        timer_width : integer := 32		--! Defines the width of the Trigger and Tick Value registers. 
	);
    port (
        -- Global interface.
        clock : in std_logic;										--! Clock. Tested with 50 MHz.
        -- Timer Core Control interface.
        start : in std_logic;										--! Starts the operation when high. 
        reload : in std_logic;										--! Enables reloading when high.
        ack : in std_logic;											--! Sets Done low if the core is running with Reload.
        done : out std_logic := '0';								--! If Start is high and Tick Value equals Trigger Value, Done is set high.
        -- Timer Core Data interface.
        trig_value : in std_logic_vector(timer_width-1 downto 0);	--! The value Tick Value needs to equal in order for Done to be set high.
        tick_value : out std_logic_vector(timer_width-1 downto 0)	--! Increments every clock cycle when the core is in operation.
	);
end plasoc_timer_cntrl;

architecture Behavioral of plasoc_timer_cntrl is
    signal trig_value_buff : integer;
    signal tick_counter : integer;
begin

    -- Output the current tick value.
    tick_value <= std_logic_vector(to_unsigned(tick_counter,timer_width));

    -- Drive the operation of the simple timer.
    process (clock)
    begin
        -- Perform operations in synch with the rising edge of the clock.
        if rising_edge(clock) then
            -- The start control signal behaves as the core's enable. The core begins
            -- its operation when the start is set high.
            if start='1' then
                -- Check to if the counter has reached the trigger value.
                if tick_counter=trig_value_buff then
                    -- Have the timer automatically reset if the reload flag is high.
                    if reload='1' then
                        tick_counter <= 0;
                    end if;
                    -- When the trigger value is reached, set the done signal unless
                    -- the timer is already being acknowledged.
                    if ack='0' then
                        done <= '1';
                    end if;
                -- Increment the counter until the trigger value is reached.
                else
                    -- Reset the done control signal if it is acknowledged.
                    if ack='1' then
                        done <= '0';
                    end if; 
                    -- Increment the counter.
                    tick_counter <= tick_counter+1;
                end if;
            -- If the start signal is low, the operation is immediately disabled. Instead, control 
            -- information can be bufferred into the core.
            else
                trig_value_buff <= to_integer(unsigned(trig_value));
                tick_counter <= 0;
                done <= '0';
            end if;
        end if;
    end process;

end Behavioral;
