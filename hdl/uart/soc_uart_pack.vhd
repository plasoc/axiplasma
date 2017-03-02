library ieee;
use ieee.std_logic_1164.all;

package soc_uart_pack is

    constant axi_resp_okay : std_logic_vector := "00";

    function clogb2(bit_depth : in integer ) return integer;

end package;

package body soc_uart_pack is

    function flogb2(bit_depth : in natural ) return integer is
		variable result : integer := 0;
		variable bit_depth_buff : integer := bit_depth;
	begin
		while bit_depth_buff>1 loop
			bit_depth_buff := bit_depth_buff/2;
			result := result+1;
		end loop; 
		return result;
	end function flogb2; 
	
	function clogb2 (bit_depth : in natural ) return natural is
		variable result : integer := 0;
	begin
		result := flogb2(bit_depth);
		if (bit_depth > (2**result)) then
			return(result + 1);
		else
			return result;
		end if;
	end function clogb2;

end;