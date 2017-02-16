library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

package plasoc_int_pack is

    -- Default Interrupt Controller parameters. These values are modifiable. If these parameters are 
	-- modified, though, modifications will also be necessary for the corresponding header file. 
    constant default_interrupt_total : integer := 8;                                    --! Defines the default number of available device interrupts.
    constant default_int_id_offset : integer := 4;                                      --! For the Interrupt Identifier register, defines the default offset from the Interrupt Controller's axi_base_address.				
    constant default_int_enables_offset : integer := 0;                                 --! For the Interrupt Enables register, defines the default offset from the instantiations's base address.
    constant default_int_active_address : integer := 8;                                 --! For the Interrupt Active register, defines the default offset from the instantiations's base address.

    constant axi_resp_okay : std_logic_vector := "00";

    -- Function declarations.
    function clogb2(bit_depth : in integer ) return integer;
    
    -- Component declaration.
    component plasoc_int is
        generic(
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            axi_int_id_offset : integer := default_int_id_offset;
            axi_int_enables_offset : integer := default_int_enables_offset;
            axi_int_active_offset : integer := default_int_active_address;
            interrupt_total : integer := default_interrupt_total);
        port(
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
            cpu_int : out std_logic;
            dev_ints : in std_logic_vector(interrupt_total-1 downto 0));
    end component;

end;

package body plasoc_int_pack is

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