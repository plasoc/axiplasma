----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/28/2017 06:10:40 PM
-- Design Name: 
-- Module Name: plasoc_int - Behavioral
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
use work.mlitesoc_pack.all;

entity plasoc_int is
    generic(
        -- axi parameters.
        axi_address_width : integer := 16;
        axi_data_width : integer := 32;
        -- interrupt controller parameters.
        interrupt_total : integer := 8;
        int_id_address : std_logic_vector := X"0004";
        int_enables_address : std_logic_vector := X"0000" );
    port(
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
        -- axi read interface.
        axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
        axi_arprot : in std_logic_vector(2 downto 0);
        axi_arvalid : in std_logic;
        axi_arready : out std_logic;
        axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
        axi_rvalid : out std_logic;
        axi_rready : in std_logic;
        axi_rresp : out std_logic_vector(1 downto 0);
        -- cpu interface.
        cpu_int : out std_logic;
        -- dev interface.
        dev_ints : in std_logic_vector(interrupt_total-1 downto 0));
end plasoc_int;

architecture Behavioral of plasoc_int is
    component plasoc_int_cntrl is
        generic (
            interrupt_total : integer := 8 );
        port (
            -- global interface.
            clock : in std_logic;
            nreset : in std_logic;
            -- cpu interface.
            cpu_int : out std_logic := '0';
            cpu_int_id : out std_logic_vector(clogb2(interrupt_total)-1 downto 0) := (others=>'0');
            cpu_int_enables : in std_logic_vector(interrupt_total-1 downto 0);
            -- device interface.
            dev_ints : in std_logic_vector(interrupt_total-1 downto 0));
    end component;
    component plasoc_int_axi4_read_cntrl is
        generic (
            -- axi parameters.
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            -- interrupt controller parameters.
            int_id_address : std_logic_vector := X"0004";
            int_enables_address : std_logic_vector := X"0000");
        port ( 
            -- global interface.
            aclk : in std_logic;
            aresetn : in std_logic;
            -- axi read interface.
            axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
            axi_arprot : in std_logic_vector(2 downto 0);
            axi_arvalid : in std_logic;
            axi_arready : out std_logic;
            axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
            axi_rvalid : out std_logic;
            axi_rready : in std_logic;
            axi_rresp : out std_logic_vector(1 downto 0);
            -- interrupt controller interface.
            int_id : in std_logic_vector(axi_data_width-1 downto 0);
            int_enables : in std_logic_vector(axi_data_width-1 downto 0));
    end component;
    component plasoc_int_axi4_write_cntrl is
        generic (
            -- axi parameters.
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            -- interrupt controller parameters.
            int_enables_address : std_logic_vector := X"0000");
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
            -- interrupt controller interface.
            int_enables : out std_logic_vector(axi_data_width-1 downto 0));
    end component;
    signal int_id : std_logic_vector(axi_data_width-1 downto 0);
    signal int_enables : std_logic_vector(axi_data_width-1 downto 0);
begin
    int_id(axi_data_width-1 downto clogb2(interrupt_total)) <= (others=>'0');
    
    plasoc_int_cntrl_inst :
    plasoc_int_cntrl 
        generic map (
            interrupt_total => interrupt_total )
        port map (
            clock => aclk,
            nreset => aresetn,
            cpu_int => cpu_int,
            cpu_int_id => int_id(clogb2(interrupt_total)-1 downto 0),
            cpu_int_enables => int_enables(interrupt_total-1 downto 0),
            dev_ints => dev_ints);
            
    plasoc_int_axi4_read_cntrl_inst :
    plasoc_int_axi4_read_cntrl 
        generic map (
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            int_id_address => int_id_address,
            int_enables_address => int_enables_address)
        port map ( 
            aclk => aclk,
            aresetn => aresetn,
            axi_araddr => axi_araddr,
            axi_arprot => axi_arprot,
            axi_arvalid => axi_arvalid,
            axi_arready => axi_arready,
            axi_rdata => axi_rdata,
            axi_rvalid => axi_rvalid,
            axi_rready => axi_rready,
            axi_rresp => axi_rresp,
            int_id => int_id,
            int_enables => int_enables);
            
    plasoc_int_axi4_write_cntrl_inst :
    plasoc_int_axi4_write_cntrl 
        generic map (
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            int_enables_address => int_enables_address)
        port map (
            aclk => aclk,
            aresetn => aresetn,
            axi_awaddr => axi_awaddr,
            axi_awprot => axi_awprot,
            axi_awvalid => axi_awvalid,
            axi_awready => axi_awready,
            axi_wvalid => axi_wvalid,
            axi_wready => axi_wready,
            axi_wdata => axi_wdata,
            axi_wstrb => axi_wstrb,
            axi_bvalid => axi_bvalid,
            axi_bready => axi_bready,
            axi_bresp => axi_bresp,
            int_enables => int_enables);

end Behavioral;
