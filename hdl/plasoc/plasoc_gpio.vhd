-------------------------------------------------------
--! @author Andrew Powell
--! @date March 14, 2017
--! @brief Contains the entity and architecture of the 
--! Plasma-SoC's GPIO Core.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;          
use ieee.numeric_std.all;                  
use work.plasoc_gpio_pack.all;

--! The Plasma-SoC's General Purpose Input and Output (GPIO) Core is built
--! so that the CPU has a simple, albiet inefficient, way to access
--! signals outside of the CPU. Because the overhead incurred in a transaction,
--! the GPIO Core should not be relied upon if large amounts of data require transfer.
--!
--! The operation of the GPIO Core can be described in terms of its registers, including
--! Control, Data In, and Data Out. The bits of the Control register include the Enable and
--! Ack. Setting the Enable bit puts the GPIO Core in interruption mode, during which Data In can
--! only accept new data from the GPIO Core's data_in if an acknowledgement is received by 
--! writing high to the ACK bit. With interruption mode disabled, Data In will always accept 
--! new data from data_in. Writing to the Data Out register sets the GPIO Core's data_out.
--!
--! Information specific to the AXI4-Lite
--! protocol is excluded from this documentation since the information can
--! be found in official ARM AMBA4 AXI documentation. 
entity plasoc_gpio is
    generic (
        -- Device parameters.
        data_in_width : integer := 16;                --! Defines the width of data_in. This value should be less than or equal to axi_data_width. 
        data_out_width : integer := 16;               --! Defines the width of data_out. This value should be less than or equal to axi_data_width.
        -- Slave AXI4-Lite parameters.
        axi_address_width : integer := 16;            --! Defines the AXI4-Lite Address Width.
        axi_data_width : integer := 32;               --! Defines the AXI4-Lite Data Width.   
        axi_control_offset : integer := 0;            --! Defines the offset for the Control register.
        axi_control_enable_bit_loc : integer := 0;    --! Defines the bit location of the Enable bit in the Control register.
        axi_control_ack_bit_loc : integer := 1;       --! Defines the bit location of the Ack bit in the Control register.
        axi_data_in_offset : integer := 4;            --! Defines the offset for the Data In register.
        axi_data_out_offset : integer := 8            --! Defines the offset for the Data Out register.
    );
    port (
        -- Global interface.
        aclk : in std_logic;                                                            --! Clock. Tested with 50 MHz.
        aresetn : in std_logic;                                                         --! Reset on low. Technically supposed to be asynchronous, however asynchronous resets aren't used.
        -- Device interface.
        data_in : in std_logic_vector(data_in_width-1 downto 0);                        --! Data read into the GPIO Core. This input can be registered into the Data In register, depending on the right conditions.
        data_out : out std_logic_vector(data_out_width-1 downto 0);                     --! Data written out of the GPIO Core. This output is registered by the Data Out register.
        -- Slave AXI4-Lite Write interface.
        axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Write signal.
        axi_awprot : in std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Write signal.
        axi_awvalid : in std_logic;                                                     --! AXI4-Lite Address Write signal.
        axi_awready : out std_logic;                                                    --! AXI4-Lite Address Write signal.
        axi_wvalid : in std_logic;                                                      --! AXI4-Lite Write Data signal.
        axi_wready : out std_logic;                                                     --! AXI4-Lite Write Data signal.
        axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);                     --! AXI4-Lite Write Data signal.    
        axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);                   --! AXI4-Lite Write Data signal.
        axi_bvalid : out std_logic;                                                     --! AXI4-Lite Write Response signal.
        axi_bready : in std_logic;                                                      --! AXI4-Lite Write Response signal.
        axi_bresp : out std_logic_vector(1 downto 0);                                   --! AXI4-Lite Write Response signal.
        -- Slave AXI4-Lite Read interface.
        axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Read signal.
        axi_arprot : in std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Read signal.
        axi_arvalid : in std_logic;                                                     --! AXI4-Lite Address Read signal.
        axi_arready : out std_logic;                                                    --! AXI4-Lite Address Read signal.
        axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');   --! AXI4-Lite Read Data signal.
        axi_rvalid : out std_logic;                                                     --! AXI4-Lite Read Data signal.
        axi_rready : in std_logic;                                                      --! AXI4-Lite Read Data signal.
        axi_rresp : out std_logic_vector(1 downto 0);                                   --! AXI4-Lite Read Data signal.
        -- Interrupt interface.
        int : out std_logic                                                             --! If the GPIO Core is configured in interruption mode, a change in Data In causes intr to go high until the GPIO Core is acknowledged.
    );    
end plasoc_gpio;

