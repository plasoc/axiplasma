----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2017 01:35:29 PM
-- Design Name: 
-- Module Name: plasoc_timer_control_bridge - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity plasoc_timer_control_bridge is
    generic (
        axi_data_width : integer := 32;
        timer_width : integer := 16;
        start_bit_loc : integer := 0;
        reload_bit_loc : integer := 1;
        ack_bit_loc : integer := 2;
        done_bit_loc : integer := 3); 
    port (
        -- global interface.
        clock : in std_logic;
        nreset : in std_logic;
        -- timer interface.
        start : out std_logic := '0';
        reload : out std_logic := '0';
        ack : out std_logic := '0';
        done : in std_logic;
        -- register interface.
        reg_in_valid : in std_logic;
        reg_in_control : in std_logic_vector(axi_data_width-1 downto 0);
        reg_out_control : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0'));
end plasoc_timer_control_bridge;

architecture Behavioral of plasoc_timer_control_bridge is
begin

    -- Adds a register stage between the axi interfaces and the timer controller.
    process (clock)
    begin
        -- Perform operations in synch with rising edge of clock.
        if rising_edge(clock) then
            -- Reset on low.
            if nreset='0' then
                reg_out_control <= (others=>'0');
                start <= '0';
                reload <= '0';
                ack <= '0';
            -- Normal operation when reset is high.
            else
                -- Sample control in interface when valid data is available.
                if reg_in_valid='1' then
                    -- Set the start control signal and corresponding control out bit.
                    start <= reg_in_control(start_bit_loc);
                    reg_out_control(start_bit_loc) <= reg_in_control(start_bit_loc);
                    -- Set the read control signal and corresponding control out bit.
                    reload <= reg_in_control(reload_bit_loc);
                    reg_out_control(reload_bit_loc) <= reg_in_control(reload_bit_loc);
                    -- Set the ack control signal.
                    ack <= reg_in_control(ack_bit_loc);
                else
                    -- The default state of the acknowledgement should be low.
                    ack <= '0';
                end if;
                -- Sample the done bit.
                reg_out_control(done_bit_loc) <= done;
            end if;
        end if;
    end process;

end Behavioral;













