library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

package plasoc_gpio_pack is

	constant axi_resp_okay : std_logic_vector := "00";
    
    	function remove_baseFaddress(  address : in std_logic_vector; base_address : in std_logic_vector ) return std_logic_vector;

end;

package body plasoc_gpio_pack is

	function remove_baseFaddress(  address : in std_logic_vector; base_address : in std_logic_vector ) return std_logic_vector is
		variable result : std_logic_vector(base_address'length-1 downto 0);
		variable address_0 : integer :=  to_integer(unsigned(address));
		variable base_address_0 : integer :=  to_integer(unsigned(base_address));
	begin
		result := std_logic_vector(to_unsigned(address_0-base_address_0,base_address'length));
		return result;
	end;

end;
