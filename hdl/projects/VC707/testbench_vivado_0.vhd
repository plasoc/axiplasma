-------------------------------------------------------
--! @author Andrew Powell
--! @date March 16, 2017
--! @brief Contains the testbench for simulating the 
--! Plasma-SoC.
-------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.boot_pack.all;
use work.vc707_pack.vc707_default_gpio_width;

entity testbench_vivado_0 is
    generic ( gpio_width : integer := vc707_default_gpio_width; input_delay : time := 0 ns );
end testbench_vivado_0;

architecture Behavioral of testbench_vivado_0 is
    component axiplasma_wrapper is
        generic (
            lower_app : string := "jump";
            upper_app : string := "main";
            upper_ext : boolean := false);
        port( 
            sys_clk_p : in std_logic; -- 200 MHz on the VC707.
            sys_clk_n : in std_logic; -- 200 MHz on the VC707.
            sys_rst : in std_logic;
            gpio_output : out std_logic_vector(vc707_default_gpio_width-1 downto 0);
            gpio_input : in std_logic_vector(vc707_default_gpio_width-1 downto 0);
            uart_tx : out std_logic;
            uart_rx : in std_logic;
            DDR3_addr : out std_logic_vector(13 downto 0);
            DDR3_ba : out std_logic_vector(2 downto 0);
            DDR3_cas_n : out std_logic;
            DDR3_ck_n : out std_logic_vector(0 downto 0);
            DDR3_ck_p : out std_logic_vector(0 downto 0);
            DDR3_cke : out std_logic_vector(0 downto 0);
            DDR3_cs_n : out std_logic_vector(0 downto 0);
            DDR3_dm : out std_logic_vector(7 downto 0);
            DDR3_dq : inout std_logic_vector(63 downto 0);
            DDR3_dqs_n : inout std_logic_vector(7 downto 0);
            DDR3_dqs_p : inout std_logic_vector(7 downto 0);
            DDR3_odt : out std_logic_vector(0 downto 0);
            DDR3_ras_n : out std_logic;
            DDR3_reset_n : out std_logic;
            DDR3_we_n : out std_logic);
    end component;
    constant clock_period : time := 5 ns;
    constant uart_period : time := 104167 ns;
    constant time_out_threshold : integer := 2**30;
    subtype gpio_type is std_logic_vector(gpio_width-1 downto 0);
    signal sys_clk_p : std_logic := '1';
    signal sys_clk_n : std_logic := '0';
    signal sys_rst : std_logic := '1';
    signal gpio_output : gpio_type;
    signal gpio_input : gpio_type := (others=>'0');
    signal uart_tx : std_logic;
    signal uart_clock : std_logic := '1';
    signal uart_tx_data_avail : std_logic := '0';
    signal uart_tx_data_ack : std_logic := '0';
    signal uart_tx_started : boolean := false;
    signal uart_tx_counter : integer range 0 to 8 := 0;
    signal uart_tx_buffer : std_logic_vector(7 downto 0) := (others=>'0');
    signal uart_tx_data : std_logic_vector(7 downto 0) := (others=>'0');
    signal uart_rx : std_logic;
    signal uart_rx_enable : std_logic := '0';
    signal uart_rx_done : std_logic := '0';
    signal uart_rx_data : std_logic_vector(7 downto 0) := (others=>'0');
    signal uart_rx_counter : integer range 0 to 9 := 0;
    signal boot_checksum : std_logic_vector(7 downto 0) := (others=>'0');
