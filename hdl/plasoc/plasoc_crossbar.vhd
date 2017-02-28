
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.plasoc_crossbar_pack.all; 

entity plasoc_crossbar is
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
        
end plasoc_crossbar;

architecture Behavioral of plasoc_crossbar is

    constant axi_slave_iden_width : integer := clogb2(axi_slave_amount);
    constant axi_master_iden_width : integer := clogb2(axi_master_amount);
    constant axi_master_id_width : integer := axi_slave_iden_width+axi_slave_id_width;

    component plasoc_crossbar_base is
        generic (
            width : integer := 16;
            input_amount : integer := 2;
            output_amount : integer := 2);
        port (
            inputs : in std_logic_vector(width*input_amount-1 downto 0);
            enables : in std_logic_vector(input_amount*output_amount-1 downto 0);
            outputs : out std_logic_vector(width*output_amount-1 downto 0));
    end component;
    
    component plasoc_crossbar_axi4_write_cntrl is
        generic (
            axi_slave_amount : integer := 2;
            axi_master_amount : integer := 4);
        port (
        
            aclk : in std_logic;                                                    
            aresetn : in std_logic;
            
            axi_write_master_iden : in std_logic_vector(axi_slave_amount*clogb2(axi_master_amount)-1 downto 0);
            axi_write_slave_iden : in std_logic_vector(axi_master_amount*clogb2(axi_slave_amount)-1 downto 0);
            
            axi_address_write_enables : out std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
            axi_data_write_enables : out std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
            axi_response_write_enables : out std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);

            s_axi_awvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);
            s_axi_wvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);
            s_axi_wlast : in std_logic_vector(axi_slave_amount*1-1 downto 0);
            s_axi_bready : in std_logic_vector(axi_slave_amount*1-1 downto 0);
            m_axi_awready : in std_logic_vector(axi_master_amount*1-1 downto 0);
            m_axi_wready : in std_logic_vector(axi_master_amount*1-1 downto 0);
            m_axi_bvalid : in std_logic_vector(axi_master_amount*1-1 downto 0));
    end component;
    
    component plasoc_crossbar_axi4_read_cntrl is
        generic (
            axi_slave_amount : integer := 2;
            axi_master_amount : integer := 4);
        port (
               
            aclk : in std_logic;                                                    
            aresetn : in std_logic;
            
            axi_read_master_iden : in std_logic_vector(axi_slave_amount*clogb2(axi_master_amount)-1 downto 0);
            axi_read_slave_iden : in std_logic_vector(axi_master_amount*clogb2(axi_slave_amount)-1 downto 0);
            
            axi_address_read_enables : out std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
            axi_data_read_enables : out std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
            
            s_axi_arvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);
            s_axi_rready : in std_logic_vector(axi_slave_amount*1-1 downto 0);
            m_axi_arready : in std_logic_vector(axi_master_amount*1-1 downto 0);
            m_axi_rvalid : in std_logic_vector(axi_master_amount*1-1 downto 0);
            m_axi_rlast : in std_logic_vector(axi_master_amount*1-1 downto 0));
    end component;
    
    function set_crossbar_enables( enables : in std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0) ) return std_logic_vector is
        constant cross_enables_width : integer := axi_slave_amount*axi_master_amount;
        variable s2m_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
        variable m2s_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
        variable cross_enables : std_logic_vector(2*cross_enables_width-1 downto 0); 
    begin
        for each_slave in 0 to axi_slave_amount-1 loop
            for each_master in 0 to axi_master_amount-1 loop
                if enables(each_slave+each_master*axi_slave_amount)='1' then
                    s2m_enables(each_slave+each_master*axi_slave_amount) := '1';
                    m2s_enables(each_master+each_slave*axi_master_amount) := '1';
                else
                    s2m_enables(each_slave+each_master*axi_slave_amount) := '0';
                    m2s_enables(each_master+each_slave*axi_master_amount) := '0';
                end if;
            end loop;
        end loop;
        cross_enables(cross_enables_width-1 downto 0) := s2m_enables;
        cross_enables(2*cross_enables_width-1 downto cross_enables_width) := m2s_enables;
        return cross_enables;
    end;
    
    function set_connected( enables : in std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0) ) return std_logic_vector is
        constant connected_width : integer := axi_slave_amount+axi_master_amount; 
        variable slave_connected : std_logic_vector(axi_slave_amount-1 downto 0) := (others=>'0');
        variable master_connected : std_logic_vector(axi_master_amount-1 downto 0) := (others=>'0');
        variable or_reduced : Boolean;
        variable connected : std_logic_vector(connected_width-1 downto 0);
    begin
        for each_slave in 0 to axi_slave_amount-1 loop
            or_reduced := False;
            for each_master in 0 to axi_master_amount-1 loop
                or_reduced := or_reduced or (enables(each_slave+each_master*axi_slave_amount)='1');
            end loop;
            if or_reduced then
                slave_connected(each_slave) := '1';
            end if;
        end loop;
        for each_master in 0 to axi_master_amount-1 loop
            or_reduced := False;
            for each_slave in 0 to axi_slave_amount-1 loop
                or_reduced := or_reduced or (enables(each_slave+each_master*axi_slave_amount)='1');
            end loop;
            if or_reduced then
                master_connected(each_master) := '1';
            end if;
        end loop;
        connected(axi_slave_amount-1 downto 0) := slave_connected;
        connected(connected_width-1 downto axi_slave_amount) := master_connected;
        return connected;
    end;
    
    function decode_master_iden ( 
        address : in std_logic_vector(axi_slave_amount*axi_address_width-1 downto 0);
        base_addresses : in std_logic_vector(axi_master_amount*axi_address_width-1 downto 0);
        high_addresses : in std_logic_vector(axi_master_amount*axi_address_width-1 downto 0)) 
        return std_logic_vector is
        variable master_iden_buff : std_logic_vector(axi_slave_amount*axi_master_iden_width-1 downto 0) := (others=>'0');
        variable slave_address : std_logic_vector(axi_address_width-1 downto 0);
        variable master_base_address : std_logic_vector(axi_address_width-1 downto 0);
        variable master_high_address : std_logic_vector(axi_address_width-1 downto 0);
    begin
        for each_slave in 0 to axi_slave_amount-1 loop
            slave_address := address((1+each_slave)*axi_address_width-1 downto each_slave*axi_address_width);
            for each_master in 0 to axi_master_amount-1 loop
                master_base_address := base_addresses((1+each_master)*axi_address_width-1 downto each_master*axi_address_width);
                master_high_address := high_addresses((1+each_master)*axi_address_width-1 downto each_master*axi_address_width);
                if slave_address>=master_base_address and slave_address<=master_high_address then
                    master_iden_buff((1+each_slave)*axi_master_iden_width-1 downto each_slave*axi_master_iden_width) :=
                        std_logic_vector(to_unsigned(each_master,axi_master_iden_width));
                end if;
            end loop;
        end loop;
        return master_iden_buff;
    end;
    
    signal axi_read_slave_iden : std_logic_vector(axi_master_amount*axi_slave_iden_width-1 downto 0);
    signal axi_write_slave_iden : std_logic_vector(axi_master_amount*axi_slave_iden_width-1 downto 0);
    signal axi_read_master_iden : std_logic_vector(axi_slave_amount*axi_master_iden_width-1 downto 0);
    signal axi_write_master_iden : std_logic_vector(axi_slave_amount*axi_master_iden_width-1 downto 0);
    
    signal s_axi_awid_full : std_logic_vector(axi_slave_amount*axi_master_id_width-1 downto 0);
    signal s_axi_arid_full : std_logic_vector(axi_slave_amount*axi_master_id_width-1 downto 0);
    signal m_axi_rid_from_slave : std_logic_vector(axi_master_amount*axi_slave_id_width-1 downto 0);
    signal m_axi_bid_from_slave : std_logic_vector(axi_master_amount*axi_slave_id_width-1 downto 0);
    
    signal axi_address_write_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
    signal axi_address_s2m_write_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0); 
    signal axi_address_m2s_write_enables : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0);
    signal axi_data_write_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0); 
    signal axi_data_s2m_write_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0); 
    signal axi_data_m2s_write_enables : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0);
    signal axi_response_write_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
    signal axi_response_s2m_write_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0); 
    signal axi_response_m2s_write_enables : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0);
    signal axi_address_read_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
    signal axi_address_s2m_read_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0); 
    signal axi_address_m2s_read_enables : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0); 
    signal axi_data_read_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
    signal axi_data_s2m_read_enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0); 
    signal axi_data_m2s_read_enables : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0);
    
    signal s_address_write_connected_buff : std_logic_vector(axi_slave_amount-1 downto 0);
    signal s_data_write_connected_buff : std_logic_vector(axi_slave_amount-1 downto 0);
    signal s_response_write_connected_buff : std_logic_vector(axi_slave_amount-1 downto 0);
    signal s_address_read_connected_buff : std_logic_vector(axi_slave_amount-1 downto 0);
    signal s_data_read_connected_buff : std_logic_vector(axi_slave_amount-1 downto 0);     
    signal m_address_write_connected_buff : std_logic_vector(axi_master_amount-1 downto 0);
    signal m_data_write_connected_buff : std_logic_vector(axi_master_amount-1 downto 0);
    signal m_response_write_connected_buff : std_logic_vector(axi_master_amount-1 downto 0);
    signal m_address_read_connected_buff : std_logic_vector(axi_master_amount-1 downto 0);
    signal m_data_read_connected_buff : std_logic_vector(axi_master_amount-1 downto 0);   
    
