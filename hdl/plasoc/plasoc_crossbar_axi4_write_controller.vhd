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
use IEEE.NUMERIC_STD.ALL;
                
entity plasoc_crossbar_axi4_write_controller is
    generic (
        axi_address_width : integer := 8;
        axi_master_amount : integer := 2;
        axi_master_id_width : integer := 2;
        axi_master_full_axi_id_head_width : integer := 2;
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
        m_axi_wvalid : in std_logic_vector(axi_master_amount*1-1 downto 0);
        s_axi_wready : in std_logic_vector(axi_slave_amount*1-1 downto 0);
        m_axi_wlast : in std_logic_vector(axi_master_amount*1-1 downto 0);
        s_axi_bid_head : in std_logic_vector(axi_slave_amount*axi_master_full_axi_id_head_width-1 downto 0);
        s_axi_bvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);
        m_axi_bready : in std_logic_vector(axi_master_amount*1-1 downto 0);
        
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
    
    type decoded_master_id_vector_type is array(0 to axi_slave_amount-1) of integer range 0 to 2**axi_master_amount-1;
    type permission_slave_vector_type is array(0 to axi_slave_amount-1) of Boolean;
    type occupied_master_vector_type is array(0 to axi_master_amount-1) of Boolean;
    type occupied_master_matrix_type is array(0 to axi_slave_amount-1) of std_logic_vector(axi_master_amount-1 downto 0);
    
    function get_slave_base_address_vector( address : in std_logic_vector(axi_slave_amount*axi_address_width-1 downto 0) ) return slave_address_vector_type is
        variable address_vector_buff : slave_address_vector_type;
    begin
        for each_slave in 0 to axi_slave_amount-1 loop
            address_vector_buff(each_slave) := 
                address((1+each_slave)*axi_address_width-1 downto each_slave*axi_address_width);
        end loop;
        return address_vector_buff;
    end;
    
    function get_permission_master_vector (
        decoded_slave_id_vector : in decoded_slave_id_vector_type; 
        signaled_master_vector : in permission_master_vector_type;
        handshake_master_vector : in permission_master_vector_type;
        occupied_slave_vector : in occupied_slave_vector_type ) 
        return permission_master_vector_type is
        variable permission_master_vector_buff : permission_master_vector_type;
        variable decoded_slave_id_buff : integer range 0 to axi_slave_amount-1;
    begin
        -- By default, no master has permission to use a slave interface.
        permission_master_vector_buff := (others=>False);
        -- Perform operation per each slave interface.
        for each_slave in 0 to axi_slave_amount-1 loop
            -- Perform operation per each master interface.
            for each_master in 0 to axi_master_amount-1 loop
                -- Determine which slave interface the current master interface is trying to reach.
                decoded_slave_id_buff := decoded_slave_id_vector(each_master);
                -- Give permission to the master interface if they are signal, there is a handshake, and the slave is
                -- not being occupied. Priority goes to the master interface whose unique head identifier is the lowest.
                if signaled_master_vector(each_master) and
                        handshake_master_vector(each_master) and
                        not occupied_slave_vector(decoded_slave_id_buff) and  
                        each_slave=decoded_slave_id_buff then
                    permission_master_vector_buff(each_master) := True;
                    exit;
                end if;
            end loop;
        end loop;
        -- Return the master vector.
        return permission_master_vector_buff;
    end;
    
    function get_permission_slave_vector (
        decoded_master_id_vector : in decoded_master_id_vector_type;
        handshake_slave_vector : in permission_slave_vector_type;
        occupied_master_vector : in occupied_master_vector_type )
        return permission_slave_vector_type is
        variable permission_slave_vector_buff : permission_slave_vector_type;
        variable decoded_master_id_buff : integer range 0 to axi_master_amount-1;
    begin
        -- By default, no slave has permission to use a master interface.
        permission_slave_vector_buff := (others=>False);
        for each_master in 0 to axi_master_amount-1 loop
            for each_slave in 0 to axi_slave_amount-1 loop
                decoded_master_id_buff := decoded_master_id_vector(each_slave);
                if handshake_slave_vector(each_slave) and
                        not occupied_master_vector(decoded_master_id_buff) and
                        each_master=decoded_master_id_buff then
                    permission_slave_vector_buff(each_slave) := True;
                    exit;
                end if;
            end loop;
        end loop;
        return permission_slave_vector_buff;
    end;
    
    function get_occupied_slave_vector( occupied_slave_matrix : in occupied_slave_matrix_type ) return occupied_slave_vector_type is
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
        -- Return the slave vector.
        return occupied_slave_vector_buff;
    end;
    
    function get_occupied_master_vector( occupied_master_matrix : in occupied_master_matrix_type ) return occupied_master_vector_type is
        variable occupied_master_vector_buff : occupied_master_vector_type;
        variable reduce_or : Boolean;
    begin
    -- Perform operation per each master interface.
    for each_master in 0 to axi_master_amount-1 loop
        -- Perform the reduction operation.
        reduce_or := False;
        for each_slave in 0 to axi_slave_amount-1 loop
            reduce_or := reduce_or or (occupied_master_matrix(each_slave)(each_master)='1');
        end loop;
        -- Store the result of the reduce or operation.
        occupied_master_vector_buff(each_master) := reduce_or;
    end loop;
    -- Return the master vector.
    return occupied_master_vector_buff;
    end;
    
    function set_master_m2s_enables( occupied_slave_matrix : in occupied_slave_matrix_type ) return std_logic_vector is
        variable m2s_enable_buff : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0);
    begin
        m2s_enable_buff := (others=>'0');
        for each_master in 0 to axi_master_amount-1 loop
            for each_slave in 0 to axi_slave_amount-1 loop
                if occupied_slave_matrix(each_master)(each_slave)='1' then
                    m2s_enable_buff(each_master+each_slave*axi_master_amount) := '1';
                end if;
            end loop;
        end loop;
        return m2s_enable_buff;
    end;
    
    function set_master_s2m_enables( occupied_slave_matrix : in occupied_slave_matrix_type ) return std_logic_vector is
        variable s2m_enable_buff : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
    begin
        s2m_enable_buff := (others=>'0');
        for each_master in 0 to axi_master_amount-1 loop
            for each_slave in 0 to axi_slave_amount-1 loop
                if occupied_slave_matrix(each_master)(each_slave)='1' then
                    s2m_enable_buff(each_slave+each_master*axi_slave_amount) := '1';
                end if;
            end loop;
        end loop;
        return s2m_enable_buff;
    end;
    
    function set_slave_m2s_enables( occupied_master_matrix : in occupied_master_matrix_type ) return std_logic_vector is
        variable m2s_enable_buff : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0);
    begin
        m2s_enable_buff := (others=>'0');
        for each_master in 0 to axi_master_amount-1 loop
            for each_slave in 0 to axi_slave_amount-1 loop
                if occupied_master_matrix(each_slave)(each_master)='1' then
                    m2s_enable_buff(each_master+each_slave*axi_master_amount) := '1';
                end if;
            end loop;
        end loop;
        return m2s_enable_buff;
    end;
    
    function set_slave_s2m_enables( occupied_master_matrix : in occupied_master_matrix_type ) return std_logic_vector is
        variable s2m_enable_buff : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
    begin
        s2m_enable_buff := (others=>'0');
        for each_master in 0 to axi_master_amount-1 loop
            for each_slave in 0 to axi_slave_amount-1 loop
                if occupied_master_matrix(each_slave)(each_master)='1' then
                    s2m_enable_buff(each_slave+each_master*axi_slave_amount) := '1';
                end if;
            end loop;
        end loop;
        return s2m_enable_buff;
    end;
    
    constant slave_base_address_vector : slave_address_vector_type := get_slave_base_address_vector(axi_slave_base_address);
    constant slave_high_address_vector : slave_address_vector_type := get_slave_base_address_vector(axi_slave_high_address);
    signal master_address_input_vector : master_address_vector_type := (others=>(others=>'0'));
    
    signal decoded_slave_id_vector : decoded_slave_id_vector_type := (others=>0);
    signal permission_master_vector : permission_master_vector_type := (others=>False);
    signal handshake_master_vector : permission_master_vector_type := (others=>False);
    signal occupied_slave_vector : occupied_slave_vector_type := (others=>False);
    signal occupied_slave_matrix : occupied_slave_matrix_type := (others=>(others=>'0'));
    
    signal data_signaled_master_vector : permission_master_vector_type := (others=>False);
    signal data_decoded_slave_id_vector : decoded_slave_id_vector_type := (others=>0);
    signal data_permission_master_vector : permission_master_vector_type := (others=>False);
    signal data_handshake_master_vector : permission_master_vector_type := (others=>False);
    signal data_occupied_slave_vector : occupied_slave_vector_type := (others=>False);
    signal data_occupied_slave_matrix : occupied_slave_matrix_type := (others=>(others=>'0'));
    
    signal response_decoded_master_id_vector : decoded_master_id_vector_type := (others=>0);
    signal response_permission_slave_vector : permission_slave_vector_type := (others=>False);
    signal response_handshake_slave_vector : permission_slave_vector_type := (others=>False);
    signal response_occupied_master_vector : occupied_master_vector_type := (others=>False);
    signal response_occupied_master_matrix : occupied_master_matrix_type := (others=>(others=>'0'));
