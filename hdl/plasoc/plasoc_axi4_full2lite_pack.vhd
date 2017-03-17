-------------------------------------------------------
--! @author Andrew Powell
--! @date March 17, 2017
--! @brief Contains the package and component declaration of the 
--! Plasma-SoC's Full2Lite Core. Please refer to the documentation
--! in plasoc_axi4_full2lite.vhd for more information.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package plasoc_axi4_full2lite_pack is

    constant axi_burst_fixed : std_logic_vector := "00";
    constant axi_burst_incr : std_logic_vector := "01";
    
    component plasoc_axi4_full2lite is
        generic (
            axi_slave_id_width : integer := 1;
            axi_address_width : integer := 32;
            axi_data_width : integer := 32);
        port (
            
            aclk : in std_logic;                                    
            aresetn : in std_logic;                                 
            
            s_axi_awid : in std_logic_vector(axi_slave_id_width-1 downto 0);
            s_axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);                            
            s_axi_awlen : in std_logic_vector(8-1 downto 0);                            
            s_axi_awsize : in std_logic_vector(3-1 downto 0);                            
            s_axi_awburst : in std_logic_vector(2-1 downto 0);                            
            s_axi_awlock : in std_logic;                                                
            s_axi_awcache : in std_logic_vector(4-1 downto 0);                            
            s_axi_awprot : in std_logic_vector(3-1 downto 0);                            
            s_axi_awqos : in std_logic_vector(4-1 downto 0);                            
            s_axi_awregion : in std_logic_vector(4-1 downto 0);                        
            s_axi_awvalid : in std_logic;                                            
            s_axi_awready : out std_logic;                                                
            s_axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);                            
            s_axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);                            
            s_axi_wlast : in std_logic;                                                
            s_axi_wvalid : in std_logic;                                               
            s_axi_wready : out std_logic;                                                
            s_axi_bid : out std_logic_vector(axi_slave_id_width-1 downto 0);
            s_axi_bresp : out std_logic_vector(2-1 downto 0);                            
            s_axi_bvalid : out std_logic;                                               
            s_axi_bready : in std_logic;                                               
            
            s_axi_arid : in std_logic_vector(axi_slave_id_width-1 downto 0);
            s_axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);                            
            s_axi_arlen : in std_logic_vector(8-1 downto 0);                             
            s_axi_arsize : in std_logic_vector(3-1 downto 0);                           
            s_axi_arburst : in std_logic_vector(2-1 downto 0);                            
            s_axi_arlock : in std_logic;                                               
            s_axi_arcache : in std_logic_vector(4-1 downto 0);                           
            s_axi_arprot : in std_logic_vector(3-1 downto 0);                         
            s_axi_arqos : in std_logic_vector(4-1 downto 0);                           
            s_axi_arregion : in std_logic_vector(4-1 downto 0);                        
            s_axi_arvalid : in std_logic;                                          
            s_axi_arready : out std_logic;                                              
            s_axi_rid : out std_logic_vector(axi_slave_id_width-1 downto 0);
            s_axi_rdata : out std_logic_vector(axi_data_width-1 downto 0);                            
            s_axi_rresp : out std_logic_vector(2-1 downto 0);                            
            s_axi_rlast : out std_logic;                                               
            s_axi_rvalid : out std_logic;                                               
            s_axi_rready : in std_logic;   
            
            m_axi_awaddr : out std_logic_vector(axi_address_width-1 downto 0);                 
            m_axi_awprot : out std_logic_vector(2 downto 0);                                   
            m_axi_awvalid : out std_logic;                                                     
            m_axi_awready : in std_logic;                                                    
            m_axi_wvalid : out std_logic;                                                      
            m_axi_wready : in std_logic;                                                     
            m_axi_wdata : out std_logic_vector(axi_data_width-1 downto 0);                     
            m_axi_wstrb : out std_logic_vector(axi_data_width/8-1 downto 0);                   
            m_axi_bvalid : in std_logic;                                                     
            m_axi_bready : out std_logic;                                                      
            m_axi_bresp : in std_logic_vector(1 downto 0);                     
            
            m_axi_araddr : out std_logic_vector(axi_address_width-1 downto 0);                 
            m_axi_arprot : out std_logic_vector(2 downto 0);                                   
            m_axi_arvalid : out std_logic;                                                     
            m_axi_arready : in std_logic;                                                    
            m_axi_rdata : in std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');   
            m_axi_rvalid : in std_logic;                                                     
            m_axi_rready : out std_logic;                                                      
            m_axi_rresp : in std_logic_vector(1 downto 0)                              
        );
    end component;
    
end package;