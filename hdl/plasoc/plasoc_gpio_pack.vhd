-------------------------------------------------------
--! @author Andrew Powell
--! @date March 17, 2017
--! @brief Contains the package and component declaration of the 
--! Plasma-SoC's GPIO Core. Please refer to the documentation
--! in plasoc_gpio.vhd for more information.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

package plasoc_gpio_pack is

    constant default_data_in_width : integer := 16;
    constant default_data_out_width : integer := 16;
    constant default_axi_control_offset : integer := 0;         
    constant default_axi_control_enable_bit_loc : integer := 0;
    constant default_axi_control_ack_bit_loc : integer := 1;
    constant default_axi_data_in_offset : integer := 4;
    constant default_axi_data_out_offset : integer := 8;

	constant axi_resp_okay : std_logic_vector := "00";
    
    component plasoc_gpio is
        generic (
            data_in_width : integer := default_data_in_width;
            data_out_width : integer := default_data_out_width;
            axi_address_width : integer := 16;                     
            axi_data_width : integer := 32;    
            axi_control_offset : integer := default_axi_control_offset;        
            axi_control_enable_bit_loc : integer := default_axi_control_enable_bit_loc;
            axi_control_ack_bit_loc : integer := default_axi_control_ack_bit_loc;
            axi_data_in_offset : integer := default_axi_data_in_offset;
            axi_data_out_offset : integer := default_axi_data_out_offset 
        );
        port (
            aclk : in std_logic;                                              
            aresetn : in std_logic;
            data_in : in std_logic_vector(data_in_width-1 downto 0);
            data_out : out std_logic_vector(data_out_width-1 downto 0);
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
            int : out std_logic);    
    end component;

end;