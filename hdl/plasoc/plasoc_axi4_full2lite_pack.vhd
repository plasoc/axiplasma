----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2017 02:57:27 PM
-- Design Name: 
-- Module Name: plasoc_axi4_full2lite_pack - Behavioral
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


package plasoc_axi4_full2lite_pack is

    constant axi_burst_fixed : std_logic_vector := "00";
    constant axi_burst_incr : std_logic_vector := "01";
    
    component plasoc_axi4_full2lite is
        generic (
            axi_slave_id_width : integer := 1;
            axi_address_width : integer := 32;
            axi_data_width : integer := 32);
        port (
            -- Global interface.
            aclk : in std_logic;                                    --! Defines the AXI4-Lite Address Width.
            aresetn : in std_logic;                                 --! Reset on low.
            -- Slave AXI4-Full Write outterface.
            s_axi_awid : in std_logic_vector(axi_slave_id_width-1 downto 0);
            s_axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);                            --! AXI4-Full Address Write signal.
            s_axi_awlen : in std_logic_vector(8-1 downto 0);                            --! AXI4-Full Address Write signal.
            s_axi_awsize : in std_logic_vector(3-1 downto 0);                            --! AXI4-Full Address Write signal.
            s_axi_awburst : in std_logic_vector(2-1 downto 0);                            --! AXI4-Full Address Write signal.
            s_axi_awlock : in std_logic;                                                --! AXI4-Full Address Write signal.    
            s_axi_awcache : in std_logic_vector(4-1 downto 0);                            --! AXI4-Full Address Write signal.
            s_axi_awprot : in std_logic_vector(3-1 downto 0);                            --! AXI4-Full Address Write signal.
            s_axi_awqos : in std_logic_vector(4-1 downto 0);                            --! AXI4-Full Address Write signal.    
            s_axi_awregion : in std_logic_vector(4-1 downto 0);                        --! AXI4-Full Address Write signal.                    
            s_axi_awvalid : in std_logic;                                            --! AXI4-Full Address Write signal.
            s_axi_awready : out std_logic;                                                --! AXI4-Full Address Write signal.    
            s_axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);                            --! AXI4-Full Write Data signal.
            s_axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);                            --! AXI4-Full Write Data signal.
            s_axi_wlast : in std_logic;                                                --! AXI4-Full Write Data signal.
            s_axi_wvalid : in std_logic;                                               --! AXI4-Full Write Data signal.
            s_axi_wready : out std_logic;                                                --! AXI4-Full Write Data signal.
            s_axi_bid : out std_logic_vector(axi_slave_id_width-1 downto 0);
            s_axi_bresp : out std_logic_vector(2-1 downto 0);                            --! AXI4-Full Write Response signal.
            s_axi_bvalid : out std_logic;                                               --! AXI4-Full Write Response signal.
            s_axi_bready : in std_logic;                                               --! AXI4-Full Write Response signal.
            -- Slave AXI4-Full Read outterface.
            s_axi_arid : in std_logic_vector(axi_slave_id_width-1 downto 0);
            s_axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);                            --! AXI4-Full Address Read signal.
            s_axi_arlen : in std_logic_vector(8-1 downto 0);                             --! AXI4-Full Address Read signal.
            s_axi_arsize : in std_logic_vector(3-1 downto 0);                           --! AXI4-Full Address Read signal.    
            s_axi_arburst : in std_logic_vector(2-1 downto 0);                            --! AXI4-Full Address Read signal.
            s_axi_arlock : in std_logic;                                               --! AXI4-Full Address Read signal.        
            s_axi_arcache : in std_logic_vector(4-1 downto 0);                           --! AXI4-Full Address Read signal.
            s_axi_arprot : in std_logic_vector(3-1 downto 0);                         --! AXI4-Full Address Read signal.    
            s_axi_arqos : in std_logic_vector(4-1 downto 0);                           --! AXI4-Full Address Read signal.
            s_axi_arregion : in std_logic_vector(4-1 downto 0);                        --! AXI4-Full Address Write signal.        
            s_axi_arvalid : in std_logic;                                          --! AXI4-Full Address Read signal.
            s_axi_arready : out std_logic;                                              --! AXI4-Full Address Read signal.
            s_axi_rid : out std_logic_vector(axi_slave_id_width-1 downto 0);
            s_axi_rdata : out std_logic_vector(axi_data_width-1 downto 0);                            --! AXI4-Full Read Data signal.
            s_axi_rresp : out std_logic_vector(2-1 downto 0);                            --! AXI4-Full Read Data signal.    
            s_axi_rlast : out std_logic;                                               --! AXI4-Full Read Data signal.
            s_axi_rvalid : out std_logic;                                               --! AXI4-Full Read Data signal.
            s_axi_rready : in std_logic;   
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
    end component;
    
end package;