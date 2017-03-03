
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
             gpio_input : in std_logic_vector(default_data_in_width-1 downto 0);
             uart_tx : out std_logic;
             uart_rx : in std_logic);
    end component;
    constant clock_period : time := 10 ns;
    constant uart_period : time := 104167 ns;
    constant time_out_threshold : integer := 2**30;
    subtype gpio_type is std_logic_vector(gpio_width-1 downto 0);
    signal raw_clock : std_logic := '1';
    signal raw_nreset : std_logic := '0';
    signal gpio_output : gpio_type;
    signal gpio_input : gpio_type := (others=>'0');
    signal uart_tx : std_logic;
    signal uart_clock : std_logic := '1';
    signal uart_tx_started : boolean := false;
    signal uart_tx_counter : integer range 0 to 8 := 0;
    signal uart_tx_buffer : std_logic_vector(7 downto 0) := (others=>'0');
    signal uart_tx_data : std_logic_vector(7 downto 0) := (others=>'0');
    signal uart_rx : std_logic;
    signal uart_rx_enable : std_logic := '0';
    signal uart_rx_done : std_logic := '0';
    signal uart_rx_data : std_logic_vector(7 downto 0) := (others=>'0');
    signal uart_rx_counter : integer range 0 to 9 := 0;
begin

    axiplasma_wrapper_inst : axiplasma_wrapper 
        port map ( 
            raw_clock => raw_clock,
            raw_nreset => raw_nreset,
            gpio_output => gpio_output,
            gpio_input => gpio_input,
            uart_tx => uart_tx,
            uart_rx => uart_rx);

    raw_clock <= not raw_clock after clock_period/2;
    raw_nreset <= '1' after 10*clock_period+input_delay;
    
    -- Get uart_tx
    uart_clock <= not uart_clock after uart_period/2;
    process (uart_clock)
    begin
        if rising_edge(uart_clock) then
            if uart_tx_started then
                uart_tx_counter <= uart_tx_counter+1;
                if uart_tx_counter=8 then
                    uart_tx_data <= uart_tx_buffer;
                    uart_tx_started <= false;
                else
                    uart_tx_buffer(uart_tx_counter) <= uart_tx;
                end if;
            elsif uart_tx='0' then
                uart_tx_started <= true;
                uart_tx_counter <= 0;
            end if;
        end if;
    end process;
    
    -- Set uart_rx
    uart_rx_done <= '1' when uart_rx_counter=9 else '0';
    process (uart_clock)
    begin
        if rising_edge(uart_clock) then
            if uart_rx_enable='1' then
                if uart_rx_counter/=9 then
                    uart_rx_counter <= uart_rx_counter+1;
                    if uart_rx_counter=0 then
                        uart_rx <= '0';
                    elsif uart_rx_counter<= 8 then
                        uart_rx <= uart_rx_data(uart_rx_counter-1);
                    end if;
                else
                    uart_rx <= '1';
                end if;
            else
                uart_rx_counter <= 0;
                uart_rx <= '1';
            end if;
        end if;
    end process;
    
    process 
        procedure set_uart_rx( byte : in std_logic_vector(7 downto 0) ) is
        begin
            uart_rx_data <= byte;
            uart_rx_enable <= '1';
            wait until uart_rx_done='1';
            wait for clock_period;
            uart_rx_enable <= '0';
            wait for clock_period;
        end;
    begin
        wait until raw_nreset='1';
        wait until gpio_output=X"0001";
        wait for 2 ms;
        set_uart_rx(X"01");
        wait;
    end process;
    
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
        wait until raw_nreset='1';
        wait until gpio_output=X"0001";
        wait for 500 us;
        gpio_input <= X"0003" after input_delay;
        wait for 2 ms;
        gpio_input <= X"00f3" after input_delay;
        wait for 2 ms;
        while True loop
            gpio_input <= X"00f1" after input_delay;
            wait for 500 us;
            gpio_input <= X"00f0" after input_delay;
            wait for 500 us;
        end loop;
        wait;
    end process;
end Behavioral;
