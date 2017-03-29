-------------------------------------------------------
--! @author Andrew Powell
--! @date March 17, 2017
--! @brief Contains the package and component declaration of the 
--! Plasma-SoC's Crossbar Core. Please refer to the documentation
--! in plasoc_crossbar.vhd for more information. Also, keep
--! in mind that this core should not be utilized directly.
--! Instead, a wrapper should be generated from gencross.py.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package plasoc_crossbar_pack is

    function clogb2(bit_depth : in integer ) return integer;

    component plasoc_crossbar is
        generic (
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            axi_master_amount : integer := 2;
            axi_slave_id_width : integer := 2;
            axi_slave_amount : integer := 4;
            axi_master_base_address : std_logic_vector := X"4000000000000000";
            axi_master_high_address : std_logic_vector := X"ffffffff3fffffff"
        );
        port (
            aclk : in std_logic;                                                    
            aresetn : in std_logic;      
            
            s_address_write_connected : out std_logic_vector(axi_slave_amount-1 downto 0);
            s_data_write_connected : out std_logic_vector(axi_slave_amount-1 downto 0);
            s_response_write_connected : out std_logic_vector(axi_slave_amount-1 downto 0);
            s_address_read_connected : out std_logic_vector(axi_slave_amount-1 downto 0);
            s_data_read_connected : out std_logic_vector(axi_slave_amount-1 downto 0);     
            
            m_address_write_connected : out std_logic_vector(axi_master_amount-1 downto 0);
            m_data_write_connected : out std_logic_vector(axi_master_amount-1 downto 0);
            m_response_write_connected : out std_logic_vector(axi_master_amount-1 downto 0);
            m_address_read_connected : out std_logic_vector(axi_master_amount-1 downto 0);
            m_data_read_connected : out std_logic_vector(axi_master_amount-1 downto 0);        
                                              
            s_axi_awid : in std_logic_vector(axi_slave_amount*axi_slave_id_width-1 downto 0);                                           
            s_axi_awaddr : in std_logic_vector(axi_slave_amount*axi_address_width-1 downto 0);                            
            s_axi_awlen : in std_logic_vector(axi_slave_amount*8-1 downto 0);                            
            s_axi_awsize : in std_logic_vector(axi_slave_amount*3-1 downto 0);                            
            s_axi_awburst : in std_logic_vector(axi_slave_amount*2-1 downto 0);                            
            s_axi_awlock : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                                
            s_axi_awcache : in std_logic_vector(axi_slave_amount*4-1 downto 0);                            
            s_axi_awprot : in std_logic_vector(axi_slave_amount*3-1 downto 0);                            
            s_axi_awqos : in std_logic_vector(axi_slave_amount*4-1 downto 0);                            
            s_axi_awregion : in std_logic_vector(axi_slave_amount*4-1 downto 0);                        
            s_axi_awvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                            
            s_axi_awready : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                                
            s_axi_wdata : in std_logic_vector(axi_slave_amount*axi_data_width-1 downto 0);                            
            s_axi_wstrb : in std_logic_vector(axi_slave_amount*axi_data_width/8-1 downto 0);                            
            s_axi_wlast : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                                
            s_axi_wvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                               
            s_axi_wready : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                                
            s_axi_bid : out std_logic_vector(axi_slave_amount*axi_slave_id_width-1 downto 0);                                
            s_axi_bresp : out std_logic_vector(axi_slave_amount*2-1 downto 0);                            
            s_axi_bvalid : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                               
            s_axi_bready : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                               
            s_axi_arid : in std_logic_vector(axi_slave_amount*axi_slave_id_width-1 downto 0);                              
            s_axi_araddr : in std_logic_vector(axi_slave_amount*axi_address_width-1 downto 0);                            
            s_axi_arlen : in std_logic_vector(axi_slave_amount*8-1 downto 0);                             
            s_axi_arsize : in std_logic_vector(axi_slave_amount*3-1 downto 0);                           
            s_axi_arburst : in std_logic_vector(axi_slave_amount*2-1 downto 0);                            
            s_axi_arlock : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                               
            s_axi_arcache : in std_logic_vector(axi_slave_amount*4-1 downto 0);                           
            s_axi_arprot : in std_logic_vector(axi_slave_amount*3-1 downto 0);                         
            s_axi_arqos : in std_logic_vector(axi_slave_amount*4-1 downto 0);                           
            s_axi_arregion : in std_logic_vector(axi_slave_amount*4-1 downto 0);                        
            s_axi_arvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                          
            s_axi_arready : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                              
            s_axi_rid : out std_logic_vector(axi_slave_amount*axi_slave_id_width-1 downto 0);                                
            s_axi_rdata : out std_logic_vector(axi_slave_amount*axi_data_width-1 downto 0);                            
            s_axi_rresp : out std_logic_vector(axi_slave_amount*2-1 downto 0);                            
            s_axi_rlast : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                               
            s_axi_rvalid : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                               
            s_axi_rready : in std_logic_vector(axi_slave_amount*1-1 downto 0);
            
            m_axi_awid : out std_logic_vector(axi_master_amount*(clogb2(axi_slave_amount)+axi_slave_id_width)-1 downto 0);                            
            m_axi_awaddr : out std_logic_vector(axi_master_amount*axi_address_width-1 downto 0);                            
            m_axi_awlen : out std_logic_vector(axi_master_amount*8-1 downto 0);                            
            m_axi_awsize : out std_logic_vector(axi_master_amount*3-1 downto 0);                            
            m_axi_awburst : out std_logic_vector(axi_master_amount*2-1 downto 0);                            
            m_axi_awlock : out std_logic_vector(axi_master_amount*1-1 downto 0);                                                
            m_axi_awcache : out std_logic_vector(axi_master_amount*4-1 downto 0);                            
            m_axi_awprot : out std_logic_vector(axi_master_amount*3-1 downto 0);                            
            m_axi_awqos : out std_logic_vector(axi_master_amount*4-1 downto 0);                            
            m_axi_awregion : out std_logic_vector(axi_master_amount*4-1 downto 0);                        
            m_axi_awvalid : out std_logic_vector(axi_master_amount*1-1 downto 0);                                            
            m_axi_awready : in std_logic_vector(axi_master_amount*1-1 downto 0);                                                
            m_axi_wdata : out std_logic_vector(axi_master_amount*axi_data_width-1 downto 0);                            
            m_axi_wstrb : out std_logic_vector(axi_master_amount*axi_data_width/8-1 downto 0);                            
            m_axi_wlast : out std_logic_vector(axi_master_amount*1-1 downto 0);                                                
            m_axi_wvalid : out std_logic_vector(axi_master_amount*1-1 downto 0);                                               
            m_axi_wready : in std_logic_vector(axi_master_amount*1-1 downto 0);                                                
            m_axi_bid : in std_logic_vector(axi_master_amount*(clogb2(axi_slave_amount)+axi_slave_id_width)-1 downto 0);                                
            m_axi_bresp : in std_logic_vector(axi_master_amount*2-1 downto 0);                            
            m_axi_bvalid : in std_logic_vector(axi_master_amount*1-1 downto 0);                                               
            m_axi_bready : out std_logic_vector(axi_master_amount*1-1 downto 0);                                                     
            m_axi_arid : out std_logic_vector(axi_master_amount*(clogb2(axi_slave_amount)+axi_slave_id_width)-1 downto 0);                              
            m_axi_araddr : out std_logic_vector(axi_master_amount*axi_address_width-1 downto 0);                            
            m_axi_arlen : out std_logic_vector(axi_master_amount*8-1 downto 0);                             
            m_axi_arsize : out std_logic_vector(axi_master_amount*3-1 downto 0);                           
            m_axi_arburst : out std_logic_vector(axi_master_amount*2-1 downto 0);                            
            m_axi_arlock : out std_logic_vector(axi_master_amount*1-1 downto 0);                                               
            m_axi_arcache : out std_logic_vector(axi_master_amount*4-1 downto 0);                           
            m_axi_arprot : out std_logic_vector(axi_master_amount*3-1 downto 0);                         
            m_axi_arqos : out std_logic_vector(axi_master_amount*4-1 downto 0);                           
            m_axi_arregion : out std_logic_vector(axi_master_amount*4-1 downto 0);                        
            m_axi_arvalid : out std_logic_vector(axi_master_amount*1-1 downto 0);                                          
            m_axi_arready : in std_logic_vector(axi_master_amount*1-1 downto 0);                                              
            m_axi_rid : in std_logic_vector(axi_master_amount*(clogb2(axi_slave_amount)+axi_slave_id_width)-1 downto 0);                                
            m_axi_rdata : in std_logic_vector(axi_master_amount*axi_data_width-1 downto 0);                            
            m_axi_rresp : in std_logic_vector(axi_master_amount*2-1 downto 0);                            
            m_axi_rlast : in std_logic_vector(axi_master_amount*1-1 downto 0);                                               
            m_axi_rvalid : in std_logic_vector(axi_master_amount*1-1 downto 0);                                               
            m_axi_rready : out std_logic_vector(axi_master_amount*1-1 downto 0));
            
    end component;

end package;

package body plasoc_crossbar_pack is

    function flogb2(bit_depth : in natural ) return integer is
		variable result : integer := 0;
		variable bit_depth_buff : integer := bit_depth;
	begin
		while bit_depth_buff>1 loop
			bit_depth_buff := bit_depth_buff/2;
			result := result+1;
		end loop; 
		return result;
	end function flogb2; 
	
	function clogb2 (bit_depth : in natural ) return natural is
		variable result : integer := 0;
	begin
		result := flogb2(bit_depth);
		if (bit_depth > (2**result)) then
			return(result + 1);
		else
			return result;
		end if;
	end function clogb2;
	
end;