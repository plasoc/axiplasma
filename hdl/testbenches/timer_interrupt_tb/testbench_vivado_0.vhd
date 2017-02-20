----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2017 07:19:22 PM
-- Design Name: 
-- Module Name: testbench_vivado_0 - Behavioral
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
use work.plasoc_gpio_pack.all;

entity testbench_vivado_0 is
    generic ( gpio_width : integer := 16; input_delay : time := 0 ns );
end testbench_vivado_0;

architecture Behavioral of testbench_vivado_0 is
    component axiplasma_wrapper is
        port( 
            raw_clock : in std_logic; -- 100 MHz on the Nexys 4.
            raw_nreset : in std_logic;
            gpio_output : out std_logic_vector(default_data_out_width-1 downto 0);
            gpio_input : in std_logic_vector(default_data_in_width-1 downto 0));
    end component;
    constant clock_period : time := 10 ns;
    constant time_out_threshold : integer := 2**18;
    subtype gpio_type is std_logic_vector(gpio_width-1 downto 0);
    signal raw_clock : std_logic := '1';
    signal raw_nreset : std_logic := '0';
    signal gpio_output : gpio_type;
    signal gpio_input : gpio_type := (others=>'0');
begin
    -- Instantiation of device under test.
    axiplasma_wrapper_inst : 
    axiplasma_wrapper 
        port map ( 
            raw_clock => raw_clock,
            raw_nreset => raw_nreset,
            gpio_output => gpio_output,
            gpio_input => gpio_input);
    -- Drive syncrhonization signals.
    raw_clock <= not raw_clock after clock_period/2;
    raw_nreset <= '1' after 10*clock_period+input_delay;
    -- Run testbench application.
    process 
        -- This procedure should force the simulation to stop if a 
        -- problem becomes apparent.
        procedure assert_procedure( state : boolean; mesg : string ) is
            variable breaksimulation : std_logic_vector(0 downto 0);
        begin
            if not state then
                assert False report mesg severity error;
                breaksimulation(1) := '1';
            end if;
        end;
        -- The procedure sets a single specified bit of the gpio input interface.
        procedure set_gpio_input( gpio_index : integer ) is
            variable gpio_input_buff : gpio_type := (others=>'0');
        begin
            gpio_input_buff(gpio_index) := '1';
            gpio_input <= gpio_input_buff;
            wait for clock_period;
        end;
        -- Waits for the corresponding output response. If it takes too long,
        -- it is assumed there is an error and the simulation should end as a result.
        procedure wait_for_gpio_output is
            variable assert_counter : integer := 0;
        begin
            while gpio_output/=gpio_input loop
                assert_procedure( state => assert_counter/=time_out_threshold, mesg => "Timeout occurred." );
                assert_counter := assert_counter+1;
                wait for clock_period;
            end loop;
            wait for clock_period;
        end;
    begin
        -- Let's wait for the reset to be disabled before starting anything.
        wait until raw_nreset='1';
        -- Let's wait a WHOLE BUNCH of clock cycles until the boot loader finishes its thang.
        wait for 2**15*clock_period;
        -- Perform the following operation for all bits in gpio input.
        for each_bit in gpio_input'low to gpio_input'high loop
            set_gpio_input(each_bit);
            wait_for_gpio_output;
        end loop;
        -- End simulation once the test has been passed.
        wait;
    end process;
end Behavioral;
