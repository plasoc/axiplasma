-------------------------------------------------------
--! @author Andrew Powell
--! @date March 14, 2017
--! @brief Contains the entity and architecture of the 
--! Plasma-SoC's UART Core.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;          
use ieee.numeric_std.all;                  
use work.plasoc_uart_pack.all;

--! The Plasma-SoC's Universeral Asynchronous Rceiver and
--! Transmitter is implemented so that the CPU can perform
--! 8N1 serial transactions with a host computer. The serial transactions
--! are useful for printing detailed statuses, debugging problems related
--! to software, and in-circuit serial programming. The UART Core depends
--! on the UART developed by (THE AUTHOR'S NAME AND INFORMATION NEEDS TO BE
--! ADDED LATER) for its essential functionality. In other words, the UART Core
--! acts as a wrapper so that the UART has an Master AXI4-Lite interface and
--! and interruption capabilities.
--!
--! The UART Core behaves like any other UART. In order to take advantage of
--! this core, the CPU must read and write to the core's register space. The
--! Control register doesn't actually require any configuration. Instead, the
--! control bits Status In Avail and Status Out Avail indicate the status of the
--! UART Core. If Status In Avail is high, then 8-bit data is available in the In Fifo
--! register. If Status Out Avail is high, then 8-bit data can be written to the Out
--! Fifo Avail register. Both the In Fifo Avail and Out Fifo Avail registers have a width
--! of axi_data_width, however the data is always the least significant bits.
--!
--! Information specific to the AXI4-Lite
--! protocol is excluded from this documentation since the information can
--! be found in official ARM AMBA4 AXI documentation. 
entity plasoc_uart is
    generic (
        fifo_depth : integer := 8;                              --! Defines the number of 8-bit words that can be bufferred for each of the respective input and output queues.
        axi_address_width : integer := 16;                      --! Defines the AXI4-Lite Address Width.
        axi_data_width : integer := 32;                         --! Defines the AXI4-Lite Data Width. 
        axi_control_offset : integer := 0;                      --! Defines the offset for the Control register.
        axi_control_status_in_avail_bit_loc : integer := 0;     --! Defines the bit location of Status In Avail in the Control register.
        axi_control_status_out_avail_bit_loc : integer := 1;    --! Defines the bit location of Status Out Avail in the Control register.
        axi_in_fifo_offset : integer := 4;                      --! Defines the offset of the In Fifo register.
        axi_out_fifo_offset : integer := 8;                     --! Defines the offset of the Out Fifo register.
        baud : positive := 115200;                              --! The baud rate of the UART.
        clock_frequency : positive := 50000000                  --! The frequency of the input clock aclk.
    );
    port (
        -- Global interface.
        aclk : in std_logic;                                                               --! Clock. Tested with 50 MHz. 
        aresetn : in std_logic;                                                            --! Reset on low. Technically supposed to be asynchronous, however asynchronous resets aren't used.
        -- Slave AXI4-Lite Write interface.
        axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);                    --! AXI4-Lite Address Write signal.
        axi_awprot : in std_logic_vector(2 downto 0);                                      --! AXI4-Lite Address Write signal.
        axi_awvalid : in std_logic;                                                        --! AXI4-Lite Address Write signal.
        axi_awready : out std_logic;                                                       --! AXI4-Lite Address Write signal.
        axi_wvalid : in std_logic;                                                         --! AXI4-Lite Write Data signal.
        axi_wready : out std_logic;                                                        --! AXI4-Lite Write Data signal.
        axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);                        --! AXI4-Lite Write Data signal.
        axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);                      --! AXI4-Lite Write Data signal.
        axi_bvalid : out std_logic;                                                        --! AXI4-Lite Write Response signal.
        axi_bready : in std_logic;                                                         --! AXI4-Lite Write Response signal.
        axi_bresp : out std_logic_vector(1 downto 0);                                      --! AXI4-Lite Write Response signal.
        -- Slave AXI4-Lite Read interface.
        axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);                    --! AXI4-Lite Address Read signal.
        axi_arprot : in std_logic_vector(2 downto 0);                                      --! AXI4-Lite Address Read signal.
        axi_arvalid : in std_logic;                                                        --! AXI4-Lite Address Read signal.
        axi_arready : out std_logic;                                                       --! AXI4-Lite Address Read signal.
        axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');      --! AXI4-Lite Read Data signal.
        axi_rvalid : out std_logic;                                                        --! AXI4-Lite Read Data signal.
        axi_rready : in std_logic;                                                         --! AXI4-Lite Read Data signal.
        axi_rresp : out std_logic_vector(1 downto 0);                                      --! AXI4-Lite Read Data signal.
        -- UART interface.
        tx : out std_logic;                                                                --! Serially sends bits at the rate approximately equal to the baud. The communication protocol is always 8N1.
        rx : in  std_logic;                                                                --! Serially receives bits at the rate approximately equal to the baud. The communication protocol should always be 8N1.
        -- CPU interface.
        status_in_avail : out std_logic                                                    --! A signal indicating the state of the Status In Avail bit in the Control register. This signal can be used to interrupt the CPU.
    );
end plasoc_uart;

