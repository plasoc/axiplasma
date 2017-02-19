

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use work.plasoc_crossbar_pack.all; 
                
entity plasoc_crossbar_axi4_write_cntrl is
    generic (
        axi_slave_amount : integer := 2;
        axi_master_amount : integer := 4);
    port (
    
        aclk : in std_logic;                                                    
        aresetn : in std_logic;
        
        axi_write_master_iden : in std_logic_vector(axi_slave_amount*clogb2(axi_master_amount+1)-1 downto 0);
        axi_write_slave_iden : in std_logic_vector(axi_master_amount*clogb2(axi_slave_amount+1)-1 downto 0);
        
        axi_address_write_enables : out std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
        axi_data_write_enables : out std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
        axi_response_write_enables : out std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0);
        
        m_address_write_connected : in std_logic_vector(axi_master_amount-1 downto 0);
        m_data_write_connected : in std_logic_vector(axi_master_amount-1 downto 0);
        s_response_write_connected : in std_logic_vector(axi_slave_amount-1 downto 0);
        
        s_axi_awvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);
        s_axi_wvalid : in std_logic_vector(axi_slave_amount*1-1 downto 0);
        s_axi_bready : in std_logic_vector(axi_slave_amount*1-1 downto 0);
        m_axi_awready : in std_logic_vector(axi_master_amount*1-1 downto 0);
        m_axi_wready : in std_logic_vector(axi_master_amount*1-1 downto 0);
        m_axi_bvalid : in std_logic_vector(axi_master_amount*1-1 downto 0));
end plasoc_crossbar_axi4_write_cntrl;

