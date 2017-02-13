----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/12/2017 04:52:38 PM
-- Design Name: 
-- Module Name: plasoc_crossbar_axi4_write_controller - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
                            
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity plasoc_crossbar_axi4_write_controller is
    generic (
        axi_address_width : integer := 8;
        axi_master_amount : integer := 2;
        axi_master_id_width : integer := 2;
        axi_slave_amount : integer := 2;
        axi_slave_base_address : std_logic_vector := X"0400";
        axi_slave_high_address : std_logic_vector := X"ff03");
    port (
        -- Global interface.
        aclk : in std_logic;                                                    --! Clock. Tested with 50 MHz.
        aresetn : in std_logic;                                                --! Reset on low.
        m_axi_awaddr : in std_logic_vector(axi_master_amount*axi_address_width-1 downto 0);
        m_axi_awvalid : in std_logic_vector(axi_master_amount*1-1 downto 0);
        s_axi_awready : in std_logic_vector(axi_slave_amount*1-1 downto 0);
        
        axi_address_m2s_write_enables : out std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0) := (others=>'0');
        axi_address_s2m_write_enables : out std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0) := (others=>'0');
        axi_data_m2s_write_enables : out std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0) := (others=>'0');
        axi_data_s2m_write_enables : out std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0) := (others=>'0');
        axi_response_s2m_write_enables : out std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0) := (others=>'0');
        axi_response_m2s_write_enables : out std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0) := (others=>'0')
    );
end plasoc_crossbar_axi4_write_controller;

architecture Behavioral of plasoc_crossbar_axi4_write_controller is

    type slave_address_vector_type is array(0 to axi_slave_amount-1) of std_logic_vector(axi_address_width-1 downto 0);
    type master_address_vector_type is array (0 to axi_master_amount-1) of std_logic_vector(axi_address_width-1 downto 0);
    type decoded_slave_id_vector_type is array(0 to axi_master_amount-1) of integer range 0 to axi_slave_amount-1;
    type permission_master_vector_type is array(0 to axi_master_amount-1) of Boolean;
    type occupied_slave_vector_type is array(0 to axi_slave_amount-1) of Boolean;
    type occupied_slave_matrix_type is array(0 to axi_master_amount-1) of std_logic_vector(axi_slave_amount-1 downto 0);
    
    type master_state_type is (mst_address,mst_data,mst_response);
    type master_state_vector_type is array(0 to axi_master_amount-1) of master_state_type;
    
    function get_slave_base_address_vector( address : in std_logic_vector(axi_slave_amount*axi_address_width-1 downto 0) ) return slave_address_vector_type is
        variable address_vector_buff : slave_address_vector_type;
    begin
        for each_slave in 0 to axi_slave_amount-1 loop
            address_vector_buff(each_slave) := 
                address((1+each_slave)*axi_address_width-1 downto each_slave*axi_address_width);
        end loop;
        return address_vector_buff;
    end;
    
    signal master_address_input_vector : master_address_vector_type := (others=>(others=>'0'));
    signal slave_base_address_vector : slave_address_vector_type := get_slave_base_address_vector(axi_slave_base_address);
    signal slave_high_address_vector : slave_address_vector_type := get_slave_base_address_vector(axi_slave_high_address);
    signal decoded_slave_id_vector : decoded_slave_id_vector_type := (others=>axi_slave_amount);
    signal permission_master_vector : permission_master_vector_type := (others=>False);
    signal occupied_slave_vector : occupied_slave_vector_type := (others=>False);
    signal occupied_slave_matrix : occupied_slave_matrix_type := (others=>(others=>'0'));
    signal data_decoded_slave_id_vector : decoded_slave_id_vector_type := (others=>0);
    signal data_permission_master_vector : permission_master_vector_type := (others=>False);
    signal master_state_vector : master_state_vector_type := (others=>mst_address);
