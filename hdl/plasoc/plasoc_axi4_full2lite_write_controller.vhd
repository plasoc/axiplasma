----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2017 01:49:17 PM
-- Design Name: 
-- Module Name: plasoc_axi4_full2lite_write_controller - Behavioral
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
use ieee.numeric_std.all; 
use work.plasoc_axi4_full2lite_pack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity plasoc_axi4_full2lite_write_controller is
    generic (
        axi_address_width : integer := 32;
        axi_data_width : integer := 32);
    port (
        -- Global interface.
        aclk : in std_logic;                                    --! Defines the AXI4-Lite Address Width.
        aresetn : in std_logic;                                 --! Reset on low.
        -- Slave AXI4-Full Write outterface.
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
        s_axi_bresp : out std_logic_vector(2-1 downto 0);                            --! AXI4-Full Write Response signal.
        s_axi_bvalid : out std_logic;                                               --! AXI4-Full Write Response signal.
        s_axi_bready : in std_logic;                                               --! AXI4-Full Write Response signal.
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
        m_axi_bresp : in std_logic_vector(1 downto 0));
end plasoc_axi4_full2lite_write_controller;

architecture Behavioral of plasoc_axi4_full2lite_write_controller is
    type state_type is (s_wait,s_operate);
    signal error_occurred_with_burst : Boolean := False;
    signal len_buff : std_logic_vector(7 downto 0);
    signal burst_buff : std_logic_vector(2-1 downto 0);
    signal counter : integer range 0 to 2**8-1 := 0;  
    signal s_axi_awready_buff : std_logic := '0';
    signal s_axi_wready_buff : std_logic := '0';
    signal s_axi_bvalid_buff : std_logic := '0'; 
    signal m_axi_awaddr_buff : std_logic_vector(axi_address_width-1 downto 0) := (others=>'0');   
    signal m_axi_awvalid_buff : std_logic := '0';
    signal m_axi_wvalid_buff : std_logic := '0';
    signal m_axi_bready_buff : std_logic := '0';
    signal state : state_type := s_wait;
begin
    s_axi_awready <= s_axi_awready_buff;
    s_axi_wready <= s_axi_wready_buff;
    s_axi_bvalid <= s_axi_bvalid_buff;
    m_axi_awaddr <= m_axi_awaddr_buff;
    m_axi_awvalid <= m_axi_awvalid_buff;
    m_axi_wvalid <= m_axi_wvalid_buff;
    m_axi_bready <= m_axi_bready_buff;
    s_axi_bresp <= (others=>'0');
    
    -- Drive the address and data channels.
    process (aclk)
    begin
        -- Perform operations synchronously.
        if rising_edge(aclk) then
            -- Reset on low.
            if aresetn='0' then
                state <= s_wait;
                m_axi_awvalid_buff <= '0';
                m_axi_wvalid_buff <= '0';
                s_axi_awready_buff <= '0';
                s_axi_wready_buff <= '0';
                m_axi_bready_buff <= '0';
            else
                -- Controller's operation is based on its state.
                case state is
                    -- Wait until it's time to start the controller's operation.
                    when s_wait=>
                        -- Sample pertinent address information upon handshake.
                        if s_axi_awvalid='1' and s_axi_awready_buff='1' then
                            s_axi_awready_buff <= '0';
                            m_axi_awvalid_buff <= '1';
                            m_axi_awaddr_buff <= s_axi_awaddr;
                            m_axi_awprot <= s_axi_awprot;
                            len_buff <= s_axi_awlen;
                            burst_buff <= s_axi_awburst;
                            counter <= 0;
                            error_occurred_with_burst <= False;
                            state <= s_operate;
                        else
                            s_axi_awready_buff <= '1';
                            
                        end if;
                    -- The operation state represents the main state of operation of
                    -- the controller upon a request.
                    when s_operate=>
                        if m_axi_awvalid_buff='1' and m_axi_awready='1' then
                            case burst_buff is
                                when axi_burst_fixed=>                               
                                when axi_burst_incr=> m_axi_awaddr_buff <= std_logic_vector(to_unsigned(to_integer(unsigned(m_axi_awaddr_buff)+axi_data_width/8),axi_address_width));
                                when others=> error_occurred_with_burst <= True;
                            end case;
                        end if;
                        if s_axi_wvalid='1' and s_axi_wready_buff='1' then
                            m_axi_wdata <= s_axi_wdata;
                            m_axi_wstrb <= s_axi_wstrb;
                        end if;
                        if m_axi_awvalid_buff='1' and m_axi_awready='1' and counter=to_integer(unsigned(len_buff)) then
                            m_axi_awvalid_buff <= '0';
                        end if;
                        if m_axi_awvalid_buff='1' and m_axi_awready='1' then
                            counter <= counter+1;
                        end if;
                        if m_axi_awvalid_buff='1' and m_axi_awready='1' then
                            s_axi_wready_buff <= '1';
                        elsif s_axi_wvalid='1' and s_axi_wready_buff='1' then
                            s_axi_wready_buff <= '0';
                        end if;
                        if s_axi_wvalid='1' and s_axi_wready_buff='1' then
                            m_axi_wvalid_buff <= '1';
                        elsif m_axi_wvalid_buff='1' and m_axi_wready='1' then
                            m_axi_wvalid_buff <= '0';
                        end if;
                        if m_axi_wvalid_buff='1' and m_axi_wready='1' then
                            m_axi_bready_buff <= '1';
                        elsif m_axi_bvalid='1' and m_axi_bready_buff='1' then
                            m_axi_bready_buff <= '0';
                        end if;
                        if m_axi_bvalid='1' and m_axi_bready_buff='1' and m_axi_awvalid_buff='0' and m_axi_wvalid_buff='0' then
                            state <= s_wait;
                        end if;
                end case;
            end if;
        end if;
    end process;
    
    -- Drive the response channel for the full interface.
    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                s_axi_bvalid_buff <= '0';
            else
                if s_axi_wvalid='1' and s_axi_wready_buff='1' and s_axi_wlast='1' then
                    s_axi_bvalid_buff <= '1';
                elsif s_axi_bvalid_buff='1' and s_axi_bready='1' then
                    s_axi_bvalid_buff <= '0';
                end if;
            end if;
        end if;
    end process;

end Behavioral;
