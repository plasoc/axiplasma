----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2017 11:09:01 AM
-- Design Name: 
-- Module Name: plasoc_timer_cntrl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

entity plasoc_timer_cntrl is
    generic (
        timer_width : integer := 16 );
    port (
        -- global interface.
        clock : in std_logic;
        -- timer control interface.
        start : in std_logic;
        reload : in std_logic;
        ack : in std_logic;
        done : out std_logic := '0';
        -- time data interface.
        trig_value : in std_logic_vector(timer_width-1 downto 0);
        tick_value : out std_logic_vector(timer_width-1 downto 0));
end plasoc_timer_cntrl;

architecture Behavioral of plasoc_timer_cntrl is
    signal reload_buff : boolean := False;
    signal trig_value_buff : integer range 0 to 2**timer_width-1 := 0;
    signal tick_counter : integer range 0 to 2**timer_width-1 := 0;
begin

    -- Output the current tick value.
    tick_value <= std_logic_vector(to_unsigned(tick_counter,timer_width));

    -- Drive the operation of the simple timer.
    process (clock)
    begin
        -- Perform operations in synch with the rising edge of the clock.
        if rising_edge(clock) then
            -- The start control signal behaves as core's enable. The core begins
            -- its operation when the start is set high.
            if start='1' then
                -- Check to if the counter has reached the trigger value.
                if tick_counter=trig_value_buff then
                    if reload_buff then
                        tick_counter <= 0;
                    end if;
                    done <= '1';
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
            -- information, such as the reload and trigger values, can be bufferred into the core.
            else
                reload_buff <= reload='1';
                trig_value_buff <= to_integer(unsigned(trig_value));
                tick_counter <= 0;
                done <= '0';
            end if;
        end if;
    end process;

end Behavioral;
