----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/17/2017 07:58:45 PM
-- Design Name: 
-- Module Name: plasoc_axi4_full2full_pack - Behavioral
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

package plasoc_axi4_full2full_pack is

    component plasoc_axi4_full2full is
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
            s_axi_arid : in std_logic_vector(axi_id_width-1 downto 0);
            s_axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
            s_axi_arlen : in std_logic_vector(7 downto 0);
            s_axi_arsize : in std_logic_vector(2 downto 0);
            s_axi_arburst : in std_logic_vector(1 downto 0);
            s_axi_arlock : in std_logic;
            s_axi_arcache : in std_logic_vector(3 downto 0);
            s_axi_arprot : in std_logic_vector(2 downto 0);
            s_axi_arqos : in std_logic_vector(3 downto 0);
            s_axi_arregion : in std_logic_vector(3 downto 0);
            s_axi_arvalid : in std_logic;
            s_axi_arready : out std_logic;
            s_axi_rid : out std_logic_vector(axi_id_width-1 downto 0);
            s_axi_rdata : out std_logic_vector(axi_data_width-1 downto 0);
            s_axi_rresp : out std_logic_vector(1 downto 0);
            s_axi_rlast : out std_logic;
            s_axi_rvalid : out std_logic;
            s_axi_rready : in std_logic;
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
            m_axi_bready : out std_logic;
            m_axi_arid : out std_logic_vector(axi_id_width-1 downto 0);
            m_axi_araddr : out std_logic_vector(axi_address_width-1 downto 0);
            m_axi_arlen : out std_logic_vector(7 downto 0);
            m_axi_arsize : out std_logic_vector(2 downto 0);
            m_axi_arburst : out std_logic_vector(1 downto 0);
            m_axi_arlock : out std_logic;
            m_axi_arcache : out std_logic_vector(3 downto 0);
            m_axi_arprot : out std_logic_vector(2 downto 0);
            m_axi_arqos : out std_logic_vector(3 downto 0);
            m_axi_arregion : out std_logic_vector(3 downto 0);
            m_axi_arvalid : out std_logic;
            m_axi_arready : in std_logic;
            m_axi_rid : in std_logic_vector(axi_id_width-1 downto 0);
            m_axi_rdata : in std_logic_vector(axi_data_width-1 downto 0);
            m_axi_rresp : in std_logic_vector(1 downto 0);
            m_axi_rlast : in std_logic;
            m_axi_rvalid : in std_logic;
            m_axi_rready : out std_logic);
    end component;

end package;
