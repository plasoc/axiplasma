library ieee;
use ieee.std_logic_1164.all;
use work.soc_uart_pack.all;

entity soc_uart_axi4_read_cntrl is
    generic (
        fifo_depth : integer := 8;
        axi_address_width : integer := 16;
        axi_data_width : integer := 32;
        reg_control_offset : std_logic_vector := X"0000";
        reg_control_enable_int_in_avail_bit_loc : integer := 0;
        reg_control_status_in_avail_bit_loc : integer := 1;
        reg_control_status_out_full_bit_loc : integer := 2;
        reg_in_fifo_offset : std_logic_vector := X"0004";
        reg_out_fifo_offset : std_logic_vector := X"0008");
    port (
        aclk : in std_logic;
        aresetn : in std_logic;
        axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
        axi_arprot : in std_logic_vector(2 downto 0);
        axi_arvalid : in std_logic;
        axi_arready : out std_logic;
        axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
        axi_rvalid : out std_logic;
        axi_rready : in std_logic;
        axi_rresp : out std_logic_vector(1 downto 0);        
        reg_control_enable_int_in_avail : in std_logic;  
        reg_control_status_in_avail : in std_logic;
        reg_control_status_out_full : in std_logic;
        reg_in_fifo : in std_logic_vector(7 downto 0));
end soc_uart_axi4_read_cntrl;

architecture Behavioral of soc_uart_axi4_read_cntrl is

    component soc_uart_fifo is
        generic (
            FIFO_WIDTH : positive := 32;
            FIFO_DEPTH : positive := 1024
        );
        port (
            clock       : in std_logic;
            nreset       : in std_logic;
            write_data  : in std_logic_vector(FIFO_WIDTH-1 downto 0);
            read_data   : out std_logic_vector(FIFO_WIDTH-1 downto 0);
            write_en    : in std_logic;
            read_en     : in std_logic;
            full        : out std_logic;
            empty       : out std_logic;
            level       : out std_logic_vector(clogb2(FIFO_DEPTH)-1 downto 0
            )
        );
    end component;

    type state_type is (state_wait,state_read);
    signal state : state_type := state_wait;
    signal axi_arready_buff : std_logic := '0';
    signal axi_rvalid_buff : std_logic := '0';
    signal axi_araddr_buff : std_logic_vector(axi_address_width-1 downto 0);
    
    signal reg_control : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    signal reg_in_fifo_buff : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    
begin

    axi_arready <= axi_arready_buff;
    axi_rvalid <= axi_rvalid_buff;
    axi_rresp <= axi_resp_okay;
    
    reg_control(reg_control_enable_int_in_avail_bit_loc) <= reg_control_enable_int_in_avail;
    reg_control(reg_control_status_in_avail_bit_loc) <= reg_control_status_in_avail;
    reg_control(reg_control_status_out_full_bit_loc) <= reg_control_status_out_full;
    reg_in_fifo_buff(7 downto 0) <= reg_in_fifo;
    
    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                axi_arready_buff <= '0';
                axi_rvalid_buff <= '0';
                state <= state_wait;
            else
                case state is
                when state_wait=>
                    if axi_arvalid='1' and axi_arready_buff='1' then
                        axi_arready_buff <= '0';
                        axi_araddr_buff <= axi_araddr;
                        state <= state_read;
                    else
                        axi_arready_buff <= '1';
                    end if;
                when state_read=>
                    if axi_rvalid_buff='1' and axi_rready='1' then
                        axi_rvalid_buff <= '0';
                        state <= state_wait;
                    else
                        axi_rvalid_buff <= '1';
                        if axi_araddr_buff=reg_control_offset then 
                            axi_rdata <= reg_control;
                        elsif axi_araddr_buff=reg_in_fifo_buff then
                            axi_rdata <= reg_data_in;
                        else
                            axi_rdata <= (others=>'0');
                        end if;
                    end if;
                end case;
            end if;
        end if;
    end process;

end Behavioral;
