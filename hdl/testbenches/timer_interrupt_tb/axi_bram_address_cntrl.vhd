----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2017 10:24:04 AM
-- Design Name: 
-- Module Name: axi_bram_address_cntrl - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity axi_bram_address_cntrl is
    port (
        aclk : in std_logic;
        aresetn : in std_logic;
        m_axi_awvalid : in std_logic;
        m_axi_awready : out std_logic;
        s_axi_awvalid : out std_logic;
        s_axi_awready : in std_logic;
        m_axi_arvalid : in std_logic;
        m_axi_arready : out std_logic;
        s_axi_arvalid : out std_logic;
        s_axi_arready : in std_logic);
end axi_bram_address_cntrl;

architecture Behavioral of axi_bram_address_cntrl is
    signal m_axi_awready_buff : std_logic;
    signal s_axi_awvalid_buff : std_logic;
    signal m_axi_arready_buff : std_logic;
    signal s_axi_arvalid_buff : std_logic;
begin
    m_axi_awready <= m_axi_awready_buff; 
    s_axi_awvalid <= s_axi_awvalid_buff;
    m_axi_arready <= m_axi_arready_buff; 
    s_axi_arvalid <= s_axi_arvalid_buff;
    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                s_axi_awvalid_buff <= '0'; 
                m_axi_awready_buff <= '1';
            else
                if m_axi_awvalid='1' and m_axi_awready_buff='1' then
                    m_axi_awready_buff <= '0';
                elsif s_axi_awvalid_buff='1' and s_axi_awready='1' then
                    m_axi_awready_buff <= '1';
                end if;
                if s_axi_awvalid_buff='1' and s_axi_awready='1' then
                    s_axi_awvalid_buff <= '0';
                elsif m_axi_awvalid='1' and m_axi_awready_buff='1' then
                    s_axi_awvalid_buff <= '1';
                end if;
            end if;
        end if;
    end process;
    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                s_axi_arvalid_buff <= '0'; 
                m_axi_arready_buff <= '1';
            else
                if m_axi_arvalid='1' and m_axi_arready_buff='1' then
                    m_axi_arready_buff <= '0';
                elsif s_axi_arvalid_buff='1' and s_axi_arready='1' then
                    m_axi_arready_buff <= '1';
                end if;
                if s_axi_arvalid_buff='1' and s_axi_arready='1' then
                    s_axi_arvalid_buff <= '0';
                elsif m_axi_arvalid='1' and m_axi_arready_buff='1' then
                    s_axi_arvalid_buff <= '1';
                end if;
            end if;
        end if;
    end process;
end Behavioral;
