
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.plasoc_crossbar_pack.all;

entity plasoc_crossbar is
    generic (
        axi_address_width : integer := 32;
        axi_data_width : integer := 32;
        axi_master_amount : integer := 2;
        axi_master_id_width : integer := 2;
        axi_slave_amount : integer := 2
    );
    port (
        -- Global interface.
        aclk : in std_logic;                                                    --! Clock. Tested with 50 MHz.
        aresetn : in std_logic;                                                --! Reset on low.
        -- Master AXI4-Full Write interfaces.
        m_axi_awid : in std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);                            --! AXI4-Full Address Write signal.
        m_axi_awaddr : in std_logic_vector(axi_master_amount*axi_address_width-1 downto 0);                            --! AXI4-Full Address Write signal.
        m_axi_awlen : in std_logic_vector(axi_master_amount*8-1 downto 0);                            --! AXI4-Full Address Write signal.
        m_axi_awsize : in std_logic_vector(axi_master_amount*3-1 downto 0);                            --! AXI4-Full Address Write signal.
        m_axi_awburst : in std_logic_vector(axi_master_amount*2-1 downto 0);                            --! AXI4-Full Address Write signal.
        m_axi_awlock : in std_logic_vector(axi_master_amount*1-1 downto 0);                                                --! AXI4-Full Address Write signal.    
        m_axi_awcache : in std_logic_vector(axi_master_amount*4-1 downto 0);                            --! AXI4-Full Address Write signal.
        m_axi_awprot : in std_logic_vector(axi_master_amount*3-1 downto 0);                            --! AXI4-Full Address Write signal.
        m_axi_awqos : in std_logic_vector(axi_master_amount*4-1 downto 0);                            --! AXI4-Full Address Write signal.    
        m_axi_awregion : in std_logic_vector(axi_master_amount*4-1 downto 0);                        --! AXI4-Full Address Write signal.                    
        m_axi_awvalid : in std_logic_vector(axi_master_amount*1-1 downto 0);                                            --! AXI4-Full Address Write signal.
        m_axi_awready : out std_logic_vector(axi_master_amount*1-1 downto 0);                                                --! AXI4-Full Address Write signal.    
        m_axi_wdata : in std_logic_vector(axi_master_amount*axi_data_width-1 downto 0);                            --! AXI4-Full Write Data signal.
        m_axi_wstrb : in std_logic_vector(axi_master_amount*axi_data_width/8-1 downto 0);                            --! AXI4-Full Write Data signal.
        m_axi_wlast : in std_logic_vector(axi_master_amount*1-1 downto 0);                                                --! AXI4-Full Write Data signal.
        m_axi_wvalid : in std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Write Data signal.
        m_axi_wready : out std_logic_vector(axi_master_amount*1-1 downto 0);                                                --! AXI4-Full Write Data signal.
        m_axi_bid : out std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);                                --! AXI4-Full Write Response signal.
        m_axi_bresp : out std_logic_vector(axi_master_amount*2-1 downto 0);                            --! AXI4-Full Write Response signal.
        m_axi_bvalid : out std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Write Response signal.
        m_axi_bready : in std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Write Response signal.
        -- Master AXI4-Full Read interface.
        m_axi_arid : in std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);                              --! AXI4-Full Address Read signal.
        m_axi_araddr : in std_logic_vector(axi_master_amount*axi_address_width-1 downto 0);                            --! AXI4-Full Address Read signal.
        m_axi_arlen : in std_logic_vector(axi_master_amount*8-1 downto 0);                             --! AXI4-Full Address Read signal.
        m_axi_arsize : in std_logic_vector(axi_master_amount*3-1 downto 0);                           --! AXI4-Full Address Read signal.    
        m_axi_arburst : in std_logic_vector(axi_master_amount*2-1 downto 0);                            --! AXI4-Full Address Read signal.
        m_axi_arlock : in std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Address Read signal.        
        m_axi_arcache : in std_logic_vector(axi_master_amount*4-1 downto 0);                           --! AXI4-Full Address Read signal.
        m_axi_arprot : in std_logic_vector(axi_master_amount*3-1 downto 0);                         --! AXI4-Full Address Read signal.    
        m_axi_arqos : in std_logic_vector(axi_master_amount*4-1 downto 0);                           --! AXI4-Full Address Read signal.
        m_axi_arregion : in std_logic_vector(axi_master_amount*4-1 downto 0);                        --! AXI4-Full Address Write signal.        
        m_axi_arvalid : in std_logic_vector(axi_master_amount*1-1 downto 0);                                          --! AXI4-Full Address Read signal.
        m_axi_arready : out std_logic_vector(axi_master_amount*1-1 downto 0);                                              --! AXI4-Full Address Read signal.
        m_axi_rid : out std_logic_vector(axi_master_amount*axi_master_id_width-1 downto 0);                                --! AXI4-Full Read Data signal.
        m_axi_rdata : out std_logic_vector(axi_master_amount*axi_data_width-1 downto 0);                            --! AXI4-Full Read Data signal.
        m_axi_rresp : out std_logic_vector(axi_master_amount*2-1 downto 0);                            --! AXI4-Full Read Data signal.    
        m_axi_rlast : out std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Read Data signal.
        m_axi_rvalid : out std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Read Data signal.
        m_axi_rready : in std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Read Data signal.
        -- Slave AXI4-Full Write interfaces.
        s_axi_awid : out std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awaddr : out std_logic_vector(axi_slave_amount*axi_address_width-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awlen : out std_logic_vector(axi_slave_amount*8-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awsize : out std_logic_vector(axi_slave_amount*3-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awburst : out std_logic_vector(axi_slave_amount*2-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awlock : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                                --! AXI4-Full Address Write signal.    
        s_axi_awcache : out std_logic_vector(axi_slave_amount*4-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awprot : out std_logic_vector(axi_slave_amount*3-1 downto 0);                            --! AXI4-Full Address Write signal.
        s_axi_awqos : out std_logic_vector(axi_slave_amount*4-1 downto 0);                            --! AXI4-Full Address Write signal.    
        s_axi_awregion : out std_logic_vector(axi_slave_amount*4-1 downto 0);                        --! AXI4-Full Address Write signal.                    
        s_axi_awvalid : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                            --! AXI4-Full Address Write signal.
        s_axi_awready : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                                --! AXI4-Full Address Write signal.    
        s_axi_wdata : out std_logic_vector(axi_slave_amount*axi_data_width-1 downto 0);                            --! AXI4-Full Write Data signal.
        s_axi_wstrb : out std_logic_vector(axi_slave_amount*axi_data_width/8-1 downto 0);                            --! AXI4-Full Write Data signal.
        s_axi_wlast : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                                --! AXI4-Full Write Data signal.
        s_axi_wvalid : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                               --! AXI4-Full Write Data signal.
        s_axi_wready : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                                --! AXI4-Full Write Data signal.
        s_axi_bid : in std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);                                --! AXI4-Full Write Response signal.
        s_axi_bresp : in std_logic_vector(axi_slave_amount*2-1 downto 0);                            --! AXI4-Full Write Response signal.
        s_axi_bvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                               --! AXI4-Full Write Response signal.
        s_axi_bready : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                               --! AXI4-Full Write Response signal.
        -- Slave AXI4-Full Read interface.
        s_axi_arid : out std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);                              --! AXI4-Full Address Read signal.
        s_axi_araddr : out std_logic_vector(axi_slave_amount*axi_address_width-1 downto 0);                            --! AXI4-Full Address Read signal.
        s_axi_arlen : out std_logic_vector(axi_slave_amount*8-1 downto 0);                             --! AXI4-Full Address Read signal.
        s_axi_arsize : out std_logic_vector(axi_slave_amount*3-1 downto 0);                           --! AXI4-Full Address Read signal.    
        s_axi_arburst : out std_logic_vector(axi_slave_amount*2-1 downto 0);                            --! AXI4-Full Address Read signal.
        s_axi_arlock : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                               --! AXI4-Full Address Read signal.        
        s_axi_arcache : out std_logic_vector(axi_slave_amount*4-1 downto 0);                           --! AXI4-Full Address Read signal.
        s_axi_arprot : out std_logic_vector(axi_slave_amount*3-1 downto 0);                         --! AXI4-Full Address Read signal.    
        s_axi_arqos : out std_logic_vector(axi_slave_amount*4-1 downto 0);                           --! AXI4-Full Address Read signal.
        s_axi_arregion : out std_logic_vector(axi_slave_amount*4-1 downto 0);                        --! AXI4-Full Address Write signal.        
        s_axi_arvalid : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                          --! AXI4-Full Address Read signal.
        s_axi_arready : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                              --! AXI4-Full Address Read signal.
        s_axi_rid : in std_logic_vector(axi_slave_amount*(clogb2(axi_master_amount+1)+axi_master_id_width)-1 downto 0);                                --! AXI4-Full Read Data signal.
        s_axi_rdata : in std_logic_vector(axi_slave_amount*axi_data_width-1 downto 0);                            --! AXI4-Full Read Data signal.
        s_axi_rresp : in std_logic_vector(axi_slave_amount*2-1 downto 0);                            --! AXI4-Full Read Data signal.    
        s_axi_rlast : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                               --! AXI4-Full Read Data signal.
        s_axi_rvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                               --! AXI4-Full Read Data signal.
        s_axi_rready : out std_logic_vector(axi_slave_amount*1-1 downto 0)                                                --! AXI4-Full Read Data signal.
    );
end plasoc_crossbar;

architecture Behavioral of plasoc_crossbar is
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
    constant axi_master_full_axi_id_head_width : integer := clogb2(axi_master_amount+1);
    constant axi_master_full_axi_id_width : integer := axi_master_full_axi_id_head_width+axi_master_id_width;
    signal axi_master_full_axi_awid : std_logic_vector(axi_master_amount*axi_master_full_axi_id_width-1 downto 0);
    signal axi_master_full_axi_arid : std_logic_vector(axi_master_amount*axi_master_full_axi_id_width-1 downto 0);
    signal axi_address_m2s_write_enables : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0);
    signal axi_address_s2m_write_enables : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0);
    signal axi_address_m2s_read_enables : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0);
    signal axi_address_s2m_read_enables : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0);
