-------------------------------------------------------
--! @author Andrew Powell
--! @date January 31, 2017
--! @brief Contains the entity and architecture of the 
--! Plasma-SoC's Timer Control Register Bridge.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

--! The Timer Control Register Bridge entity acts as a register
--! stage between the AXI4-Lite Controllers and the Timer Core's
--! Controller. This is only needed to ensure the acknowledgement
--! can only be set high for a single clock cycle, as required by
--! the Controller.
entity plasoc_timer_control_bridge is
    generic (
		-- Slave AXI4-Lite parameters.
        axi_data_width : integer := 32;		--! Defines the AXI4-Lite Data Width.
        timer_width : integer := 16;		--! Defines the width of the Trigger and Tick Value registers.
        start_bit_loc : integer := 0;		--! For the Start bit, defines the bit location in the Control register.
        reload_bit_loc : integer := 1;		--! For the Reload bit, defines the bit location in the Control register.
        ack_bit_loc : integer := 2;			--! For the Acknowledge bit, defines the bit location in the Control register.
        done_bit_loc : integer := 3			--! For the Done bit, defines the bit location in the Control register.
	); 
    port (
        -- Global interface.
        clock : in std_logic;				--! Defines the AXI4-Lite Address Width.
        nreset : in std_logic;				--! Reset on low.
        -- Controller interface.
        start : out std_logic := '0';		--! Starts the operation when high. 
        reload : out std_logic := '0';		--! Enables reloading when high.
        ack : out std_logic := '0';			--! Sets Done low if the core is running with Reload.
        done : in std_logic;				--! If Start is high and Tick Value equals Trigger Value, Done is set high.
        -- Register interface.
        reg_in_valid : in std_logic;														--! When high, enables writing of the Control register.
        reg_in_control : in std_logic_vector(axi_data_width-1 downto 0);					--! New data for the Control register.
        reg_out_control : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0')	--! Current data for the Control register.
	);
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













