----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2017 07:00:27 PM
-- Design Name: 
-- Module Name: plasoc_axi_full2full_write_cntrl - Behavioral
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

entity plasoc_axi4_full2full_write_cntrl is
    generic (
        axi_id_width : integer := 1;
        axi_address_width : integer := 16;
        axi_data_width : integer := 32);
    port (
        aclk : in std_logic;
        aresetn : in std_logic;
        s_axi_awid : in std_logic_vector(axi_id_width-1 downto 0);
        s_axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);
        s_axi_awlen : in std_logic_vector(7 downto 0);
        s_axi_awsize : in std_logic_vector(2 downto 0);
        s_axi_awburst : in std_logic_vector(1 downto 0);
        s_axi_awlock : in std_logic;
        s_axi_awcache : in std_logic_vector(3 downto 0);
        s_axi_awprot : in std_logic_vector(2 downto 0);
        s_axi_awqos : in std_logic_vector(3 downto 0);
        s_axi_awregion : in std_logic_vector(3 downto 0);
        s_axi_awvalid : in std_logic;
        s_axi_awready : out std_logic;
        s_axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);
        s_axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);
        s_axi_wlast : in std_logic;
        s_axi_wvalid : in std_logic;
        s_axi_wready : out std_logic;
        s_axi_bid : out std_logic_vector(axi_id_width-1 downto 0);
        s_axi_bresp : out  std_logic_vector(1 downto 0);
        s_axi_bvalid : out std_logic;
        s_axi_bready : in std_logic;
        m_axi_awid : out std_logic_vector(axi_id_width-1 downto 0);
        m_axi_awaddr : out std_logic_vector(axi_address_width-1 downto 0);
        m_axi_awlen : out std_logic_vector(7 downto 0);
        m_axi_awsize : out std_logic_vector(2 downto 0);
        m_axi_awburst : out std_logic_vector(1 downto 0);
        m_axi_awlock : out std_logic;
        m_axi_awcache : out std_logic_vector(3 downto 0);
        m_axi_awprot : out std_logic_vector(2 downto 0);
        m_axi_awqos : out std_logic_vector(3 downto 0);
        m_axi_awregion : out std_logic_vector(3 downto 0);
        m_axi_awvalid : out std_logic;
        m_axi_awready : in std_logic;
        m_axi_wdata : out std_logic_vector(axi_data_width-1 downto 0);
        m_axi_wstrb : out std_logic_vector(axi_data_width/8-1 downto 0);
        m_axi_wlast : out std_logic;
        m_axi_wvalid : out std_logic;
        m_axi_wready : in std_logic;
        m_axi_bid : in std_logic_vector(axi_id_width-1 downto 0);
        m_axi_bresp : in  std_logic_vector(1 downto 0);
        m_axi_bvalid : in std_logic;
        m_axi_bready : out std_logic);
end plasoc_axi4_full2full_write_cntrl;

architecture Behavioral of plasoc_axi4_full2full_write_cntrl is
    signal s_axi_awready_buff : std_logic := '0';
    signal m_axi_awvalid_buff : std_logic := '0';
    signal s_axi_wready_buff : std_logic := '0';
    signal m_axi_wvalid_buff : std_logic := '0';
    signal m_axi_wlast_buff : std_logic := '0';
    signal s_axi_bvalid_buff : std_logic := '0';
    signal m_axi_bready_buff : std_logic := '0';
begin
    s_axi_awready <= s_axi_awready_buff;
    m_axi_awvalid <= m_axi_awvalid_buff;
    s_axi_wready <= s_axi_wready_buff;
    m_axi_wvalid <= m_axi_wvalid_buff;
    m_axi_wlast <= m_axi_wlast_buff;
    s_axi_bvalid <= s_axi_bvalid_buff;
    m_axi_bready <= m_axi_bready_buff;
    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                s_axi_awready_buff <= '1';
                m_axi_awvalid_buff <= '0';
            else
                if s_axi_awvalid='1' and s_axi_awready_buff='1' then
                    m_axi_awid <= s_axi_awid;
                    m_axi_awaddr <= s_axi_awaddr;
                    m_axi_awlen <= s_axi_awlen;
                    m_axi_awsize <= s_axi_awsize;
                    m_axi_awburst <= s_axi_awburst;
                    m_axi_awlock <= s_axi_awlock;
                    m_axi_awcache <= s_axi_awcache;
                    m_axi_awprot <= s_axi_awprot;
                    m_axi_awqos <= s_axi_awqos;
                    m_axi_awregion <= s_axi_awregion;
                end if;
                if s_axi_awvalid='1' and s_axi_awready_buff='1' then
                    m_axi_awvalid_buff <= '1';
                elsif m_axi_awvalid_buff='1' and  m_axi_awready='1' then
                    m_axi_awvalid_buff <= '0';
                end if;
                if m_axi_awready='1' then
                    s_axi_awready_buff <= '1';
                elsif s_axi_awvalid='1' and s_axi_awready_buff='1' then
                    s_axi_awready_buff <= '0';
                end if;
            end if;
        end if;
    end process;
    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                s_axi_wready_buff <= '1';
                m_axi_wvalid_buff <= '0';
                m_axi_wlast_buff <= '0';
            else
                if s_axi_wvalid='1' and s_axi_wready_buff='1' then
                    m_axi_wdata <= s_axi_wdata;
                    m_axi_wstrb <= s_axi_wstrb;
                end if;
                if s_axi_wvalid='1' and s_axi_wready_buff='1' then
                    m_axi_wvalid_buff <= '1';
                elsif m_axi_wvalid_buff='1' and m_axi_wready='1' then
                    m_axi_wvalid_buff <= '0';
                end if;
                if s_axi_wvalid='1' and s_axi_wready_buff='1' and s_axi_wlast='1' then
                    m_axi_wlast_buff <= '1';
                elsif m_axi_wvalid_buff='1' and m_axi_wready='1' then
                    m_axi_wlast_buff <= '0';
                end if;
                if m_axi_wready='1' then
                    s_axi_wready_buff <= '1';
                elsif s_axi_wvalid='1' and s_axi_wready_buff='1' then
                    s_axi_wready_buff <= '0';
                end if;
            end if;
        end if;
    end process;
    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                s_axi_bvalid_buff <= '0';
                m_axi_bready_buff <= '1';
            else
                if m_axi_bvalid='1' and m_axi_bready_buff='1' then
                    s_axi_bid <= m_axi_bid;
                    s_axi_bresp <= m_axi_bresp;
                end if;
                if m_axi_bvalid='1' and m_axi_bready_buff='1' then
                    s_axi_bvalid_buff <= '1';
                elsif s_axi_bvalid_buff='1' and s_axi_bready='1' then
                    s_axi_bvalid_buff <= '0';
                end if;
                if s_axi_bready='1' then
                    m_axi_bready_buff <= '1';
                elsif m_axi_bvalid='1' and m_axi_bready_buff='1' then
                    m_axi_bready_buff <= '0';
                end if;
            end if;
        end if;
    end process;
end Behavioral;