begin

    s_address_write_connected <= s_address_write_connected_buff;
    s_data_write_connected <= s_data_write_connected_buff;
    s_response_write_connected <= s_response_write_connected_buff;
    s_address_read_connected <= s_address_read_connected_buff;
    s_data_read_connected <= s_data_read_connected_buff;
    
    m_address_write_connected <= m_address_write_connected_buff;
    m_data_write_connected <= m_data_write_connected_buff;
    m_response_write_connected <= m_response_write_connected_buff;
    m_address_read_connected <= m_address_read_connected_buff;
    m_data_read_connected <= m_data_read_connected_buff;
    
    plasoc_crossbar_axi4_write_cntrl_inst : plasoc_crossbar_axi4_write_cntrl
        generic map (
            axi_slave_amount => axi_slave_amount,
            axi_master_amount => axi_master_amount)
        port map (
            aclk => aclk,
            aresetn => aresetn,
            axi_write_master_iden => axi_write_master_iden,
            axi_write_slave_iden => axi_write_slave_iden,
            axi_address_write_enables => axi_address_write_enables,
            axi_data_write_enables => axi_data_write_enables,
            axi_response_write_enables => axi_response_write_enables,
            s_axi_awvalid => s_axi_awvalid,
            s_axi_wvalid => s_axi_wvalid,
            s_axi_wlast => s_axi_wlast,
            s_axi_bready => s_axi_bready,
            m_axi_awready => m_axi_awready,
            m_axi_wready => m_axi_wready,
            m_axi_bvalid => m_axi_bvalid);
   
    plasoc_crossbar_axi4_read_cntrl_inst : plasoc_crossbar_axi4_read_cntrl
        generic map (
            axi_slave_amount => axi_slave_amount,
            axi_master_amount => axi_master_amount)
        port map (
            aclk => aclk,
            aresetn => aresetn,
            axi_read_master_iden => axi_read_master_iden,
            axi_read_slave_iden => axi_read_slave_iden,
            axi_address_read_enables => axi_address_read_enables,
            axi_data_read_enables => axi_data_read_enables,
            s_axi_arvalid => s_axi_arvalid,
            s_axi_rready => s_axi_rready,
            m_axi_arready => m_axi_arready,
            m_axi_rvalid => m_axi_rvalid,
            m_axi_rlast => m_axi_rlast);

    generate_slave_idassigns:
    for each_slave in 0 to axi_slave_amount-1 generate
        s_axi_awid_full((1+each_slave)*axi_master_id_width-1 downto (1+each_slave)*axi_master_id_width-axi_slave_iden_width) <=
            std_logic_vector(to_unsigned(each_slave,axi_slave_iden_width));
        s_axi_awid_full(axi_slave_id_width-1+each_slave*axi_master_id_width downto 0+each_slave*axi_master_id_width) <=
            s_axi_awid((1+each_slave)*axi_slave_id_width-1 downto 0+each_slave*axi_slave_id_width);
        s_axi_arid_full((1+each_slave)*axi_master_id_width-1 downto (1+each_slave)*axi_master_id_width-axi_slave_iden_width) <=
            std_logic_vector(to_unsigned(each_slave,axi_slave_iden_width));
        s_axi_arid_full(axi_slave_id_width-1+each_slave*axi_master_id_width downto 0+each_slave*axi_master_id_width) <=
            s_axi_arid((1+each_slave)*axi_slave_id_width-1 downto 0+each_slave*axi_slave_id_width);
    end generate generate_slave_idassigns;

    generate_master_idassigns:
    for each_master in 0 to axi_master_amount-1 generate     
        axi_read_slave_iden((1+each_master)*axi_slave_iden_width-1 downto each_master*axi_slave_iden_width) <=
            m_axi_rid((1+each_master)*axi_master_id_width-1 downto (1+each_master)*axi_master_id_width-axi_slave_iden_width);
        m_axi_rid_from_slave((1+each_master)*axi_slave_id_width-1 downto each_master*axi_slave_id_width) <= 
            m_axi_rid(axi_slave_id_width-1+each_master*axi_master_id_width downto 0+each_master*axi_master_id_width);
        axi_write_slave_iden((1+each_master)*axi_slave_iden_width-1 downto each_master*axi_slave_iden_width) <=
            m_axi_bid((1+each_master)*axi_master_id_width-1 downto (1+each_master)*axi_master_id_width-axi_slave_iden_width);
        m_axi_bid_from_slave((1+each_master)*axi_slave_id_width-1 downto each_master*axi_slave_id_width) <= 
            m_axi_bid(axi_slave_id_width-1+each_master*axi_master_id_width downto 0+each_master*axi_master_id_width);
    end generate generate_master_idassigns;
    
    process (s_axi_awaddr)
    begin
        axi_write_master_iden <= decode_master_iden(s_axi_awaddr,axi_master_base_address,axi_master_high_address);
    end process;
    process (s_axi_araddr)
    begin
        axi_read_master_iden <= decode_master_iden(s_axi_araddr,axi_master_base_address,axi_master_high_address);
    end process;

    process (axi_address_write_enables)
        constant connected_width : integer := axi_slave_amount+axi_master_amount; 
        variable connected : std_logic_vector(connected_width-1 downto 0);
    begin
        connected := set_connected(axi_address_write_enables);
        s_address_write_connected_buff <= connected(axi_slave_amount-1 downto 0);
        m_address_write_connected_buff <= connected(connected_width-1 downto axi_slave_amount);
    end process;
    process (axi_data_write_enables)
        constant connected_width : integer := axi_slave_amount+axi_master_amount; 
        variable connected : std_logic_vector(connected_width-1 downto 0);
    begin
        connected := set_connected(axi_data_write_enables);
        s_data_write_connected_buff <= connected(axi_slave_amount-1 downto 0);
        m_data_write_connected_buff <= connected(connected_width-1 downto axi_slave_amount);
    end process;
    process (axi_response_write_enables)
        constant connected_width : integer := axi_slave_amount+axi_master_amount; 
        variable connected : std_logic_vector(connected_width-1 downto 0);
    begin
        connected := set_connected(axi_response_write_enables);
        s_response_write_connected_buff <= connected(axi_slave_amount-1 downto 0);
        m_response_write_connected_buff <= connected(connected_width-1 downto axi_slave_amount);
    end process;
    process (axi_address_read_enables)
        constant connected_width : integer := axi_slave_amount+axi_master_amount; 
        variable connected : std_logic_vector(connected_width-1 downto 0);
    begin
        connected := set_connected(axi_address_read_enables);
        s_address_read_connected_buff <= connected(axi_slave_amount-1 downto 0);
        m_address_read_connected_buff <= connected(connected_width-1 downto axi_slave_amount);
    end process;
    process (axi_data_read_enables)
        constant connected_width : integer := axi_slave_amount+axi_master_amount; 
        variable connected : std_logic_vector(connected_width-1 downto 0);
    begin
        connected := set_connected(axi_data_read_enables);
        s_data_read_connected_buff <= connected(axi_slave_amount-1 downto 0);
        m_data_read_connected_buff <= connected(connected_width-1 downto axi_slave_amount);
    end process;

    process (axi_address_write_enables)
        constant cross_enables_width : integer := axi_slave_amount*axi_master_amount;
        variable cross_enables : std_logic_vector(2*cross_enables_width-1 downto 0);
    begin
        cross_enables := set_crossbar_enables(axi_address_write_enables);
        axi_address_s2m_write_enables <= cross_enables(cross_enables_width-1 downto 0);
        axi_address_m2s_write_enables <= cross_enables(2*cross_enables_width-1 downto cross_enables_width);
    end process;
    process (axi_data_write_enables)
        constant cross_enables_width : integer := axi_slave_amount*axi_master_amount;
        variable cross_enables : std_logic_vector(2*cross_enables_width-1 downto 0);
    begin
        cross_enables := set_crossbar_enables(axi_data_write_enables);
        axi_data_s2m_write_enables <= cross_enables(cross_enables_width-1 downto 0);
        axi_data_m2s_write_enables <= cross_enables(2*cross_enables_width-1 downto cross_enables_width);
    end process;
    process (axi_response_write_enables)
        constant cross_enables_width : integer := axi_slave_amount*axi_master_amount;
        variable cross_enables : std_logic_vector(2*cross_enables_width-1 downto 0);
    begin
        cross_enables := set_crossbar_enables(axi_response_write_enables);
        axi_response_s2m_write_enables <= cross_enables(cross_enables_width-1 downto 0);
        axi_response_m2s_write_enables <= cross_enables(2*cross_enables_width-1 downto cross_enables_width);
    end process;
    process (axi_address_read_enables)
        constant cross_enables_width : integer := axi_slave_amount*axi_master_amount;
        variable cross_enables : std_logic_vector(2*cross_enables_width-1 downto 0);
    begin
        cross_enables := set_crossbar_enables(axi_address_read_enables);
        axi_address_s2m_read_enables <= cross_enables(cross_enables_width-1 downto 0);
        axi_address_m2s_read_enables <= cross_enables(2*cross_enables_width-1 downto cross_enables_width);
    end process;
    process (axi_data_read_enables)
        constant cross_enables_width : integer := axi_slave_amount*axi_master_amount;
        variable cross_enables : std_logic_vector(2*cross_enables_width-1 downto 0);
    begin
        cross_enables := set_crossbar_enables(axi_data_read_enables);
        axi_data_s2m_read_enables <= cross_enables(cross_enables_width-1 downto 0);
        axi_data_m2s_read_enables <= cross_enables(2*cross_enables_width-1 downto cross_enables_width);
    end process;

    awid_cross_inst : plasoc_crossbar_base 
        generic map (width => axi_master_id_width,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_awid_full,enables => axi_address_s2m_write_enables,outputs => m_axi_awid);
    awaddr_cross_inst : plasoc_crossbar_base
        generic map (width => axi_address_width,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_awaddr,enables => axi_address_s2m_write_enables,outputs => m_axi_awaddr);
    awlen_cross_inst : plasoc_crossbar_base
        generic map (width => 8,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_awlen,enables => axi_address_s2m_write_enables,outputs => m_axi_awlen);
    awsize_cross_inst : plasoc_crossbar_base
        generic map (width => 3,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_awsize,enables => axi_address_s2m_write_enables,outputs => m_axi_awsize);
    awburst_cross_inst : plasoc_crossbar_base
        generic map (width => 2,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_awburst,enables => axi_address_s2m_write_enables,outputs => m_axi_awburst);
    awlock_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_awlock,enables => axi_address_s2m_write_enables,outputs => m_axi_awlock);
    awcache_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_awcache,enables => axi_address_s2m_write_enables,outputs => m_axi_awcache);
    awprot_cross_inst : plasoc_crossbar_base
        generic map (width => 3,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_awprot,enables => axi_address_s2m_write_enables,outputs => m_axi_awprot);
    awqos_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_awqos,enables => axi_address_s2m_write_enables,outputs => m_axi_awqos);
    awregion_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_awregion,enables => axi_address_s2m_write_enables,outputs => m_axi_awregion);
    awvalid_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_awvalid,enables => axi_address_s2m_write_enables,outputs => m_axi_awvalid);
    awready_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_awready,enables => axi_address_m2s_write_enables,outputs => s_axi_awready);
        
    wdata_cross_inst : plasoc_crossbar_base
        generic map (width => axi_data_width,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_wdata,enables => axi_data_s2m_write_enables,outputs => m_axi_wdata);
    wstrb_cross_inst : plasoc_crossbar_base
        generic map (width => axi_data_width/8,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_wstrb,enables => axi_data_s2m_write_enables,outputs => m_axi_wstrb);
    wlast_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_wlast,enables => axi_data_s2m_write_enables,outputs => m_axi_wlast);
    wvalid_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_wvalid,enables => axi_data_s2m_write_enables,outputs => m_axi_wvalid);
    wready_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_wready,enables => axi_data_m2s_write_enables,outputs => s_axi_wready);
        
    bid_cross_inst : plasoc_crossbar_base
        generic map (width => axi_slave_id_width,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_bid_from_slave,enables => axi_response_m2s_write_enables,outputs => s_axi_bid);
    bresp_cross_inst : plasoc_crossbar_base
        generic map (width => 2,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_bresp,enables => axi_response_m2s_write_enables,outputs => s_axi_bresp);
    bvalid_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_bvalid,enables => axi_response_m2s_write_enables,outputs => s_axi_bvalid); 
    bready_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_bready,enables => axi_response_s2m_write_enables,outputs => m_axi_bready);

    arid_cross_inst : plasoc_crossbar_base 
        generic map (width => axi_master_id_width,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_arid_full,enables => axi_address_s2m_read_enables,outputs => m_axi_arid);
    araddr_cross_inst : plasoc_crossbar_base
        generic map (width => axi_address_width,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_araddr,enables => axi_address_s2m_read_enables,outputs => m_axi_araddr);
    arlen_cross_inst : plasoc_crossbar_base
        generic map (width => 8,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_arlen,enables => axi_address_s2m_read_enables,outputs => m_axi_arlen);
    arsize_cross_inst : plasoc_crossbar_base
        generic map (width => 3,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_arsize,enables => axi_address_s2m_read_enables,outputs => m_axi_arsize);
    arburst_cross_inst : plasoc_crossbar_base
        generic map (width => 2,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_arburst,enables => axi_address_s2m_read_enables,outputs => m_axi_arburst);
    arlock_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_arlock,enables => axi_address_s2m_read_enables,outputs => m_axi_arlock);
    arcache_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_arcache,enables => axi_address_s2m_read_enables,outputs => m_axi_arcache);
    arprot_cross_inst : plasoc_crossbar_base
        generic map (width => 3,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_arprot,enables => axi_address_s2m_read_enables,outputs => m_axi_arprot);
    arqos_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_arqos,enables => axi_address_s2m_read_enables,outputs => m_axi_arqos);
    arregion_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_arregion,enables => axi_address_s2m_read_enables,outputs => m_axi_arregion);
    arvalid_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_arvalid,enables => axi_address_s2m_read_enables,outputs => m_axi_arvalid);
    arready_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_arready,enables => axi_address_m2s_read_enables,outputs => s_axi_arready);

    rid_cross_inst : plasoc_crossbar_base
        generic map (width => axi_slave_id_width,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_rid_from_slave,enables => axi_data_m2s_read_enables,outputs => s_axi_rid);
    rdata_cross_inst : plasoc_crossbar_base
        generic map (width => axi_data_width,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_rdata,enables => axi_data_m2s_read_enables,outputs => s_axi_rdata);
    rresp_cross_inst : plasoc_crossbar_base
        generic map (width => 2,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_rresp,enables => axi_data_m2s_read_enables,outputs => s_axi_rresp);
    rlast_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_rlast,enables => axi_data_m2s_read_enables,outputs => s_axi_rlast);
    rvalid_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_rvalid,enables => axi_data_m2s_read_enables,outputs => s_axi_rvalid); 
    rready_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map (inputs => s_axi_rready,enables => axi_data_s2m_read_enables,outputs => m_axi_rready);

end Behavioral;