begin

    axiplasma_wrapper_inst : axiplasma_wrapper 
        port map ( 
            sys_clk_p => sys_clk_p,
            sys_clk_n => sys_clk_n,
            sys_rst => sys_rst,
            gpio_output => gpio_output,
            gpio_input => gpio_input,
            uart_tx => uart_tx,
            uart_rx => uart_rx,
            DDR3_addr => open,
            DDR3_ba => open,
            DDR3_cas_n => open,
            DDR3_ck_n => open,
            DDR3_ck_p => open,
            DDR3_cke => open,
            DDR3_cs_n => open,
            DDR3_dm => open,
            DDR3_dq => open,
            DDR3_dqs_n => open, 
            DDR3_dqs_p => open,
            DDR3_odt => open,
            DDR3_ras_n => open,
            DDR3_reset_n => open,
            DDR3_we_n => open);

    sys_clk_p <= not sys_clk_p after clock_period/2;
    sys_clk_n <= not sys_clk_n after clock_period/2;
    sys_rst <= '0' after 10*clock_period+input_delay;
    
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
            if uart_tx_data_ack='1' then
                uart_tx_data_avail <= '0';
            elsif uart_tx_started and uart_tx_counter=8 then
                uart_tx_data_avail <= '1';
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
        constant word_width : integer := 32;
        subtype byte_type is std_logic_vector(7 downto 0);
        subtype word_type is std_logic_vector(word_width-1 downto 0);
        
        constant BOOT_LOADER_START_WORD : word_type := x"f0f0f0f0";
        constant BOOT_LOADER_ACK_SUCCESS_BYTE : byte_type := x"01";
        constant BOOT_LOADER_ACK_FAILURE_BYTE : byte_type := x"02";
        constant BOOT_LOADER_STATUS_MORE : byte_type := x"01";
        constant BOOT_LOADER_STATUS_DONE : byte_type := x"02";
        constant BOOT_LOADER_CHECKSUM_DIVISOR : integer := 230;
        
        variable word : word_type;
        variable byte : byte_type;
        variable app_data : ram_type := load_hex;
        variable app_ptr : integer := 0;
        
        procedure set_uart_rx( byte : in byte_type ) is
        begin
            uart_rx_data <= byte;
            uart_rx_enable <= '1';
            wait until uart_rx_done='1';
            wait for uart_period;
            uart_rx_enable <= '0';
            wait for uart_period;
        end;
        
        procedure set_uart_word ( word : in word_type ) is
        begin
            for each_byte in 0 to word_width/8-1 loop
                set_uart_rx(word(7+each_byte*8 downto each_byte*8));
            end loop;
        end;
        
        procedure get_uart_tx is
        begin
            wait until uart_tx_data_avail='1';
            wait for uart_period;
            byte := uart_tx_data;
            uart_tx_data_ack <= '1';
            wait for uart_period;
            uart_tx_data_ack <= '0';
            wait for uart_period;
        end;
        
    begin
--        wait until sys_rst='1';
--        wait until gpio_output=X"0001";
--        wait for 2 ms;
        
--        set_uart_word(BOOT_LOADER_START_WORD);
--        get_uart_tx;
        
--        if byte=BOOT_LOADER_ACK_SUCCESS_BYTE then
--            report "Success ACK";
--        elsif byte=BOOT_LOADER_ACK_FAILURE_BYTE then
--            report "Failed ACK";
--            wait;
--        else
--            report "???";
--            wait;
--        end if;
        
--        while true loop
        
--            -- instruction
--            word := app_data(app_ptr);
--            set_uart_word(word);
            
--            -- checksum
--            word := std_logic_vector(unsigned(word) mod BOOT_LOADER_CHECKSUM_DIVISOR);
--            boot_checksum <= word(7 downto 0);
--            set_uart_rx(word(7 downto 0));
        
--            -- status
--            app_ptr := app_ptr+1;
--            --if app_ptr=ram_size then
--            if app_ptr=13 then
--                set_uart_rx(BOOT_LOADER_STATUS_DONE);
--                exit;
--            else
--                set_uart_rx(BOOT_LOADER_STATUS_MORE);
--            end if;
        
--            -- ack
--            get_uart_tx;
--            if byte=BOOT_LOADER_ACK_SUCCESS_BYTE then
--                report "Success ACK";
--            elsif byte=BOOT_LOADER_ACK_FAILURE_BYTE then
--                report "Failed ACK";
--                wait;
--            else
--                report "???";
--                wait;
--            end if;
        
--        end loop;
        
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
        wait until sys_rst='0';
        wait until gpio_output=X"01";
        wait for 500 us;
        gpio_input <= X"03" after input_delay;
        wait for 2 ms;
        gpio_input <= X"f3" after input_delay;
        wait for 2 ms;
        while True loop
            gpio_input <= X"f1" after input_delay;
            wait for 50 us;
            gpio_input <= X"f0" after input_delay;
            wait for 50 us;
            gpio_input <= X"f5" after input_delay;
            wait for 50 us;
            gpio_input <= X"ff" after input_delay;
            wait for 50 us;
            gpio_input <= X"f7" after input_delay;
            wait for 50 us;
            gpio_input <= X"f0" after input_delay;
            wait for 50 us;
        end loop;
        wait;
    end process;
end Behavioral;