begin
    -- Assign the identifiers for the master identifiers.
    generate_axi_master_full_id :
    for each_master in 0 to axi_master_amount-1 generate
        ---- awid assignments.
        -- Assign the header identifier.
        axi_master_full_axi_awid(
            (1+each_master)*axi_master_full_axi_id_width-1 downto 
            (1+each_master)*axi_master_full_axi_id_width-axi_master_full_axi_id_head_width) <= 
        std_logic_vector(to_unsigned(each_master,axi_master_full_axi_id_head_width));
        -- Assign the corresponding master identifier.
        axi_master_full_axi_awid(
            each_master*axi_master_full_axi_id_width+axi_master_id_width-1 downto 
            each_master*axi_master_full_axi_id_width+0) <= 
        m_axi_awid(
            (each_master+1)*axi_master_id_width-1 downto 
            each_master*axi_master_id_width);
        ---- arid assignments.
        -- Assign the header identifier.
        axi_master_full_axi_arid(
            (1+each_master)*axi_master_full_axi_id_width-1 downto 
            (1+each_master)*axi_master_full_axi_id_width-axi_master_full_axi_id_head_width) <= 
        std_logic_vector(to_unsigned(each_master,axi_master_full_axi_id_head_width));
        -- Assign the corresponding master identifier.
        axi_master_full_axi_arid(
            each_master*axi_master_full_axi_id_width+axi_master_id_width-1 downto 
            each_master*axi_master_full_axi_id_width+0) <= 
        m_axi_arid(
            (each_master+1)*axi_master_id_width-1 downto 
            each_master*axi_master_id_width);
    end generate generate_axi_master_full_id;
    -- AXI4-Full Write Address Instantiations.
    axi_awid_cross_inst : plasoc_crossbar_base 
        generic map (width => axi_master_full_axi_id_width,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => axi_master_full_axi_awid,enables => axi_address_m2s_write_enables,outputs => s_axi_awid);
    axi_awaddr_cross_inst : plasoc_crossbar_base
        generic map (width => axi_address_width,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_awaddr,enables => axi_address_m2s_write_enables,outputs => s_axi_awaddr);
    axi_awlen_cross_inst : plasoc_crossbar_base
        generic map (width => 8,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_awlen,enables => axi_address_m2s_write_enables,outputs => s_axi_awlen);
    axi_awsize_cross_inst : plasoc_crossbar_base
        generic map (width => 3,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_awsize,enables => axi_address_m2s_write_enables,outputs => s_axi_awsize);
    axi_awburst_cross_inst : plasoc_crossbar_base
        generic map (width => 2,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_awburst,enables => axi_address_m2s_write_enables,outputs => s_axi_awburst);
    axi_awlock_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_awlock,enables => axi_address_m2s_write_enables,outputs => s_axi_awlock);  
    axi_awcache_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_awcache,enables => axi_address_m2s_write_enables,outputs => s_axi_awcache);
    axi_awprot_cross_inst : plasoc_crossbar_base
        generic map (width => 3,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_awprot,enables => axi_address_m2s_write_enables,outputs => s_axi_awprot);
    axi_awqos_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_awqos,enables => axi_address_m2s_write_enables,outputs => s_axi_awqos);
    axi_awregion_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_awregion,enables => axi_address_m2s_write_enables,outputs => s_axi_awregion);
    axi_awvalid_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_awvalid,enables => axi_address_m2s_write_enables,outputs => s_axi_awvalid);
    axi_awready_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map(inputs => s_axi_awready,enables => axi_address_s2m_write_enables,outputs => m_axi_awready);
    -- AXI4-Full Read Address Instantiations.    
    axi_arid_cross_inst : plasoc_crossbar_base 
        generic map (width => axi_master_full_axi_id_width,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => axi_master_full_axi_arid,enables => axi_address_m2s_read_enables,outputs => s_axi_arid);  
    axi_araddr_cross_inst : plasoc_crossbar_base
        generic map (width => axi_address_width,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map (inputs => m_axi_araddr,enables => axi_address_m2s_read_enables,outputs => s_axi_araddr);
    axi_arlen_cross_inst : plasoc_crossbar_base
        generic map (width => 8,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_arlen,enables => axi_address_m2s_read_enables,outputs => s_axi_arlen);
    axi_arsize_cross_inst : plasoc_crossbar_base
        generic map (width => 3,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_arsize,enables => axi_address_m2s_read_enables,outputs => s_axi_arsize);
    axi_arburst_cross_inst : plasoc_crossbar_base
        generic map (width => 2,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_arburst,enables => axi_address_m2s_read_enables,outputs => s_axi_arburst);
    axi_arlock_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_arlock,enables => axi_address_m2s_read_enables,outputs => s_axi_arlock);
    axi_arcache_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_arcache,enables => axi_address_m2s_read_enables,outputs => s_axi_arcache);  
    axi_arprot_cross_inst : plasoc_crossbar_base
        generic map (width => 3,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_arprot,enables => axi_address_m2s_read_enables,outputs => s_axi_arprot);
    axi_arqos_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_arqos,enables => axi_address_m2s_read_enables,outputs => s_axi_arqos);
    axi_arregion_cross_inst : plasoc_crossbar_base
        generic map (width => 4,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_arregion,enables => axi_address_m2s_read_enables,outputs => s_axi_arregion);
    axi_arvalid_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_master_amount,output_amount => axi_slave_amount)
        port map(inputs => m_axi_arvalid,enables => axi_address_m2s_read_enables,outputs => s_axi_arvalid);
    axi_arready_cross_inst : plasoc_crossbar_base
        generic map (width => 1,input_amount => axi_slave_amount,output_amount => axi_master_amount)
        port map(inputs => s_axi_arready,enables => axi_address_s2m_read_enables,outputs => m_axi_arready);
end Behavioral;
