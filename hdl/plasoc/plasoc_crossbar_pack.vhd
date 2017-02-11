----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2017 12:35:53 PM
-- Design Name: 
-- Module Name: plasoc_crossbar_pack - Behavioral
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

package plasoc_crossbar_pack is

    function clogb2(bit_depth : in integer ) return integer;

end package;

package body plasoc_crossbar_pack is

    function clogb2(bit_depth : in natural ) return integer is
		variable result : integer := 0;
		variable bit_depth_buff : integer := bit_depth;
	begin
		while bit_depth_buff>1 loop
			bit_depth_buff := bit_depth_buff/2;
			result := result+1;
		end loop; 
		return result;
	end; 
	
end;