architecture Behavioral of plasoc_crossbar_axi4_write_cntrl is

    constant axi_slave_iden_width : integer := clogb2(axi_slave_amount+1);
    constant axi_master_iden_width : integer := clogb2(axi_master_amount+1);
    
    function get_slave_handshakes ( 
        valid : in std_logic_vector(axi_slave_amount-1 downto 0);
        ready : in std_logic_vector(axi_master_amount-1 downto 0);
        master_iden : in std_logic_vector(axi_slave_amount*axi_master_iden_width-1 downto 0) ) 
        return std_logic_vector is
        variable master_iden_buff : integer range 0 to axi_master_amount-1;
        variable slave_handshakes : std_logic_vector(axi_slave_amount-1 downto 0) := (others=>'0');
    begin
        for each_slave in 0 to axi_slave_amount-1 loop
            master_iden_buff := to_integer(unsigned(master_iden((1+each_slave)*axi_master_iden_width-1 downto each_slave*axi_master_iden_width)));
            if valid(each_slave)='1' and ready(master_iden_buff)='1' then
                slave_handshakes(each_slave) := '1';
            end if;
        end loop;
        return slave_handshakes;
    end;
    
    function get_slave_permissions (
        slave_handshakes : in std_logic_vector(axi_slave_amount-1 downto 0);
        master_connected : in std_logic_vector(axi_slave_amount-1 downto 0);
        master_iden : in std_logic_vector(axi_slave_amount*axi_master_iden_width-1 downto 0)) return
        std_logic_vector is
        variable master_iden_buff : integer range 0 to axi_master_amount-1;
        variable slave_permissions : std_logic_vector(axi_slave_amount-1 downto 0) := (others=>'0');
    begin
        for each_master in 0 to axi_master_amount-1 loop
            for each_slave in 0 to axi_slave_amount-1 loop
                master_iden_buff := to_integer(unsigned(master_iden((1+each_slave)*axi_master_iden_width-1 downto each_slave*axi_master_iden_width)));
                if each_master=master_iden_buff and slave_handshakes(each_slave)='1' and master_connected(master_iden_buff)='0' then
                    slave_permissions(each_slave) := '1';
                    exit;
                end if;
            end loop;
        end loop;
        return slave_permissions;
    end;
    
    function set_slave_enables_ff (
        slave_handshakes : in std_logic_vector(axi_slave_amount-1 downto 0);
        master_connected : in std_logic_vector(axi_slave_amount-1 downto 0);
        master_iden : in std_logic_vector(axi_slave_amount*axi_master_iden_width-1 downto 0)) return 
        std_logic_vector is
        variable master_iden_buff : integer range 0 to axi_master_amount-1;
        variable slave_permissions : std_logic_vector(axi_slave_amount-1 downto 0);
        variable enables : std_logic_vector(axi_slave_amount*axi_master_amount-1 downto 0) := (others=>'0');
    begin
        slave_permissions := get_slave_permissions(slave_handshakes,master_connected,master_iden);
        for each_slave in 0 to axi_slave_amount-1 loop
            master_iden_buff := to_integer(unsigned(master_iden((1+each_slave)*axi_master_iden_width-1 downto each_slave*axi_master_iden_width)));
            if slave_permissions(each_slave)='1' then
                enables(each_slave+master_iden_buff*axi_slave_amount) := '1';
            elsif slave_handshakes(each_slave)='0' then
                for each_master in 0 to axi_master_amount-1 loop
                    enables(each_slave+master_iden_buff*axi_slave_amount) := '0';
                end loop;
            end if;
        end loop;
        return enables;
    end;
    
    function get_master_handshakes ( 
        valid : in std_logic_vector(axi_master_amount-1 downto 0);
        ready : in std_logic_vector(axi_slave_amount-1 downto 0);
        slave_iden : in std_logic_vector(axi_master_amount*axi_slave_iden_width-1 downto 0) ) 
        return std_logic_vector is
        variable slave_iden_buff : integer range 0 to axi_slave_amount-1;
        variable master_handshakes : std_logic_vector(axi_master_amount-1 downto 0) := (others=>'0');
    begin
        for each_master in 0 to axi_master_amount-1 loop
            slave_iden_buff := to_integer(unsigned(slave_iden((1+each_master)*axi_slave_iden_width-1 downto each_master*axi_slave_iden_width)));
            if valid(each_master)='1' and ready(slave_iden_buff)='1' then
                master_handshakes(each_master) := '1';
            end if;
        end loop;
        return master_handshakes;
    end;
    
    function get_master_permissions (
        master_handshakes : in std_logic_vector(axi_master_amount-1 downto 0);
        slave_connected : in std_logic_vector(axi_master_amount-1 downto 0);
        slave_iden : in std_logic_vector(axi_master_amount*axi_slave_iden_width-1 downto 0)) return
        std_logic_vector is
        variable slave_iden_buff : integer range 0 to axi_slave_amount-1;
        variable master_permissions : std_logic_vector(axi_master_amount-1 downto 0) := (others=>'0');
    begin
        for each_slave in 0 to axi_slave_amount-1 loop
            for each_master in 0 to axi_master_amount-1 loop
                slave_iden_buff := to_integer(unsigned(slave_iden((1+each_master)*axi_slave_iden_width-1 downto each_master*axi_slave_iden_width)));
                if each_slave=slave_iden_buff and master_handshakes(each_master)='1' and slave_connected(slave_iden_buff)='0' then
                    master_permissions(each_master) := '1';
                    exit;
                end if;
            end loop;
        end loop;
        return master_permissions;
    end;
    
    function set_master_enables_ff (
        master_handshakes : in std_logic_vector(axi_master_amount-1 downto 0);
        slave_connected : in std_logic_vector(axi_master_amount-1 downto 0);
        slave_iden : in std_logic_vector(axi_master_amount*axi_slave_iden_width-1 downto 0)) return 
        std_logic_vector is
        variable slave_iden_buff : integer range 0 to axi_slave_amount-1;
        variable master_permissions : std_logic_vector(axi_master_amount-1 downto 0);
        variable enables : std_logic_vector(axi_master_amount*axi_slave_amount-1 downto 0) := (others=>'0');
    begin
        master_permissions := get_master_permissions(master_handshakes,slave_connected,slave_iden);
        for each_master in 0 to axi_master_amount-1 loop
            slave_iden_buff := to_integer(unsigned(slave_iden((1+each_master)*axi_slave_iden_width-1 downto each_master*axi_slave_iden_width)));
            if master_permissions(each_master)='1' then
                enables(each_master+slave_iden_buff*axi_master_amount) := '1';
            elsif master_handshakes(each_master)='0' then
                for each_slave in 0 to axi_slave_amount-1 loop
                    enables(each_master+slave_iden_buff*axi_master_amount) := '0';
                end loop;
            end if;
        end loop;
        return enables;
    end;
        
    signal address_slave_handshakes : std_logic_vector(axi_slave_amount*1-1 downto 0);
    signal data_slave_handshakes : std_logic_vector(axi_slave_amount*1-1 downto 0);
    signal response_master_handshakes : std_logic_vector(axi_master_amount*1-1 downto 0);
begin

    process (s_axi_awvalid,m_axi_awready,axi_write_master_iden)
    begin
        address_slave_handshakes <= get_slave_handshakes(s_axi_awvalid,m_axi_awready,axi_write_master_iden);
    end process;
    process (s_axi_wvalid,m_axi_wready,axi_write_master_iden)
    begin
        data_slave_handshakes <= get_slave_handshakes(s_axi_wvalid,m_axi_wready,axi_write_master_iden);
    end process;
    process (m_axi_bvalid,s_axi_bready,axi_write_slave_iden)
    begin
        response_master_handshakes <= get_master_handshakes(m_axi_bvalid,s_axi_bready,axi_write_slave_iden);
    end process;
    
    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                axi_address_write_enables <= (others=>'0');
                axi_data_write_enables <= (others=>'0');
                axi_response_write_enables <= (others=>'0');
            else
                axi_address_write_enables <= set_slave_enables_ff(address_slave_handshakes,m_address_write_connected,axi_write_master_iden);
                axi_data_write_enables <= set_slave_enables_ff(data_slave_handshakes,m_data_write_connected,axi_write_master_iden);
                axi_response_write_enables <= set_master_enables_ff(response_master_handshakes,s_response_write_connected,axi_write_slave_iden); 
            end if;
        end if;
    end process;

end Behavioral;
