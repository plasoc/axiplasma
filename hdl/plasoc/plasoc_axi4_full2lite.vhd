----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2017 12:34:34 PM
-- Design Name: 
-- Module Name: plasoc_axi4_full2lite - Behavioral
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

entity plasoc_axi4_full2lite is
    generic (
        axi_address_width : integer := 32;
        axi_data_width : integer := 32);
    port (
        -- Global interface.
        aclk : in std_logic;                                    --! Defines the AXI4-Lite Address Width.
        aresetn : in std_logic;                                 --! Reset on low.
        -- Slave AXI4-Full Write interface.
        s_axi_awaddr : out std_logic_vector(axi_address_width-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awlen : out std_logic_vector(8-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awsize : out std_logic_vector(3-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awburst : out std_logic_vector(2-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awlock : out std_logic;                                                --! AXI4-Full Address Write signal.    
        s_axi_awcache : out std_logic_vector(4-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awprot : out std_logic_vector(3-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awqos : out std_logic_vector(4-1 downto 0);                            --! AXI4-Full Address Write signal.    
        s_axi_awregion : out std_logic_vector(4-1 downto 0);                        --! AXI4-Full Address Write signal.                    
        s_axi_awvalid : out std_logic;                                            --! AXI4-Full Address Write signal.
        s_axi_awready : in std_logic;                                                --! AXI4-Full Address Write signal.    
        s_axi_wdata : out std_logic_vector(axi_data_width-1 downto 0);                            --! AXI4-Full Write Data signal.
        s_axi_wstrb : out std_logic_vector(axi_data_width/8-1 downto 0);                            --! AXI4-Full Write Data signal.
        s_axi_wlast : out std_logic;                                                --! AXI4-Full Write Data signal.
        s_axi_wvalid : out std_logic;                                               --! AXI4-Full Write Data signal.
        s_axi_wready : in std_logic;                                                --! AXI4-Full Write Data signal.
        s_axi_bresp : in std_logic_vector(2-1 downto 0);                            --! AXI4-Full Write Response signal.
        s_axi_bvalid : in std_logic;                                               --! AXI4-Full Write Response signal.
        s_axi_bready : out std_logic;                                               --! AXI4-Full Write Response signal.
        -- Slave AXI4-Full Read interface.
        s_axi_araddr : out std_logic_vector(axi_address_width-1 downto 0);                            --! AXI4-Full Address Read signal.
        s_axi_arlen : out std_logic_vector(8-1 downto 0);                             --! AXI4-Full Address Read signal.
        s_axi_arsize : out std_logic_vector(3-1 downto 0);                           --! AXI4-Full Address Read signal.    
        s_axi_arburst : out std_logic_vector(2-1 downto 0);                            --! AXI4-Full Address Read signal.
        s_axi_arlock : out std_logic;                                               --! AXI4-Full Address Read signal.        
        s_axi_arcache : out std_logic_vector(4-1 downto 0);                           --! AXI4-Full Address Read signal.
        s_axi_arprot : out std_logic_vector(3-1 downto 0);                         --! AXI4-Full Address Read signal.    
        s_axi_arqos : out std_logic_vector(4-1 downto 0);                           --! AXI4-Full Address Read signal.
        s_axi_arregion : out std_logic_vector(4-1 downto 0);                        --! AXI4-Full Address Write signal.        
        s_axi_arvalid : out std_logic;                                          --! AXI4-Full Address Read signal.
        s_axi_arready : in std_logic;                                              --! AXI4-Full Address Read signal.
        s_axi_rdata : in std_logic_vector(axi_data_width-1 downto 0);                            --! AXI4-Full Read Data signal.
        s_axi_rresp : in std_logic_vector(2-1 downto 0);                            --! AXI4-Full Read Data signal.    
        s_axi_rlast : in std_logic;                                               --! AXI4-Full Read Data signal.
        s_axi_rvalid : in std_logic;                                               --! AXI4-Full Read Data signal.
        s_axi_rready : out std_logic_vector(1-1 downto 0);   
        -- Master AXI4-Lite Write interface.
        m_axi_awaddr : out std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Write signal.
        m_axi_awprot : out std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Write signal.
        m_axi_awvalid : out std_logic;                                                     --! AXI4-Lite Address Write signal.
        m_axi_awready : in std_logic;                                                    --! AXI4-Lite Address Write signal.
        m_axi_wvalid : out std_logic;                                                      --! AXI4-Lite Write Data signal.
        m_axi_wready : in std_logic;                                                     --! AXI4-Lite Write Data signal.
        m_axi_wdata : out std_logic_vector(axi_data_width-1 downto 0);                     --! AXI4-Lite Write Data signal.    
        m_axi_wstrb : out std_logic_vector(axi_data_width/8-1 downto 0);                   --! AXI4-Lite Write Data signal.
        m_axi_bvalid : in std_logic;                                                     --! AXI4-Lite Write Response signal.
        m_axi_bready : out std_logic;                                                      --! AXI4-Lite Write Response signal.
        m_axi_bresp : in std_logic_vector(1 downto 0);                     
        -- Master AXI4-Lite Read interface.
        m_axi_araddr : out std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Read signal.
        m_axi_arprot : out std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Read signal.
        m_axi_arvalid : out std_logic;                                                     --! AXI4-Lite Address Read signal.
        m_axi_arready : in std_logic;                                                    --! AXI4-Lite Address Read signal.
        m_axi_rdata : in std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');   --! AXI4-Lite Read Data signal.
        m_axi_rvalid : in std_logic;                                                     --! AXI4-Lite Read Data signal.
        m_axi_rready : out std_logic;                                                      --! AXI4-Lite Read Data signal.
        m_axi_rresp : in std_logic_vector(1 downto 0)                              
    );
end plasoc_axi4_full2lite;

architecture Behavioral of plasoc_axi4_full2lite is

begin


end Behavioral;
