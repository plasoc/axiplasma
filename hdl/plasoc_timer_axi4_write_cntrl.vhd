----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2017 12:38:54 PM
-- Design Name: 
-- Module Name: plasoc_timer_axi4_write_cntrl - Behavioral
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
use work.mlitesoc_pack.all;

entity plasoc_timer_axi4_write_cntrl is
    generic (
        -- axi parameters.
        axi_address_width : integer := 16;
        axi_data_width : integer := 32;
        -- register interface.
        reg_control_offset : std_logic_vector := X"0000";
        reg_trig_value_offset : std_logic_vector := X"0004");
    port (
        -- global interface.
        aclk : in std_logic;
        aresetn : in std_logic;
        -- axi write interface.
        axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);
        axi_awprot : in std_logic_vector(2 downto 0);
        axi_awvalid : in std_logic;
        axi_awready : out std_logic;
        axi_wvalid : in std_logic;
        axi_wready : out std_logic;
        axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);
        axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);
        axi_bvalid : out std_logic;
        axi_bready : in std_logic;
        axi_bresp : out std_logic_vector(1 downto 0);
        -- register interface.
        reg_control : out std_logic_vector(axi_data_width-1 downto 0);
        reg_trig_value : out std_logic_vector(axi_data_width-1 downto 0);
        reg_valid : out std_logic := '0');
end plasoc_timer_axi4_write_cntrl;

architecture Behavioral of plasoc_timer_axi4_write_cntrl is
    type state_type is (state_wait,state_write,state_response);
    signal state : state_type := state_wait;
    signal axi_awready_buff : std_logic := '0';
    signal axi_awaddr_buff : std_logic_vector(axi_address_width-1 downto 0);
    signal axi_wready_buff : std_logic := '0';
    signal axi_bvalid_buff : std_logic := '0';
begin
    axi_awready <= axi_awready_buff;
    axi_wready <= axi_wready_buff;
    axi_bvalid <= axi_bvalid_buff;
    axi_bresp <= axi_resp_okay;
    
        -- Drive the axi write interface.
    process (aclk)
    begin
        -- Perform operations on the clock's positive edge.
        if rising_edge(aclk) then
            if aresetn='0' then
                axi_awready_buff <= '0';
                axi_wready_buff <= '0';
                axi_bvalid_buff <= '0';
                reg_control <= (others=>'0');
                reg_trig_value <= (others=>'0');
                reg_valid <= '0';
                state <= state_wait;
            else
                -- Drive state machine.
                case state is
                -- WAIT mode.
                when state_wait=>
                    -- Sample address interface on handshake and go start
                    -- performing the write operation.
                    if axi_awvalid='1' and axi_awready_buff='1' then
                        -- Prevent the master from sending any more control information.
                        axi_awready_buff <= '0';
                        -- Sample the address sent from the master.
                        axi_awaddr_buff <= axi_awaddr;
                        -- Begin to read data to write.
                        axi_wready_buff <= '1';
                        state <= state_write;
                    -- Let the master interface know the slave is ready
                    -- to receive address information.
                    else
                        axi_awready_buff <= '1';
                    end if;
                -- WRITE mode.
                when state_write=>
                    -- Wait for handshake.
                    if axi_wvalid='1' and axi_wready_buff='1' then
                        -- Send valid signal indicating new data may be
                        -- available.
                        reg_valid <= '1';
                        -- Prevent the master from sending any more data.
                        axi_wready_buff <= '0';
                        -- Only sample the specified bytes.
                        for each_byte in 0 to axi_data_width/8-1 loop
                            if axi_wstrb(each_byte)='1' then
                                -- Only sample written data if the address is valid.
                                if axi_awaddr_buff=reg_control_offset then
                                    reg_control(7+each_byte*8 downto each_byte*8) <=
                                        axi_wdata(7+each_byte*8 downto each_byte*8);
                                elsif axi_awaddr_buff=reg_trig_value_offset then
                                    reg_trig_value(7+each_byte*8 downto each_byte*8) <=
                                        axi_wdata(7+each_byte*8 downto each_byte*8);
                                end if;
                            end if;
                        end loop;
                        -- Begin to transmit the response.
                        state <= state_response;
                        axi_bvalid_buff <= '1';
                    end if;
                -- RESPONSE mode.
                when state_response=>
                    -- Since no new information is available, lower the valid signal.
                    reg_valid <= '0';
                    -- Wait for handshake.
                    if axi_bvalid_buff='1' and axi_bready='1' then
                        -- Starting waiting for more address information on 
                        -- successful handshake.
                        axi_bvalid_buff <= '0';
                        state <= state_wait;
                    end if;
                end case;
            end if;
        end if;
    end process;

end Behavioral;
