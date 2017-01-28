----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2017 03:13:16 PM
-- Design Name: 
-- Module Name: plasoc_int_axi4_write_cntrl - Behavioral
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

entity plasoc_int_axi4_write_cntrl is
    generic (
        -- axi parameters.
        axi_address_width : integer := 16;
        axi_data_width : integer := 32;
        -- interrupt controller parameters.
        int_interrupt_total : integer := 8;
        int_cpu_int_enables_address : std_logic_vector := X"0000");
    port (
        -- global interface.
        aclk : in std_logic;
        aresetn : in std_logic;
        -- axi write interface.
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
        -- cpu interface.
        cpu_int_enables : out std_logic_vector(int_interrupt_total-1 downto 0));
end plasoc_int_axi4_write_cntrl;

architecture Behavioral of plasoc_int_axi4_write_cntrl is

begin


end Behavioral;
