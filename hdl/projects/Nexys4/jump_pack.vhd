library ieee;
use ieee.std_logic_1164.all;

package jump_pack is

	constant cpu_width : integer := 32;
	constant ram_size : integer := 10;
	subtype word_type is std_logic_vector(cpu_width-1 downto 0);
	type ram_type is array(0 to ram_size-1) of word_type;
	function load_hex return ram_type;

end package;

package body jump_pack is

	function load_hex return ram_type is
		variable ram_buffer : ram_type := (others=>(others=>'0'));
	begin
		ram_buffer(0) := X"3C080100";
		ram_buffer(1) := X"35080000";
		ram_buffer(2) := X"01000008";
		ram_buffer(3) := X"00000000";
		ram_buffer(4) := X"00000100";
		ram_buffer(5) := X"01010001";
		ram_buffer(6) := X"00000000";
		ram_buffer(7) := X"00000000";
		ram_buffer(8) := X"00000000";
		ram_buffer(9) := X"00000000";
		return ram_buffer;
	end;
end;