architecture Behavioral of plasoc_uart is

    component uart is
        generic (
            baud                : positive;
            clock_frequency     : positive
        );
        port (  
            clock               :   in  std_logic;
            nreset               :   in  std_logic;    
            data_stream_in      :   in  std_logic_vector(7 downto 0);
            data_stream_in_stb  :   in  std_logic;
            data_stream_in_ack  :   out std_logic;
            data_stream_out     :   out std_logic_vector(7 downto 0);
            data_stream_out_stb :   out std_logic;
            tx                  :   out std_logic;
            rx                  :   in  std_logic
        );
    end component;
    
    component plasoc_uart_axi4_write_cntrl is
        generic (
            fifo_depth : integer := 8;
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            reg_control_offset : std_logic_vector := X"0000";
            reg_control_status_in_avail_bit_loc : integer := 0;
            reg_control_status_out_avail_bit_loc : integer := 1;
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
            reg_out_fifo : out std_logic_vector(7 downto 0);
            reg_out_fifo_valid : out std_logic;
            reg_out_fifo_ready : in std_logic;
            reg_in_avail : out std_logic);
    end component;
    
    component plasoc_uart_axi4_read_cntrl is
        generic (
            fifo_depth : integer := 8;
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            reg_control_offset : std_logic_vector := X"0000";
            reg_control_status_in_avail_bit_loc : integer := 0;
            reg_control_status_out_avail_bit_loc : integer := 1;
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
            reg_control_status_in_avail : out std_logic;
            reg_control_status_out_avail : in std_logic;
            reg_in_fifo : in std_logic_vector(7 downto 0);
            reg_in_valid : in std_logic;
            reg_in_ready : out std_logic);
    end component;

    constant axi_control_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_control_offset,axi_address_width));
    constant axi_in_fifo_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_in_fifo_offset,axi_address_width));
    constant axi_out_fifo_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_out_fifo_offset,axi_address_width));

    signal out_fifo : std_logic_vector(7 downto 0);
    signal out_fifo_valid : std_logic;
    signal out_fifo_ready : std_logic;
    signal in_fifo : std_logic_vector(7 downto 0);
    signal in_fifo_valid : std_logic;
    signal in_fifo_ready : std_logic;
    signal reg_in_avail : std_logic;

begin

    uart_inst : uart
        generic map (
            baud => baud,
            clock_frequency => clock_frequency)
        port map (  
            clock => aclk,
            nreset => aresetn,   
            data_stream_in => out_fifo,
            data_stream_in_stb => out_fifo_valid,
            data_stream_in_ack => out_fifo_ready,
            data_stream_out => in_fifo,
            data_stream_out_stb => in_fifo_valid,
            tx => tx, rx => rx);

    plasoc_uart_axi4_write_cntrl_inst : plasoc_uart_axi4_write_cntrl
        generic map (
            fifo_depth => fifo_depth,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            reg_control_offset => axi_control_offset_slv,
            reg_control_status_in_avail_bit_loc => axi_control_status_in_avail_bit_loc,
            reg_control_status_out_avail_bit_loc => axi_control_status_out_avail_bit_loc,
            reg_in_fifo_offset => axi_in_fifo_offset_slv,
            reg_out_fifo_offset => axi_out_fifo_offset_slv)
        port map (
            aclk => aclk,
            aresetn => aresetn,
            axi_awaddr => axi_awaddr,
            axi_awprot => axi_awprot,
            axi_awvalid => axi_awvalid,
            axi_awready => axi_awready,
            axi_wvalid => axi_wvalid,
            axi_wready => axi_wready,
            axi_wdata => axi_wdata,
            axi_wstrb => axi_wstrb,
            axi_bvalid => axi_bvalid,
            axi_bready => axi_bready,
            axi_bresp => axi_bresp,
            reg_out_fifo => out_fifo,
            reg_out_fifo_valid => out_fifo_valid,
            reg_out_fifo_ready => out_fifo_ready,
            reg_in_avail => reg_in_avail);
            
    plasoc_uart_axi4_read_cntrl_inst : plasoc_uart_axi4_read_cntrl
        generic map (
            fifo_depth => fifo_depth,
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            reg_control_offset => axi_control_offset_slv,
            reg_control_status_in_avail_bit_loc => axi_control_status_in_avail_bit_loc,
            reg_control_status_out_avail_bit_loc => axi_control_status_out_avail_bit_loc,
            reg_in_fifo_offset => axi_in_fifo_offset_slv,
            reg_out_fifo_offset => axi_out_fifo_offset_slv)
        port map (
            aclk => aclk,
            aresetn => aresetn,
            axi_araddr => axi_araddr,
            axi_arprot => axi_arprot,
            axi_arvalid => axi_arvalid,
            axi_arready => axi_arready,
            axi_rdata => axi_rdata,
            axi_rvalid => axi_rvalid,
            axi_rready => axi_rready,
            axi_rresp => axi_rresp,
            reg_control_status_in_avail => status_in_avail,
            reg_control_status_out_avail => reg_in_avail,
            reg_in_fifo => in_fifo,
            reg_in_valid => in_fifo_valid,
            reg_in_ready => in_fifo_ready);

end Behavioral;
