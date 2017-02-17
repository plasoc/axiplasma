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
    generic (
        axi_id_width : integer := 1;
        axi_address_width : integer := 16);
    port (
        aclk : in std_logic;
        aresetn : in std_logic;
        m_axi_awid : in std_logic_vector(axi_id_width-1 downto 0);
        m_axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);
        m_axi_awlen : in std_logic_vector(7 downto 0);
        m_axi_awsize : in std_logic_vector(2 downto 0);
        m_axi_awburst : in std_logic_vector(1 downto 0);
        m_axi_awlock : in std_logic;
        m_axi_awcache : in std_logic_vector(3 downto 0);
        m_axi_awprot : in std_logic_vector(2 downto 0);
        m_axi_awvalid : in std_logic;
        m_axi_awready : out std_logic;
        s_axi_awid : out std_logic_vector(axi_id_width-1 downto 0) := (others=>'0');
        s_axi_awaddr : out std_logic_vector(axi_address_width-1 downto 0) := (others=>'0');
        s_axi_awlen : out std_logic_vector(7 downto 0) := (others=>'0');
        s_axi_awsize : out std_logic_vector(2 downto 0) := (others=>'0');
        s_axi_awburst : out std_logic_vector(1 downto 0) := (others=>'0');
        s_axi_awlock : out std_logic := '0';
        s_axi_awcache : out std_logic_vector(3 downto 0) := (others=>'0');
        s_axi_awprot : out std_logic_vector(2 downto 0) := (others=>'0');
        s_axi_awvalid : out std_logic;
        s_axi_awready : in std_logic;
        m_axi_arid : in std_logic_vector(axi_id_width-1 downto 0);
        m_axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
        m_axi_arlen : in std_logic_vector(7 downto 0);
        m_axi_arsize : in std_logic_vector(2 downto 0);
        m_axi_arburst : in std_logic_vector(1 downto 0);
        m_axi_arlock : in std_logic;
        m_axi_arcache : in std_logic_vector(3 downto 0);
        m_axi_arprot : in std_logic_vector(2 downto 0);
        m_axi_arvalid : in std_logic;
        m_axi_arready : out std_logic;
        s_axi_arid : out std_logic_vector(axi_id_width-1 downto 0) := (others=>'0');
        s_axi_araddr : out std_logic_vector(axi_address_width-1 downto 0) := (others=>'0');
        s_axi_arlen : out std_logic_vector(7 downto 0) := (others=>'0');
        s_axi_arsize : out std_logic_vector(2 downto 0) := (others=>'0');
        s_axi_arburst : out std_logic_vector(1 downto 0) := (others=>'0');
        s_axi_arlock : out std_logic := '0';
        s_axi_arcache : out std_logic_vector(3 downto 0) := (others=>'0');
        s_axi_arprot : out std_logic_vector(2 downto 0) := (others=>'0');
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
                    s_axi_awid <= m_axi_awid;
                    s_axi_awaddr <= m_axi_awaddr;
                    s_axi_awlen <= m_axi_awlen;
                    s_axi_awsize <= m_axi_awsize;
                    s_axi_awburst <= m_axi_awburst;
                    s_axi_awlock <= m_axi_awlock;
                    s_axi_awcache <= m_axi_awcache;
                    s_axi_awprot <= m_axi_awprot;
                end if;
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
                    s_axi_arid <= m_axi_arid;
                    s_axi_araddr <= m_axi_araddr;
                    s_axi_arlen <= m_axi_arlen;
                    s_axi_arsize <= m_axi_arsize;
                    s_axi_arburst <= m_axi_arburst;
                    s_axi_arlock <= m_axi_arlock;
                    s_axi_arcache <= m_axi_arcache;
                    s_axi_arprot <= m_axi_arprot;
                end if;
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