begin

    generate_master_handshakes:
    for each_master in 0 to axi_master_amount-1 generate
        handshake_master_vector(each_master) <= m_axi_awvalid(each_master)='1' and s_axi_awready(decoded_slave_id_vector(each_master))='1';
        data_handshake_master_vector(each_master) <= m_axi_wvalid(each_master)='1' and s_axi_wready(data_decoded_slave_id_vector(each_master))='1';
    end generate generate_master_handshakes;
     
    generate_slave_handshakes:
    for each_slave in 0 to axi_slave_amount-1 generate
        response_handshake_slave_vector(each_slave) <= s_axi_bvalid(each_slave)='1' and m_axi_bready(response_decoded_master_id_vector(each_slave))='1';
    end generate generate_slave_handshakes;

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
        -- The default value is zero. This is actually pretty dangerous and should be changed
        -- in later revisions.
        decoded_slave_id_buff := 0;
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
    
    -- Determine vector of decoded master ids for each slave interface.
    process (s_axi_bid_head)
        variable response_decoded_master_id_vector_buff : decoded_master_id_vector_type;
    begin
        for each_slave in 0 to axi_slave_amount-1 loop
            response_decoded_master_id_vector_buff(each_slave) := 
                to_integer(unsigned(s_axi_bid_head((1+each_slave)*axi_master_full_axi_id_head_width-1 downto each_slave*axi_master_full_axi_id_head_width)));
        end loop;
        response_decoded_master_id_vector <= response_decoded_master_id_vector_buff;
    end process;
    
    -- Determine the permission of each master address interface.
    process (decoded_slave_id_vector,handshake_master_vector,occupied_slave_vector)
        constant signaled_master_vector_buff : permission_master_vector_type := (others=>True);
    begin
        permission_master_vector <= get_permission_master_vector (
            decoded_slave_id_vector => decoded_slave_id_vector,
            signaled_master_vector => signaled_master_vector_buff,
            handshake_master_vector => handshake_master_vector,
            occupied_slave_vector => occupied_slave_vector ); 
    end process;
    
    -- Determine the permission for each data master interface.
    process (data_decoded_slave_id_vector,data_signaled_master_vector,data_handshake_master_vector,data_occupied_slave_vector)
    begin
        data_permission_master_vector <= get_permission_master_vector (
            decoded_slave_id_vector => data_decoded_slave_id_vector,
            signaled_master_vector => data_signaled_master_vector,
            handshake_master_vector => data_handshake_master_vector,
            occupied_slave_vector => data_occupied_slave_vector ); 
    end process;
    
    -- Determine the permission for each response slave interface.
    process (response_decoded_master_id_vector,response_handshake_slave_vector,response_occupied_master_vector)
    begin
        response_permission_slave_vector <= get_permission_slave_vector (
            decoded_master_id_vector => response_decoded_master_id_vector,
            handshake_slave_vector => response_handshake_slave_vector,
            occupied_master_vector => response_occupied_master_vector );
    end process;
    
    -- Determine which slave interfaces are occupied.
    process (occupied_slave_matrix)
    begin
        occupied_slave_vector <= get_occupied_slave_vector(occupied_slave_matrix);
    end process;
    
    -- Determine which data slave interfaces are occupied.
    process (data_occupied_slave_matrix)
    begin
        data_occupied_slave_vector <= get_occupied_slave_vector(data_occupied_slave_matrix);
    end process;
    
    -- Determine which response master interfaces are occupied.
    process (response_occupied_master_matrix)
    begin
        response_occupied_master_vector <= get_occupied_master_vector(response_occupied_master_matrix);
    end process;
    
    -- Set the corresponding enables for the crossbars for the master controlled address interfaces.
    process (occupied_slave_matrix)
    begin
        axi_address_m2s_write_enables <= set_master_m2s_enables(occupied_slave_matrix);
        axi_address_s2m_write_enables <= set_master_s2m_enables(occupied_slave_matrix);
    end process;
    
    -- Set the corresponding enables for the crossbars for the master controlled data interfaces.
    process (data_occupied_slave_matrix)
    begin
        axi_data_m2s_write_enables <= set_master_m2s_enables(data_occupied_slave_matrix);
        axi_data_s2m_write_enables <= set_master_s2m_enables(data_occupied_slave_matrix);
    end process;
    
    -- Set the corresponding enables for the crossbars for the slaved controlled response interfaces.
    process (response_occupied_master_matrix)
    begin
        axi_response_m2s_write_enables <= set_slave_m2s_enables(response_occupied_master_matrix);
        axi_response_s2m_write_enables <= set_slave_s2m_enables(response_occupied_master_matrix);
    end process;
        
    -- The following perform the arbitration from the side of the master interfaces.
    generate_master_flipflops:
        -- Generate a state machine for each master interface.
        for each_master in 0 to axi_master_amount-1 generate
            process (aclk)
                variable decoded_slave_id_buff : integer range 0 to axi_slave_amount-1;
                variable data_decoded_slave_id_buff : integer range 0 to axi_slave_amount-1;
            begin
                -- Perform operations synchronously.
                if rising_edge(aclk) then
                    -- Perform reset on low.
                    if aresetn='0' then
                        occupied_slave_matrix(each_master) <= (others=>'0');
                        data_signaled_master_vector(each_master) <= False;
                        data_occupied_slave_matrix(each_master) <= (others=>'0');
                    else
                        -- Acquire useful variables.
                        decoded_slave_id_buff := decoded_slave_id_vector(each_master);
                        data_decoded_slave_id_buff := data_decoded_slave_id_vector(each_master);
                        ---- ADDRESS block.
                        -- Wait until the master interface has permission 
                        -- to use its desired slave interface.
                        if permission_master_vector(each_master) then
                            -- Connect and indicate that the current slave interface is occupied.
                            occupied_slave_matrix(each_master)(decoded_slave_id_buff) <= '1';
                            -- Store the decoded slave id for the data operation.
                            data_decoded_slave_id_vector(each_master) <= decoded_slave_id_buff;
                        -- Wait until the master and occupied slave interface performs their handshake.
                        elsif or_reduce(occupied_slave_matrix(each_master))='1' and handshake_master_vector(each_master) then
                            -- The slave should no longer be occupied after handshake.
                            occupied_slave_matrix(each_master) <= (others=>'0');
                            -- Alert the data block.
                            data_signaled_master_vector(each_master) <= True;
                        end if;
                        ---- DATA block.
                        -- Wait until the master interface has permission to use its desired slave interface.
                        if data_permission_master_vector(each_master) then
                            -- Connect and indicate the decoded slave interface is occupied.
                            data_occupied_slave_matrix(each_master)(data_decoded_slave_id_buff) <= '1';
                            -- Reset the signal used to enable this interface.
                            data_signaled_master_vector(each_master) <= False;
                        -- Wait until the master and occupied slave interface perform their handshake on the last word.
                        elsif or_reduce(data_occupied_slave_matrix(each_master))='1' and
                                data_handshake_master_vector(each_master) and 
                                m_axi_wlast(each_master)='1' then
                            -- The slave should no longer be occupied after handshake.
                            data_occupied_slave_matrix(each_master) <= (others=>'0');
                        end if;
                    end if;
                end if;
            end process;
        end generate 
    generate_master_flipflops;
    
    generate_slave_flipflops:
        for each_slave in 0 to axi_slave_amount-1 generate
            process (aclk)
                variable response_decoded_master_id_buff : integer range 0 to axi_master_amount-1;
            begin
                if rising_edge(aclk) then
                    if aresetn='0' then
                        response_occupied_master_matrix(each_slave) <= (others=>'0');
                    else
                        response_decoded_master_id_buff := response_decoded_master_id_vector(each_slave);
                        if response_permission_slave_vector(each_slave) then
                            response_occupied_master_matrix(each_slave)(response_decoded_master_id_buff) <= '1';
                        elsif or_reduce(response_occupied_master_matrix(each_slave))='1' and response_handshake_slave_vector(each_slave) then
                            response_occupied_master_matrix(each_slave) <= (others=>'0');
                        end if;
                    end if;
                end if;
            end process;
        end generate
    generate_slave_flipflops;

end Behavioral;