architecture Behavioral of plasoc_gpio is
    component plasoc_gpio_cntrl is
        generic (
            constant data_in_width : integer := 16 );
        port (
            clock : in std_logic;
            nreset : in std_logic;
            enable : in std_logic;
            ack : in std_logic;
            int : out std_logic;
            data_in_axi : out std_logic_vector(data_in_width-1 downto 0);
            data_in_periph : in std_logic_vector(data_in_width-1 downto 0) );
    end component;
    component plasoc_gpio_axi4_write_cntrl is
        generic (
            axi_address_width : integer := 16;                        --! Defines the AXI4-Lite Address Width.
            axi_data_width : integer := 32;                           --! Defines the AXI4-Lite Data Width.  
            reg_control_offset : std_logic_vector := X"0000";         --! Defines the offset for the Control register.
            reg_control_enable_bit_loc : integer := 0;
            reg_control_ack_bit_loc : integer := 1;
            reg_data_out_offset : std_logic_vector := X"0008" 
        );
        port (
            -- Global interface.
            aclk : in std_logic;                                                --! Clock. Tested with 50 MHz.
            aresetn : in std_logic;                                             --! Reset on low.    
            -- Slave AXI4-Lite Write interface.
            axi_awaddr : in std_logic_vector(axi_address_width-1 downto 0);     --! AXI4-Lite Address Write signal.
            axi_awprot : in std_logic_vector(2 downto 0);                       --! AXI4-Lite Address Write signal.
            axi_awvalid : in std_logic;                                         --! AXI4-Lite Address Write signal.
            axi_awready : out std_logic;                                        --! AXI4-Lite Address Write signal.
            axi_wvalid : in std_logic;                                          --! AXI4-Lite Write Data signal.
            axi_wready : out std_logic;                                         --! AXI4-Lite Write Data signal.
            axi_wdata : in std_logic_vector(axi_data_width-1 downto 0);         --! AXI4-Lite Write Data signal.
            axi_wstrb : in std_logic_vector(axi_data_width/8-1 downto 0);       --! AXI4-Lite Write Data signal.
            axi_bvalid : out std_logic;                                         --! AXI4-Lite Write Response signal.
            axi_bready : in std_logic;                                          --! AXI4-Lite Write Response signal.
            axi_bresp : out std_logic_vector(1 downto 0);                       --! AXI4-Lite Write Response signal.
            -- Register interface.
            reg_control_enable : out std_logic;        --! Control register.
            reg_control_ack : out std_logic;
            reg_data_out : out std_logic_vector(axi_data_width-1 downto 0)
            );
    end component;
    component plasoc_gpio_axi4_read_cntrl is
        generic (
            -- AXI4-Lite parameters.
            axi_address_width : integer := 16;                   --! Defines the AXI4-Lite Address Width.
            axi_data_width : integer := 32;                      --! Defines the AXI4-Lite Data Width.
            -- Register interface.
            reg_control_offset : std_logic_vector := X"0000";    --! Defines the offset for the Control register.
            reg_data_in_offset : std_logic_vector := X"0004";
            reg_data_out_offset : std_logic_vector := X"0008"
        );
        port (
            -- Global interface.
            aclk : in std_logic;                                                            --! Clock. Tested with 50 MHz.
            aresetn : in std_logic;                                                         --! Reset on low.
            -- Slave AXI4-Lite Read interface.
            axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);                 --! AXI4-Lite Address Read signal.
            axi_arprot : in std_logic_vector(2 downto 0);                                   --! AXI4-Lite Address Read signal.
            axi_arvalid : in std_logic;                                                     --! AXI4-Lite Address Read signal.
            axi_arready : out std_logic;                                                    --! AXI4-Lite Address Read signal.
            axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');   --! AXI4-Lite Read Data signal.
            axi_rvalid : out std_logic;                                                     --! AXI4-Lite Read Data signal.
            axi_rready : in std_logic;                                                      --! AXI4-Lite Read Data signal.
            axi_rresp : out std_logic_vector(1 downto 0);                                   --! AXI4-Lite Read Data signal.
            -- Register interface.
            reg_control : in std_logic_vector(axi_data_width-1 downto 0);
            reg_data_in : in std_logic_vector(axi_data_width-1 downto 0);
            reg_data_out : in std_logic_vector(axi_data_width-1 downto 0)
        ); 
    end component;
    -- Constant declarations.
    constant axi_control_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_control_offset,axi_address_width));
    constant axi_data_in_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_data_in_offset,axi_address_width));
    constant axi_data_out_offset_slv : std_logic_vector := std_logic_vector(to_unsigned(axi_data_out_offset,axi_address_width));
    signal reg_control : std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
    signal reg_control_enable :  std_logic;        --! Control register.
    signal reg_control_ack :  std_logic;
    signal reg_control_enable_buff : std_logic_vector(axi_data_width-1 downto 0);
    signal reg_control_ack_buff : std_logic_vector(axi_data_width-1 downto 0);
    signal reg_data_in : std_logic_vector(axi_data_width-1 downto 0);
    signal reg_data_out : std_logic_vector(axi_data_width-1 downto 0);
begin
    reg_data_in(axi_data_width-1 downto data_in_width) <= (others=>'0');
    data_out <= reg_data_out(data_out_width-1 downto 0);
    
    reg_control(axi_control_enable_bit_loc) <= reg_control_enable;
    reg_control(axi_control_ack_bit_loc) <= reg_control_ack;

    plasoc_gpio_cntrl_inst : plasoc_gpio_cntrl 
    generic map (
        data_in_width => data_in_width )
    port map (
        clock => aclk,
        nreset => aresetn,
        enable => reg_control_enable,
        ack => reg_control_ack,
        int => int,
        data_in_axi => reg_data_in(data_in_width-1 downto 0),
        data_in_periph => data_in );

    plasoc_gpio_axi4_write_cntrl_inst : 
    plasoc_gpio_axi4_write_cntrl 
        generic map (
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            reg_control_offset => axi_control_offset_slv,
            reg_control_enable_bit_loc => axi_control_enable_bit_loc,
            reg_control_ack_bit_loc => axi_control_ack_bit_loc,
            reg_data_out_offset => axi_data_out_offset_slv )
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
            reg_control_enable => reg_control_enable,
            reg_control_ack => reg_control_ack,
            reg_data_out => reg_data_out );
            
    plasoc_gpio_axi4_read_cntrl_inst : 
    plasoc_gpio_axi4_read_cntrl 
        generic map (
            axi_address_width => axi_address_width,
            axi_data_width => axi_data_width,
            reg_control_offset => axi_control_offset_slv,
            reg_data_in_offset => axi_data_in_offset_slv,
            reg_data_out_offset => axi_data_out_offset_slv)
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
            reg_control => reg_control,
            reg_data_in => reg_data_in,
            reg_data_out => reg_data_out);
        

end Behavioral;
