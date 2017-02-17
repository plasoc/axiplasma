----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2017 06:35:09 PM
-- Design Name: 
-- Module Name: plasoc_axi4_full2lite_read_controller - Behavioral
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

entity plasoc_axi4_full2lite_read_controller is
    generic (
        axi_slave_id_width : integer := 1;
        axi_address_width : integer := 32;
        axi_data_width : integer := 32);
    port(
        -- Global interface.
        aclk : in std_logic;                                    --! Defines the AXI4-Lite Address Width.
        aresetn : in std_logic;                                 --! Reset on low.
        -- Slave AXI4-Full Read outterface.
        s_axi_arid : in std_logic_vector(axi_slave_id_width-1 downto 0);
        s_axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);                            --! AXI4-Full Address Read signal.
        s_axi_arlen : in std_logic_vector(8-1 downto 0);                             --! AXI4-Full Address Read signal.
        s_axi_arsize : in std_logic_vector(3-1 downto 0);                           --! AXI4-Full Address Read signal.    
        s_axi_arburst : in std_logic_vector(2-1 downto 0);                            --! AXI4-Full Address Read signal.
        s_axi_arlock : in std_logic;                                               --! AXI4-Full Address Read signal.        
        s_axi_arcache : in std_logic_vector(4-1 downto 0);                           --! AXI4-Full Address Read signal.
        s_axi_arprot : in std_logic_vector(3-1 downto 0);                         --! AXI4-Full Address Read signal.    
        s_axi_arqos : in std_logic_vector(4-1 downto 0);                           --! AXI4-Full Address Read signal.
        s_axi_arregion : in std_logic_vector(4-1 downto 0);                        --! AXI4-Full Address Write signal.        
        s_axi_arvalid : in std_logic;                                          --! AXI4-Full Address Read signal.
        s_axi_arready : out std_logic;                                              --! AXI4-Full Address Read signal.
        s_axi_rid : out std_logic_vector(axi_slave_id_width-1 downto 0) := (others=>'0');
        s_axi_rdata : out std_logic_vector(axi_data_width-1 downto 0);                            --! AXI4-Full Read Data signal.
        s_axi_rresp : out std_logic_vector(2-1 downto 0);                            --! AXI4-Full Read Data signal.    
        s_axi_rlast : out std_logic;                                               --! AXI4-Full Read Data signal.
        s_axi_rvalid : out std_logic;                                               --! AXI4-Full Read Data signal.
        s_axi_rready : in std_logic;   
        -- Master AXI4-Lite Read interface.
        m_axi_araddr : out std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Read signal.
        m_axi_arprot : out std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Read signal.
        m_axi_arvalid : out std_logic;                                                     --! AXI4-Lite Address Read signal.
        m_axi_arready : in std_logic;                                                    --! AXI4-Lite Address Read signal.
        m_axi_rdata : in std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');   --! AXI4-Lite Read Data signal.
        m_axi_rvalid : in std_logic;                                                     --! AXI4-Lite Read Data signal.
        m_axi_rready : out std_logic;                                                      --! AXI4-Lite Read Data signal.
        m_axi_rresp : in std_logic_vector(1 downto 0));
end plasoc_axi4_full2lite_read_controller;

architecture Behavioral of plasoc_axi4_full2lite_read_controller is
    type state_type is (s_wait,s_operate);
    signal s_axi_arlen_buff : integer range 0 to 2**8-1 := 0;  
    signal s_axi_arburst_buff : std_logic_vector(2-1 downto 0) := (others=>'0');
    signal m_axi_araddr_buff : std_logic_vector(axi_address_width-1 downto 0) := (others=>'0');
    signal s_axi_arready_buff : std_logic := '0';
    signal s_axi_rvalid_buff : std_logic := '0';
    signal m_axi_arvalid_buff : std_logic := '0';
    signal m_axi_rready_buff : std_logic := '0';
    signal s_axi_rlast_buff : std_logic := '0';
    signal counter : integer range 0 to 2**8-1 := 0;
    signal state : state_type := s_wait;
begin
    m_axi_araddr <= m_axi_araddr_buff;
    s_axi_rvalid <= s_axi_rvalid_buff;
    s_axi_arready <= s_axi_arready_buff;
    m_axi_arvalid <= m_axi_arvalid_buff;
    m_axi_rready <= m_axi_rready_buff;
    s_axi_rlast <= s_axi_rlast_buff;
    s_axi_rresp <= (others=>'0');
    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                m_axi_arvalid_buff <= '0';
                m_axi_rready_buff <= '0';
                s_axi_arready_buff <= '0';
                s_axi_rvalid_buff <= '0';
                s_axi_rlast_buff <= '0';
            else
                case state is
                    when s_wait=>
                        if s_axi_arvalid='1' and s_axi_arready_buff='1' then
                            s_axi_rid <= s_axi_arid;
                            s_axi_arready_buff <= '0';
                            s_axi_arlen_buff <= to_integer(unsigned(s_axi_arlen));
                            s_axi_arburst_buff <= s_axi_arburst;
                            m_axi_araddr_buff <= s_axi_araddr;
                            m_axi_arprot <= s_axi_arprot;
                            m_axi_arvalid_buff <= '1';
                            counter <= 0;
                            state <= s_operate;
                        else
                            s_axi_arready_buff <= '1';
                        end if;
                    when s_operate=>
                        if m_axi_arvalid_buff='1' and m_axi_arready='1' then
                            case s_axi_arburst_buff is
                                when axi_burst_fixed=>  
                                when axi_burst_incr=> m_axi_araddr_buff <= std_logic_vector(to_unsigned(to_integer(unsigned(m_axi_araddr_buff))+axi_data_width/8,axi_address_width));
                                when others=>
                            end case;
                        end if;
                        if m_axi_rvalid='1' and m_axi_rready_buff='1' then
                            s_axi_rdata <= m_axi_rdata;
                        end if;
                        if m_axi_arvalid_buff='1' and m_axi_arready='1' and counter=s_axi_arlen_buff then
                            m_axi_arvalid_buff <= '0';
                        end if;
                        if m_axi_arvalid_buff='1' and m_axi_arready='1' then
                            counter <= counter+1;
                        end if;
                        if m_axi_arvalid_buff='1' and m_axi_arready='1' then
                            m_axi_rready_buff <= '1';
                        elsif s_axi_rvalid_buff='1' and s_axi_rready='1' then
                            m_axi_rready_buff <= '0';
                        end if;
                        if m_axi_rvalid='1' and m_axi_rready_buff='1' then
                            s_axi_rvalid_buff <= '1';
                        elsif s_axi_rvalid_buff='1' and s_axi_rready='1' then
                            s_axi_rvalid_buff <= '0';
                        end if;
                        if m_axi_rvalid='1' and m_axi_rready_buff='1' and m_axi_arvalid_buff='0' then
                            s_axi_rlast_buff <= '1';
                        elsif s_axi_rvalid_buff='1' and s_axi_rready='1' and s_axi_rlast_buff='1' then
                            s_axi_rlast_buff <= '0';
                        end if;
                        if s_axi_rvalid_buff='1' and s_axi_rready='1' and s_axi_rlast_buff='1' then
                            state <= s_wait;
                        end if;
                end case;
            end if;
        end if;
    end process;

end Behavioral;
