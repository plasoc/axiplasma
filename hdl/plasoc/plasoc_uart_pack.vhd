-------------------------------------------------------
--! @author Andrew Powell
--! @date March 17, 2017
--! @brief Contains the package and component declaration of the 
--! Plasma-SoC's UART Core. Please refer to the documentation
--! in plasoc_uart.vhd for more information.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package plasoc_uart_pack is

    constant default_uart_fifo_depth : integer := 8;
    constant default_uart_axi_control_offset : integer := 0;
    constant default_uart_axi_control_status_in_avail_bit_loc : integer := 0;
    constant default_uart_axi_control_status_out_avail_bit_loc : integer := 1;
    constant default_uart_axi_in_fifo_offset : integer := 4;
    constant default_uart_axi_out_fifo_offset : integer := 8;
    constant default_uart_baud : positive := 9600;
    constant default_uart_clock_frequency : positive := 50000000;

    constant axi_resp_okay : std_logic_vector := "00";

    component plasoc_uart is
        generic (
            fifo_depth : integer := default_uart_fifo_depth;
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            axi_control_offset : integer := default_uart_axi_control_offset;
            axi_control_status_in_avail_bit_loc : integer := default_uart_axi_control_status_in_avail_bit_loc;
            axi_control_status_out_avail_bit_loc : integer := default_uart_axi_control_status_out_avail_bit_loc;
            axi_in_fifo_offset : integer := default_uart_axi_in_fifo_offset;
            axi_out_fifo_offset : integer := default_uart_axi_out_fifo_offset;
            baud : positive := default_uart_baud;
            clock_frequency : positive := default_uart_clock_frequency);
        port (
            aclk : in std_logic;
            aresetn : in std_logic;
            axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);
            axi_awprot : in std_logic_vector(2 downto 0);
            axi_awvalid : in std_logic;
            axi_awready : out std_logic;
            axi_wvalid : in std_logic;
            axi_wready : out std_logic;
            axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);
            axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);
            axi_bvalid : out std_logic;
            axi_bready : in std_logic;
            axi_bresp : out std_logic_vector(1 downto 0);
            axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
            axi_arprot : in std_logic_vector(2 downto 0);
            axi_arvalid : in std_logic;
            axi_arready : out std_logic;
            axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
            axi_rvalid : out std_logic;
            axi_rready : in std_logic;
            axi_rresp : out std_logic_vector(1 downto 0); 
            tx : out std_logic;
            rx : in  std_logic;
            status_in_avail : out std_logic);
    end component;

    function clogb2(bit_depth : in integer ) return integer;

end package;

package body plasoc_uart_pack is

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