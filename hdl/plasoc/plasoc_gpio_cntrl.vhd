library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity plasoc_gpio_cntrl is
    generic (
        constant data_in_width : integer := 16 );
    port (
        clock : in std_logic;
        nreset : in std_logic;
        enable : in std_logic;
        ack : in std_logic;
        int : out std_logic;
        data_in_axi : out std_logic_vector(data_in_width-1 downto 0);
        data_in_periph : in std_logic_vector(data_in_width-1 downto 0) );
end plasoc_gpio_cntrl;

architecture Behavioral of plasoc_gpio_cntrl is
    signal data_in_axi_buff : std_logic_vector(data_in_width-1 downto 0) := (others=>'0');
    signal int_buff : std_logic := '0';
begin
    data_in_axi <= data_in_axi_buff;
    int <= int_buff;
    process (clock)
    begin
        -- Perform operations in synch with positive edge of clock.
        if rising_edge(clock) then
            -- Reset on low.
            if nreset='0' then
                int_buff <= '0';
            -- Normal operation occurs when reset is high.
            else
                -- The interrupt operation only occurs when enable is set high.
                if enable='1' then
                    -- If no interrupt is occurring, check for new data.
                    if int_buff='0' and data_in_axi_buff/=data_in_periph then
                        -- If new data is available, sample the input and set the interrupt.
                        data_in_axi_buff <= data_in_periph;
                        int_buff <= '1';
                    -- Once the interrupt is acknowledged, set the interrupt to low.
                    elsif ack='1' then
                        int_buff <= '0';
                    end if;
                -- If interrupts are not enabled, always register the input.
                else
                    data_in_axi_buff <= data_in_periph;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
