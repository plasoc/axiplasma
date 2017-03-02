library ieee;
use ieee.std_logic_1164.all;
use work.soc_uart_pack.all;

entity soc_uart_axi4_write_cntrl is
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
        reg_control_enable_int_in_avail : out std_logic;
        reg_in_fifo : out std_logic_vector(7 downto 0);
        reg_out_fifo : out std_logic_vector(7 downto 0);
        reg_out_fifo_valid : out std_logic;
        reg_out_fifo_ready : in std_logic);
end soc_uart_axi4_write_cntrl;

architecture Behavioral of soc_uart_axi4_write_cntrl is

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

    type state_type is (state_wait,state_write,state_response);
    signal state : state_type := state_wait;
    signal axi_awready_buff : std_logic := '0';
    signal axi_awaddr_buff : std_logic_vector(axi_address_width-1 downto 0);
    signal axi_wready_buff : std_logic := '0';
    signal axi_bvalid_buff : std_logic := '0';
    
    signal reg_control : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    signal reg_in_fifo_buff : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    
    signal in_fifo : std_logic_vector(7 downto 0);
    signal in_valid : std_logic := '0';
    signal in_not_ready : std_logic;
    signal out_fifo : std_logic_vector(7 downto 0);
    signal out_ready : std_logic;
    signal out_not_valid : std_logic;
begin
    axi_awready <= axi_awready_buff;
    axi_wready <= axi_wready_buff;
    axi_bvalid <= axi_bvalid_buff;
    axi_bresp <= axi_resp_okay;
    
    reg_control_enable_int_in_avail <= reg_control(reg_control_enable_int_in_avail_bit_loc);
    reg_out_fifo <= out_fifo;
    reg_out_fifo_valid <=  not out_not_valid;
    out_ready <= not reg_out_fifo_ready;
    
    in_fifo <= reg_in_fifo_buff(7 downto 0);

    soc_uart_fifo_inst : soc_uart_fifo 
        generic map (
            FIFO_WIDTH => 8,
            FIFO_DEPTH => fifo_depth)
        port map (
            clock => aclk,
            nreset => aresetn,
            write_data => in_fifo,
            read_data => out_fifo,
            write_en => in_valid,
            read_en => out_ready,
            full => in_not_ready,
            empty => out_not_valid,
            level => open);

    process (aclk)
    begin
        if rising_edge(aclk) then
            if aresetn='0' then
                axi_awready_buff <= '0';
                axi_wready_buff <= '0';
                axi_bvalid_buff <= '0';
                reg_control <= (others=>'0');
                reg_in_fifo_buff <= (others=>'0');
                in_valid <= '0';
                state <= state_wait;
            else
                case state is
                when state_wait=>
                    if axi_awvalid='1' and axi_awready_buff='1' then
                        axi_awready_buff <= '0';
                        axi_awaddr_buff <= axi_awaddr;
                        axi_wready_buff <= '1';
                        state <= state_write;
                    else
                        axi_awready_buff <= '1';
                    end if;
                when state_write=>
                    if axi_wvalid='1' and axi_wready_buff='1' then
                        axi_wready_buff <= '0';
                        for each_byte in 0 to axi_data_width/8-1 loop
                            if axi_wstrb(each_byte)='1' then
                                if axi_awaddr_buff=reg_control_offset then
                                    reg_control(7+each_byte*8 downto each_byte*8) <=
                                        axi_wdata(7+each_byte*8 downto each_byte*8);
                                elsif axi_awaddr_buff=reg_out_fifo_offset and in_not_ready='0' then
                                    reg_in_fifo_buff(7+each_byte*8 downto each_byte*8) <=
                                        axi_wdata(7+each_byte*8 downto each_byte*8);
                                    in_valid <= '1';
                                end if;
                            end if;
                        end loop;
                        state <= state_response;
                        axi_bvalid_buff <= '1';
                    end if;
                when state_response=>
                    in_valid <= '0';
                    if axi_bvalid_buff='1' and axi_bready='1' then
                        axi_bvalid_buff <= '0';
                        state <= state_wait;
                    end if;
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;
