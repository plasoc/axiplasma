library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all; 
use work.plasoc_axi4_full2lite_pack.all;

entity plasoc_axi4_full2lite_write_cntrl is
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
        s_axi_bid : out std_logic_vector(axi_slave_id_width-1 downto 0) := (others=>'0');
        s_axi_bresp : out std_logic_vector(2-1 downto 0) := (others=>'0');                            
        s_axi_bvalid : out std_logic;                                               
        s_axi_bready : in std_logic;
        m_axi_awaddr : out std_logic_vector(axi_address_width-1 downto 0) := (others=>'0');                 
        m_axi_awprot : out std_logic_vector(2 downto 0) := (others=>'0');                                   
        m_axi_awvalid : out std_logic;                                                     
        m_axi_awready : in std_logic;                                                    
        m_axi_wvalid : out std_logic;                                                      
        m_axi_wready : in std_logic;                                                     
        m_axi_wdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');                     
        m_axi_wstrb : out std_logic_vector(axi_data_width/8-1 downto 0) := (others=>'0');                   
        m_axi_bvalid : in std_logic;                                                     
        m_axi_bready : out std_logic;                                                      
        m_axi_bresp : in std_logic_vector(1 downto 0));
end plasoc_axi4_full2lite_write_cntrl;

architecture Behavioral of plasoc_axi4_full2lite_write_cntrl is
    signal id_buff_0 : std_logic_vector(axi_slave_id_width-1 downto 0) := (others=>'0');
    signal id_buff_1 : std_logic_vector(axi_slave_id_width-1 downto 0) := (others=>'0');
    signal s_axi_awready_buff : std_logic := '0';
    signal m_axi_awvalid_buff : std_logic := '0';
    signal s_axi_wready_buff : std_logic := '0';
    signal m_axi_wvalid_buff : std_logic := '0';
    signal s_axi_bvalid_buff : std_logic := '0';
    signal m_axi_bready_buff : std_logic := '0';
begin
    s_axi_awready <= s_axi_awready_buff;
    m_axi_awvalid <= m_axi_awvalid_buff;
    s_axi_wready <= s_axi_wready_buff;
    m_axi_wvalid <= m_axi_wvalid_buff;
    s_axi_bvalid <= s_axi_bvalid_buff;
    m_axi_bready <= m_axi_bready_buff;
    process (aclk)
    begin
        if rising_edge (aclk) then
            if aresetn='0' then
                s_axi_awready_buff <= '1';
                m_axi_awvalid_buff <= '0';
            else
                if s_axi_awvalid='1' and s_axi_awready_buff='1' then
                    id_buff_0 <= s_axi_awid;
                    m_axi_awaddr <= s_axi_awaddr;
                    m_axi_awprot <= s_axi_awprot;
                end if;
                if s_axi_awvalid='1' and s_axi_awready_buff='1' then
                    m_axi_awvalid_buff <= '1';
                elsif m_axi_awvalid_buff='1' and  m_axi_awready='1' then
                    m_axi_awvalid_buff <= '0';
                end if;
                if m_axi_awready='1' then
                    s_axi_awready_buff <= '1';
                elsif s_axi_awvalid='1' and s_axi_awready_buff='1' then
                    s_axi_awready_buff <= '0';
                end if;            
            end if;
        end if;
    end process;
    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                s_axi_wready_buff <= '1';
                m_axi_wvalid_buff <= '0';
            else
                if s_axi_wvalid='1' and s_axi_wready_buff='1' then
                    id_buff_1 <= id_buff_0;
                    m_axi_wdata <= s_axi_wdata;
                    m_axi_wstrb <= s_axi_wstrb;
                end if;
                if s_axi_wvalid='1' and s_axi_wready_buff='1' then
                    m_axi_wvalid_buff <= '1';
                elsif m_axi_wvalid_buff='1' and m_axi_wready='1' then
                    m_axi_wvalid_buff <= '0';
                end if;
                if m_axi_wready='1' then
                    s_axi_wready_buff <= '1';
                elsif s_axi_wvalid='1' and s_axi_wready_buff='1' then
                    s_axi_wready_buff <= '0';
                end if;
            end if;
        end if;
    end process;
    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                s_axi_bvalid_buff <= '0';
                m_axi_bready_buff <= '1';
            else
                if m_axi_bvalid='1' and m_axi_bready_buff='1' then
                    s_axi_bid <= id_buff_1;
                    s_axi_bresp <= m_axi_bresp;
                end if;
                if m_axi_bvalid='1' and m_axi_bready_buff='1' then
                    s_axi_bvalid_buff <= '1';
                elsif s_axi_bvalid_buff='1' and s_axi_bready='1' then
                    s_axi_bvalid_buff <= '0';
                end if;
                if s_axi_bready='1' then
                    m_axi_bready_buff <= '1';
                elsif m_axi_bvalid='1' and m_axi_bready_buff='1' then
                    m_axi_bready_buff <= '0';
                end if;
            end if;
        end if;
    end process;
end Behavioral;