begin

    -- Determine vector of master input addresses.
    process (m_axi_awaddr)
    begin
        -- Perform operation per each master interface.
        for each_master in 0 to axi_master_amount-1 loop
            -- Store each master address into vector.
            master_address_input_vector(each_master) <= m_axi_awaddr((1+each_master)*axi_address_width-1 downto each_master*axi_address_width);
        end loop;
    end process;
    
    -- Determine vector of decoded slave_ids for each master interface.
    process (master_address_input_vector)
        variable decoded_slave_id_buff : integer range 0 to axi_slave_amount-1;
        variable decoded_slave_id_vector_buff : decoded_slave_id_vector_type;
    begin
        -- Perform operation per each master interface.
        for each_master in 0 to axi_master_amount-1 loop
            -- Perform operation per each slave interface.
            for each_slave in 0 to axi_slave_amount-1 loop
                -- Decode the slave based on whether the master address falls within the range specified by the
                -- slave interface's base address.
                if master_address_input_vector(each_master)>=slave_base_address_vector(each_slave) and 
                        master_address_input_vector(each_master)<=slave_high_address_vector(each_slave) then
                    decoded_slave_id_buff := each_slave;
                end if;
            end loop;
            -- Store the decoded slave interface identifier.
            decoded_slave_id_vector_buff(each_master) := decoded_slave_id_buff;
        end loop;
        -- Return the decoded slave identifier vector.
        decoded_slave_id_vector <= decoded_slave_id_vector_buff;
    end process;
    
    -- Determine the permission of each master address interface.
    process (decoded_slave_id_vector,m_axi_awvalid,s_axi_awready)
        variable permission_master_vector_buff : permission_master_vector_type;
        variable decoded_slave_id_buff : integer range 0 to axi_master_amount-1;
    begin
        -- By default, no master has permission to use a slave interface.
        permission_master_vector_buff := (others=>False);
        -- Perform operation per each slave interface.
        for each_slave in 0 to axi_slave_amount-1 loop
            -- Perform operation per each master interface.
            for each_master in 0 to axi_master_amount-1 loop
                -- Determine which slave interface the current master interface is trying to reach.
                decoded_slave_id_buff := decoded_slave_id_vector(each_master);
                -- Give permission to the master interface if there is a handshake, the slave is
                -- not being occupied, and the master interface is waiting for address. 
                -- Priority goes to the master interface whose unique head identifier is the lowest.
                if m_axi_awvalid(each_master)='1' and s_axi_awready(decoded_slave_id_buff)='1' and 
                        not occupied_slave_vector(decoded_slave_id_buff) and 
                        master_state_vector(each_master)=mst_address and
                        each_slave=decoded_slave_id_buff then 
                    permission_master_vector_buff(each_master) := True;
                    exit;
                end if;
            end loop;
        end loop;
        -- Store the permission slave vector.
        permission_master_vector <= permission_master_vector_buff;
    end process;
    
    -- Determine the permission for each data master interface.
    process
        variable permission_master_vector_buff : permission_master_vector_type;
        variable decoded_slave_id_buff : integer range 0 to axi_master_amount-1;
    begin
        -- By default, no master has permission to use a data slave interface.
        permission_master_vector_buff := (others=>False);
        -- Perform operation per each slave interface.
        for each_slave in 0 to axi_slave_amount-1 loop
            -- Perform operation per each master interface.
            for each_master in 0 to axi_master_amount-1 loop
                -- Determine which slave interface the current master interface is trying to reach.
                decoded_slave_id_buff := data_decoded_slave_id_vector(each_master);
                
            end loop;
        end loop;
    end process;
    
    -- Determine which slave interfaces are occupied.
    process (occupied_slave_matrix)
        variable occupied_slave_vector_buff : occupied_slave_vector_type;
        variable reduce_or : Boolean;
    begin
        -- Perform operation per each slave interface.
        for each_slave in 0 to axi_slave_amount-1 loop
            -- Perform the reduction operation.
            reduce_or := False;
            for each_master in 0 to axi_master_amount-1 loop
                reduce_or := reduce_or or (occupied_slave_matrix(each_master)(each_slave)='1');
            end loop;
            -- Store the result of the reduce or operation.
            occupied_slave_vector_buff(each_slave) := reduce_or;
        end loop;
        -- Store the vector.
        occupied_slave_vector <= occupied_slave_vector_buff;
    end process;
    
    -- Set the corresponding enables for the crossbars for the address interface.
    process (occupied_slave_matrix)
        variable axi_address_m2s_write_enables_buff : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0);
        variable axi_address_s2m_write_enables_buff : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
    begin
        axi_address_m2s_write_enables_buff := (others=>'0');
        axi_address_s2m_write_enables_buff := (others=>'0');
        for each_master in 0 to axi_master_amount-1 loop
            for each_slave in 0 to axi_slave_amount-1 loop
                if occupied_slave_matrix(each_master)(each_slave)='1' then
                    axi_address_m2s_write_enables_buff(each_master+each_slave*axi_master_amount) := '1';
                    axi_address_s2m_write_enables_buff(each_slave+each_master*axi_slave_amount) := '1';
                end if;
            end loop;
        end loop;
    end process;

    -- The following array of state machines perform the arbitration.
    generate_master_state_machines:
        -- Generate a state machine for each master interface.
        for each_master in 0 to axi_master_amount-1 generate
            process (aclk)
                variable decoded_slave_id_buff : integer range 0 to axi_master_amount-1;
                variable data_decoded_slave_id_buff : integer range 0 to axi_master_amount-1;
            begin
                -- Acquire useful variables.
                decoded_slave_id_buff := decoded_slave_id_vector(each_master);
                data_decoded_slave_id_buff := data_decoded_slave_id_vector(each_master);
                -- Perform operations synchronously.
                if rising_edge(aclk) then
                    -- Perform reset on low.
                    if aresetn='0' then
                        occupied_slave_matrix(each_master) <= (others=>'0');
                        master_state_vector(each_master) <= mst_address;
                    else
                        -- Drive the state machine.
                        case master_state_vector(each_master) is
                            
                            when mst_address=>
                            
                                -- Wait until the master interface has permission 
                                -- to use its desired slave interface.
                                if permission_master_vector(each_master) then
                                    -- Connect and indicate that the current slave interface is occupied.
                                    occupied_slave_matrix(each_master)(decoded_slave_id_buff) <= '1';
                                    -- Store the decoded slave id for the data operation.
                                    data_decoded_slave_id_vector(each_master) <= decoded_slave_id_buff;
                                    -- Got to the address state and wait until the address information has been transferred.
                                     master_state_vector(each_master) <= mst_data;
                                end if;
                                
                            when mst_data=>
                                
                                -- The address channel only needs to be active for a single clock cycle upon handshake.
                                occupied_slave_matrix(each_master) <= (others=>'0');
                                
                                if data_permission_master_vector(each_master) then
                                end if;
                                
                                
                            when others=>
                                master_state_vector(each_master) <= mst_address;
                        end case;
                    end if;
                end if;
            end process;
        end generate 
    generate_master_state_machines;
    
    

end Behavioral;
