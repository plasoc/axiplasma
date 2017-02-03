library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity invoke_reset is
    generic ( trig_value : integer := 128 );
    port( raw_clock : in std_logic; raw_nreset : out std_logic:= '0' );
end invoke_reset;

architecture Behavioral of invoke_reset is
    signal counter : integer := 0;
begin
    process (raw_clock)
    begin
        if counter=trig_value then
            raw_nreset <= '1';
        else
            counter <= counter+1;
        end if;
    end process;
end Behavioral;
