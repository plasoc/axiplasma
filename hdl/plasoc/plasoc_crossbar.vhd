
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity plasoc_crossbar is
    generic (
        axi_address_width : integer := 32;
        axi_data_width : integer := 32;
        axi_master_amount : integer := 2;
        axi_master_id_width_total : integer := 2;
        axi_master_id_widths : string := "1 1";
        axi_slave_amount : integer := 2
    );
    port (
        -- Global interface.
        aclk : in std_logic;                                                    --! Clock. Tested with 50 MHz.
        aresetn : in std_logic;                                                --! Reset on low.
        -- Master AXI4-Full Write interfaces.
        m_axi_awid : in std_logic_vector(axi_master_id_width_total-1 downto 0);                            --! AXI4-Full Address Write signal.
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
        m_axi_bid : out std_logic_vector(axi_master_id_width_total-1 downto 0);                                --! AXI4-Full Write Response signal.
        m_axi_bresp : out std_logic_vector(axi_master_amount*2-1 downto 0);                            --! AXI4-Full Write Response signal.
        m_axi_bvalid : out std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Write Response signal.
        m_axi_bready : in std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Write Response signal.
        -- Master AXI4-Full Read interface.
        m_axi_arid : in std_logic_vector(axi_master_id_width_total-1 downto 0);                              --! AXI4-Full Address Read signal.
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
        m_axi_rid : out std_logic_vector(axi_master_id_width_total-1 downto 0);                                --! AXI4-Full Read Data signal.
        m_axi_rdata : out std_logic_vector(axi_master_amount*axi_data_width-1 downto 0);                            --! AXI4-Full Read Data signal.
        m_axi_rresp : out std_logic_vector(axi_master_amount*2-1 downto 0);                            --! AXI4-Full Read Data signal.    
        m_axi_rlast : out std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Read Data signal.
        m_axi_rvalid : out std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Read Data signal.
        m_axi_rready : in std_logic_vector(axi_master_amount*1-1 downto 0);                                               --! AXI4-Full Read Data signal.
        -- Slave AXI4-Full Write interfaces.
        s_axi_awid : out std_logic_vector(axi_slave_amount*axi_master_id_width_total-1 downto 0);                            --! AXI4-Full Address Write signal.
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
        s_axi_bid : in std_logic_vector(axi_slave_amount*axi_master_id_width_total-1 downto 0);                                --! AXI4-Full Write Response signal.
        s_axi_bresp : in std_logic_vector(axi_slave_amount*2-1 downto 0);                            --! AXI4-Full Write Response signal.
        s_axi_bvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);                                               --! AXI4-Full Write Response signal.
        s_axi_bready : out std_logic_vector(axi_slave_amount*1-1 downto 0);                                               --! AXI4-Full Write Response signal.
        -- Slave AXI4-Full Read interface.
        s_axi_arid : out std_logic_vector(axi_slave_amount*axi_master_id_width_total-1 downto 0);                              --! AXI4-Full Address Read signal.
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
        s_axi_rid : in std_logic_vector(axi_slave_amount*axi_master_id_width_total-1 downto 0);                                --! AXI4-Full Read Data signal.
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
    type master_id_width_vector_type is array (0 to axi_master_amount-1) of integer;
    -- This function converts the id width string into an array of integers.
    function get_master_id_width_vector return master_id_width_vector_type is
        variable char_buff : character;
        variable string_buff : string := "";
        variable integer_buff : integer;
        variable master_id_width_vector_buff : master_id_width_vector_type := (others=>0);
        variable id_width_index : integer := 0;
    begin
        -- It assumed the values are separated by a single white space. The for-loop
        -- checks each character in the string.
        for each_char in 0 to axi_master_id_widths'length-1 loop
            -- The current character is acquired from the string.
            char_buff := axi_master_id_widths(each_char);
            -- If the current character is a white space, then beging the
            -- value conversion.
            if char_buff=' ' then
                -- Convert the current value into an integer.
                integer_buff := integer'value(string_buff);
                -- Reset the string buffer for the next integer.
                string_buff := "";
                -- Store the buffered integer into the vector buffer.
                master_id_width_vector_buff(id_width_index) := integer_buff;
                -- Point to the next entry in the buffer.
                id_width_index := id_width_index+1;
            -- If the current character is not a white space, it is assumed it is 
            -- a value. The value is concatenated with the current string buffer.
            else
                string_buff := string_buff & char_buff;
            end if;
        end loop;
        -- The last value needs to be converted into an integer and stored in the vector buffer.
        integer_buff := integer'value(string_buff);
        master_id_width_vector_buff(id_width_index) := integer_buff;
        -- Finally, return the vector buffer.
        return master_id_width_vector_buff;
    end;
    constant master_id_width_vector : master_id_width_vector_type := get_master_id_width_vector;
begin



end Behavioral;
