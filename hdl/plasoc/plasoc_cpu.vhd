-------------------------------------------------------
--! @author Andrew Powell
--! @date January 17, 2017
--! @brief Contains the entity and architecture of the 
--! Plasma-SoC's CPU.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.mlite_pack.all;
use work.plasoc_pack.all;

--! The 32-bit CPU of the Plasma-SoC comprises only the original 
--! Plasma Mlite CPU developed by Steve Rhoads, configurable cache,
--! and AXI controllers to implement the AXI4-Full interface needed to
--! communicate with peripherals in the Plasma-SoC and those external. 
--!
--! In a later revision on this documentation, more information will be
--! added to describe the features implemented in the AXI4-Full interface
--! and the capabilities of the cache. Information specific to the AXI4-Full
--! protocol is excluded from this documentation since the information can
--! be found in official ARM AMBA4 AXI documentation.
entity plasoc_cpu is
    generic(
        -- CPU parameters.
        cpu_mult_type       : string  := default_cpu_mult_type;					--! Defines the Plasma Mlite multiplier type. The possible options are "DEFAULT" and "AREA_OPTIMIZED".
        cpu_shifter_type    : string  := default_cpu_shifter_type;				--! Defines the Plasma Mlite shifter type. The possible options are "DEFAULT" and "AREA_OPTIMIZED".
        cpu_alu_type        : string  := default_cpu_alu_type;					--! Defines the Plasma Mlite ALU type. The possible options are "DEFAULT" and "AREA_OPTIMIZED".
        -- Cache parameters.
        cache_address_width : integer := default_cache_address_width;			--! Defines the address width of the cacheable addresses.
        cache_way_width : integer := default_cache_way_width;					--! Associativity = 2^cache_way_width.
        cache_index_width : integer := default_cache_index_width;				--! Cache Size (rows) = 2^cache_index_width.
        cache_offset_width : integer := default_cache_offset_width;				--! Line Size (bytes) = 2^cache_offset_width.
        cache_replace_strat : string := default_cache_replace_strat;			--! Defines the replacement strategy in case of miss. Only "plru" is available.
        cache_base_address : std_logic_vector := default_cache_base_address;	--! Defines the base address of the cache controller registers.
        cache_enable : boolean := default_cache_enable							--! Defines whether or not the cache is enabled. 
	);
    port(
        -- Global interface.
        aclk : in std_logic;													--! Clock. Tested with 50 MHz.
        aresetn     : in std_logic;												--! Reset on low.
        -- Master AXI4-Full Write interface.
        axi_awid : out std_logic_vector(0 downto 0);							--! AXI4-Full Address Write signal.
        axi_awaddr : out std_logic_vector(31 downto 0);							--! AXI4-Full Address Write signal.
        axi_awlen : out std_logic_vector(7 downto 0);							--! AXI4-Full Address Write signal.
        axi_awsize : out std_logic_vector(2 downto 0);							--! AXI4-Full Address Write signal.
        axi_awburst : out std_logic_vector(1 downto 0);							--! AXI4-Full Address Write signal.
        axi_awlock : out std_logic;												--! AXI4-Full Address Write signal.	
        axi_awcache : out std_logic_vector(3 downto 0);							--! AXI4-Full Address Write signal.
        axi_awprot : out std_logic_vector(2 downto 0);							--! AXI4-Full Address Write signal.
        axi_awqos : out std_logic_vector(3 downto 0);							--! AXI4-Full Address Write signal.	
        axi_awregion : out std_logic_vector(3 downto 0);						--! AXI4-Full Address Write signal.					
        axi_awvalid : out std_logic;											--! AXI4-Full Address Write signal.
        axi_awready : in std_logic;												--! AXI4-Full Address Write signal.	
        axi_wdata : out std_logic_vector(31 downto 0);							--! AXI4-Full Write Data signal.
        axi_wstrb : out std_logic_vector(3 downto 0);							--! AXI4-Full Write Data signal.
        axi_wlast : out std_logic;												--! AXI4-Full Write Data signal.
        axi_wvalid : out std_logic;												--! AXI4-Full Write Data signal.
        axi_wready : in std_logic;												--! AXI4-Full Write Data signal.
        axi_bid : in std_logic_vector(0 downto 0);								--! AXI4-Full Write Response signal.
        axi_bresp : in  std_logic_vector(1 downto 0);							--! AXI4-Full Write Response signal.
        axi_bvalid : in std_logic;												--! AXI4-Full Write Response signal.
        axi_bready : out std_logic;												--! AXI4-Full Write Response signal.
        -- Master AXI4-Full Read interface.
        axi_arid : out std_logic_vector(0 downto 0);							--! AXI4-Full Address Read signal.
        axi_araddr : out std_logic_vector(31 downto 0);							--! AXI4-Full Address Read signal.
        axi_arlen : out std_logic_vector(7 downto 0);							--! AXI4-Full Address Read signal.
        axi_arsize : out std_logic_vector(2 downto 0);							--! AXI4-Full Address Read signal.	
        axi_arburst : out std_logic_vector(1 downto 0);							--! AXI4-Full Address Read signal.
        axi_arlock : out std_logic;												--! AXI4-Full Address Read signal.		
        axi_arcache : out std_logic_vector(3 downto 0);							--! AXI4-Full Address Read signal.
        axi_arprot : out std_logic_vector(2 downto 0);							--! AXI4-Full Address Read signal.	
        axi_arqos : out std_logic_vector(3 downto 0);							--! AXI4-Full Address Read signal.
        axi_arregion : out std_logic_vector(3 downto 0);						--! AXI4-Full Address Write signal.		
        axi_arvalid : out std_logic;											--! AXI4-Full Address Read signal.
        axi_arready : in std_logic;												--! AXI4-Full Address Read signal.
        axi_rid : in std_logic_vector(0 downto 0);								--! AXI4-Full Read Data signal.
        axi_rdata : in std_logic_vector(31 downto 0);							--! AXI4-Full Read Data signal.
        axi_rresp : in std_logic_vector(1 downto 0);							--! AXI4-Full Read Data signal.	
        axi_rlast : in std_logic;												--! AXI4-Full Read Data signal.
        axi_rvalid : in std_logic;												--! AXI4-Full Read Data signal.
        axi_rready : out std_logic;												--! AXI4-Full Read Data signal.
        -- CPU signals.
        intr_in      : in std_logic											    --! External interrupt.
    );
end plasoc_cpu;

architecture Behavioral of plasoc_cpu is
    -- Component declarations.
    component plasoc_cpu_l1_cache_cntrl is
        generic (
            cpu_address_width : integer := 16;
            cpu_data_width : integer := 32;
            cache_address_width : integer := 10;
            cache_way_width : integer := 1; 
            cache_index_width : integer := 4;
            cache_offset_width : integer := 4;
            cache_replace_strat : string := "plru";
            cache_base_address : std_logic_vector := X"0000" ); 
        port ( 
            clock : in std_logic; 
            resetn : in std_logic;
            cpu_address : in std_logic_vector(cpu_address_width-1 downto 0); 
            cpu_in_data : in std_logic_vector(cpu_data_width-1 downto 0);
            cpu_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
            cpu_strobe : in std_logic_vector(cpu_data_width/8-1 downto 0);
            cpu_pause : out std_logic;
            cache_cacheable : out std_logic;
            cache_out_address: out std_logic_vector(cache_index_width-1 downto 0);
            cache_out_data : out std_logic_vector(((cache_address_width-cache_index_width-cache_offset_width)+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
            cache_out_tag_enable : out std_logic_vector(2**cache_way_width-1 downto 0);
            cache_out_block_enable : out std_logic_vector(2**cache_way_width*2**cache_offset_width/(cpu_data_width/8)-1 downto 0);
            cache_in_address : out std_logic_vector(cache_index_width-1 downto 0);
            cache_in_data : in std_logic_vector(((cache_address_width-cache_index_width-cache_offset_width)+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
            mem_in_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
            mem_in_data : in std_logic_vector(cpu_data_width-1 downto 0);
            mem_in_enable : out std_logic;
            mem_in_valid : in std_logic;
            mem_in_ready : out std_logic;
            mem_out_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
            mem_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
            mem_out_strobe : out std_logic_vector(cpu_data_width/8-1 downto 0);
            mem_out_enable : out std_logic;
            mem_out_valid : out std_logic;
            mem_out_ready : in std_logic); 
    end component;
    component plasoc_cpu_l1_cache_buff is
        generic (
            glb_data_width : integer := 32;
            cache_tag_width : integer := 22;
            cache_index_width : integer := 5;
            cache_offset_width : integer := 4;
            cache_way_width : integer := 2 );
        port(
            clock : in std_logic;
            cache_in_data : in std_logic_vector((cache_tag_width+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
            cache_in_index : in std_logic_vector(cache_index_width-1 downto 0);
            cache_in_tag_enable : in std_logic_vector(2**cache_way_width-1 downto 0);
            cache_in_offset_enable : in std_logic_vector(2**cache_way_width*2**cache_offset_width/(glb_data_width/8)-1 downto 0);
            cache_out_data : out std_logic_vector((cache_tag_width+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
            cache_out_index : in std_logic_vector(cache_index_width-1 downto 0));
    end component;
    component plasoc_cpu_mem_cntrl is
        generic (
            cpu_address_width : integer := 16;
            cpu_data_width : integer := 32);
        port (
            clock : in std_logic; 
            resetn : in std_logic;
            cpu_address : in std_logic_vector(cpu_address_width-1 downto 0); 
            cpu_in_data : in std_logic_vector(cpu_data_width-1 downto 0);
            cpu_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
            cpu_strobe : in std_logic_vector(cpu_data_width/8-1 downto 0);
            cpu_pause : out std_logic;
            cache_cacheable : out std_logic;
            mem_in_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
            mem_in_data : in std_logic_vector(cpu_data_width-1 downto 0);
            mem_in_enable : out std_logic;
            mem_in_valid : in std_logic;
            mem_in_ready : out std_logic;
            mem_out_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
            mem_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
            mem_out_strobe : out std_logic_vector(cpu_data_width/8-1 downto 0) := (others=>'0');
            mem_out_enable : out std_logic := '0';
            mem_out_valid : out std_logic;
            mem_out_ready : in std_logic);
    end component;
    component plasoc_cpu_axi4_read_cntrl is
        generic (
            cpu_address_width : integer := 16;
            cpu_data_width : integer := 32;
            cache_offset_width : integer := 5;
            axi_aruser_width : integer := 0;
            axi_ruser_width : integer := 0);
        port(
            clock : in std_logic;
            nreset : in std_logic;
            mem_read_address : in std_logic_vector(cpu_address_width-1 downto 0);
            mem_read_data : out std_logic_vector(cpu_data_width-1 downto 0);
            mem_read_enable : in std_logic;
            mem_read_valid : out std_logic;
            mem_read_ready : in std_logic;
            cache_cacheable : in std_logic;
            axi_arid : out std_logic_vector(0 downto 0);
            axi_araddr : out std_logic_vector(cpu_address_width-1 downto 0);
            axi_arlen : out std_logic_vector(7 downto 0);
            axi_arsize : out std_logic_vector(2 downto 0);
            axi_arburst : out std_logic_vector(1 downto 0);
            axi_arlock : out std_logic;
            axi_arcache : out std_logic_vector(3 downto 0);
            axi_arprot : out std_logic_vector(2 downto 0);
            axi_arqos : out std_logic_vector(3 downto 0);
            axi_arregion : out std_logic_vector(3 downto 0);
            axi_aruser : out std_logic_vector(axi_aruser_width-1 downto 0);
            axi_arvalid : out std_logic;
            axi_arready : in std_logic;
            axi_rid : in std_logic_vector(0 downto 0);
            axi_rdata : in std_logic_vector(cpu_data_width-1 downto 0);
            axi_rresp : in std_logic_vector(1 downto 0);
            axi_rlast : in std_logic;
            axi_ruser : in std_logic_vector(axi_ruser_width-1 downto 0);
            axi_rvalid : in std_logic;
            axi_rready : out std_logic;
            error_data : out std_logic_vector(3 downto 0) := (others=>'0') );
    end component;
    component plasoc_cpu_axi4_write_cntrl is
        generic(
            cpu_address_width : integer := 16;
            cpu_data_width : integer := 32;
            cache_offset_width : integer := 5;
            axi_awuser_width : integer := 0;
            axi_wuser_width : integer := 0;
            axi_buser_width : integer := 0);
        port(
            clock : in std_logic;
            nreset : in std_logic;
            mem_write_address : in std_logic_vector(cpu_address_width-1 downto 0);
            mem_write_data : in std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
            mem_write_strobe : in std_logic_vector(cpu_data_width/8-1 downto 0);
            mem_write_enable : in std_logic;
            mem_write_valid : in std_logic;
            mem_write_ready  : out std_logic;
            cache_cacheable : in std_logic;
            axi_awid : out std_logic_vector(0 downto 0);
            axi_awaddr : out std_logic_vector(cpu_address_width-1 downto 0);
            axi_awlen : out std_logic_vector(7 downto 0);
            axi_awsize : out std_logic_vector(2 downto 0);
            axi_awburst : out std_logic_vector(1 downto 0);
            axi_awlock : out std_logic;
            axi_awcache : out std_logic_vector(3 downto 0);
            axi_awprot : out std_logic_vector(2 downto 0);
            axi_awqos : out std_logic_vector(3 downto 0);
            axi_awregion : out std_logic_vector(3 downto 0);
            axi_awuser : out std_logic_vector(axi_awuser_width-1 downto 0);
            axi_awvalid : out std_logic;
            axi_awready : in std_logic;
            axi_wdata : out std_logic_vector(cpu_data_width-1 downto 0);
            axi_wstrb : out std_logic_vector(cpu_data_width/8-1 downto 0);
            axi_wlast : out std_logic;
            axi_wuser : out std_logic_vector(axi_wuser_width-1 downto 0);
            axi_wvalid : out std_logic;
            axi_wready : in std_logic;
            axi_bid : in std_logic_vector(0 downto 0);
            axi_bresp : in  std_logic_vector(1 downto 0);
            axi_buser : in std_logic_vector(axi_buser_width-1 downto 0);
            axi_bvalid : in std_logic;
            axi_bready : out std_logic;
            error_data : out std_logic_vector(2 downto 0) := (others=>'0'));
    end component;
    -- Constants and type definitions.
    constant cpu_width : integer := 32;
    constant cpu_memory_type     : string  := "DUAL_PORT_"; 
    constant cpu_pipeline_stages : natural := 3; 
    constant cache_tag_width : integer := cache_address_width-cache_index_width-cache_offset_width;
    constant cache_word_offset_width : integer := cache_offset_width-clogb2(cpu_width/8);
    constant cache_line_width : integer := (cache_tag_width+8*2**cache_offset_width);
    constant axi_user_width : integer := 1;
    subtype cache_index_type is std_logic_vector(cache_index_width-1 downto 0);
    subtype cache_data_type is std_logic_vector(cache_line_width*2**cache_way_width-1 downto 0);
    subtype cache_write_block_enable_type is std_logic_vector(2**(cache_way_width+cache_word_offset_width)-1 downto 0);
    -- CPU interface signals.
    signal cpu_write_data : std_logic_vector(cpu_width-1 downto 0);
    signal cpu_read_data : std_logic_vector(cpu_width-1 downto 0);
    signal cpu_address_next : std_logic_vector(cpu_width-1 downto 0);
    signal cpu_strobe_next : std_logic_vector(cpu_width/8-1 downto 0); 
    signal cpu_pause    : std_logic;
    -- Cache interface signals.
    signal cache_write_index : cache_index_type;
    signal cache_write_data : cache_data_type := (others=>'0');
    signal cache_write_tag_enable : std_logic_vector(2**cache_way_width-1 downto 0);
    signal cache_write_block_enable : cache_write_block_enable_type;
    signal cache_read_index : cache_index_type;
    signal cache_read_data :cache_data_type := (others=>'0');
    signal cache_cacheable : std_logic;
    -- Memory interface signals
    signal mem_in_address : std_logic_vector(cpu_width-1 downto 0);
    signal mem_in_data : std_logic_vector(cpu_width-1 downto 0);
    signal mem_in_enable : std_logic;
    signal mem_in_valid : std_logic;
    signal mem_in_ready : std_logic;
    signal mem_out_address : std_logic_vector(cpu_width-1 downto 0);
    signal mem_out_data : std_logic_vector(cpu_width-1 downto 0);
    signal mem_out_strobe : std_logic_vector(cpu_width/8-1 downto 0);
    signal mem_out_enable : std_logic;
    signal mem_out_valid : std_logic;
    signal mem_out_ready : std_logic;
    -- Attributes.
    attribute keep : boolean;
    attribute keep of cpu_write_data : signal is true;
    attribute keep of cpu_read_data : signal is true;
    attribute keep of cpu_address_next : signal is true;
    attribute keep of cpu_strobe_next : signal is true;
    attribute keep of cpu_pause : signal is true;
    
--    attribute keep of mem_out_address : signal is true;
--    attribute keep of mem_out_data : signal is true;
--    attribute keep of mem_out_strobe : signal is true;
--    attribute keep of mem_out_enable : signal is true;
--    attribute keep of mem_out_valid : signal is true;
--    attribute keep of mem_out_ready : signal is true;
    
--    attribute keep of mem_in_address : signal is true;
--    attribute keep of mem_in_data : signal is true;
--    attribute keep of mem_in_enable : signal is true;
--    attribute keep of mem_in_valid : signal is true;
--    attribute keep of mem_in_ready : signal is true;
    
begin
    cpu_address_next(1 downto 0) <= "00";
    -- CPU instantiation.
    mlite_cpu_inst:  
    mlite_cpu 
        generic map (
            memory_type => cpu_memory_type,
            mult_type => cpu_mult_type,
            shifter_type => cpu_shifter_type,
            alu_type => cpu_alu_type,
            pipeline_stages => cpu_pipeline_stages )
        port map (
            clk => aclk,
            reset_in => "not" (aresetn),
            intr_in => intr_in,
            address_next => cpu_address_next(cpu_width-1 downto 2),
            byte_we_next => cpu_strobe_next,
            address => open,
            byte_we => open,
            data_w => cpu_write_data,
            data_r => cpu_read_data,
            mem_pause => cpu_pause );
    -- If cache is enabled, instantiate controller and buffer.
    gen_cache :
    if cache_enable=True generate
        -- Cache controller instantiation.
        plasoc_cpu_l1_cache_cntrl_inst: 
        plasoc_cpu_l1_cache_cntrl 
            generic map (
                cpu_address_width => cpu_width,
                cpu_data_width => cpu_width,
                cache_address_width => cache_address_width,
                cache_way_width => cache_way_width, 
                cache_index_width => cache_index_width,
                cache_offset_width => cache_offset_width,
                cache_replace_strat => cache_replace_strat,
                cache_base_address => cache_base_address)
             port map ( 
                clock => aclk,
                resetn => aresetn,
                cpu_address => cpu_address_next,
                cpu_in_data => cpu_write_data,
                cpu_out_data => cpu_read_data,
                cpu_strobe => cpu_strobe_next,
                cpu_pause => cpu_pause,
                cache_cacheable => cache_cacheable,
                cache_out_address => cache_write_index,
                cache_out_data => cache_write_data,
                cache_out_tag_enable => cache_write_tag_enable,
                cache_out_block_enable => cache_write_block_enable,
                cache_in_address => cache_read_index,
                cache_in_data => cache_read_data,
                mem_in_address => mem_in_address,
                mem_in_data => mem_in_data,
                mem_in_enable => mem_in_enable,
                mem_in_valid => mem_in_valid,
                mem_in_ready => mem_in_ready,
                mem_out_address => mem_out_address,
                mem_out_data => mem_out_data,
                mem_out_strobe => mem_out_strobe,
                mem_out_enable => mem_out_enable,
                mem_out_valid => mem_out_valid,
                mem_out_ready => mem_out_ready);
        -- Cache buffer instantiation.
        plasoc_cpu_l1_cache_buff_inst : 
        plasoc_cpu_l1_cache_buff 
            generic map (
                glb_data_width => cpu_width,
                cache_tag_width => cache_tag_width,
                cache_index_width => cache_index_width,
                cache_offset_width => cache_offset_width,
                cache_way_width => cache_way_width )
            port map (
                clock => aclk,
                cache_in_data => cache_write_data,
                cache_in_index => cache_write_index,
                cache_in_tag_enable => cache_write_tag_enable,
                cache_in_offset_enable => cache_write_block_enable,
                cache_out_data => cache_read_data,
                cache_out_index => cache_read_index);
    end generate;
    -- If cache is disabled, instantiate memory controller.
    gen_no_cache :
    if cache_enable=False generate
        -- Memory controller instantiation.
        plasoc_cpu_mem_cntrl_inst :
        plasoc_cpu_mem_cntrl 
            generic map (
                cpu_address_width => cpu_width,
                cpu_data_width => cpu_width )
            port map (
                clock => aclk,
                resetn => aresetn,
                cpu_address => cpu_address_next,
                cpu_in_data => cpu_write_data,
                cpu_out_data => cpu_read_data,
                cpu_strobe => cpu_strobe_next,
                cpu_pause => cpu_pause,
                cache_cacheable => cache_cacheable,
                mem_in_address => mem_in_address,
                mem_in_data => mem_in_data,
                mem_in_enable => mem_in_enable,
                mem_in_valid => mem_in_valid,
                mem_in_ready => mem_in_ready,
                mem_out_address => mem_out_address,
                mem_out_data => mem_out_data,
                mem_out_strobe => mem_out_strobe,
                mem_out_enable => mem_out_enable,
                mem_out_valid => mem_out_valid,
                mem_out_ready => mem_out_ready);
    end generate;
    -- axi write controller.
    plasoc_cpu_axi4_write_cntrl_inst : 
    plasoc_cpu_axi4_write_cntrl 
        generic map (
            cpu_address_width => cpu_width,
            cpu_data_width => cpu_width,
            cache_offset_width => cache_offset_width,
            axi_awuser_width => axi_user_width,
            axi_wuser_width => axi_user_width,
            axi_buser_width => axi_user_width)
        port map (
            clock => aclk,
            nreset => aresetn,
            mem_write_address => mem_out_address,
            mem_write_data => mem_out_data,
            mem_write_strobe => mem_out_strobe,
            mem_write_enable => mem_out_enable,
            mem_write_valid => mem_out_valid,
            mem_write_ready => mem_out_ready,
            cache_cacheable => cache_cacheable,
            axi_awid => axi_awid,
            axi_awaddr => axi_awaddr,
            axi_awlen => axi_awlen,
            axi_awsize => axi_awsize,
            axi_awburst => axi_awburst,
            axi_awlock => axi_awlock,
            axi_awcache => axi_awcache,
            axi_awprot => axi_awprot,
            axi_awqos => axi_awqos,
            axi_awregion => axi_awregion,
            axi_awuser => open,
            axi_awvalid => axi_awvalid,
            axi_awready => axi_awready,
            axi_wdata => axi_wdata,
            axi_wstrb => axi_wstrb,
            axi_wlast => axi_wlast,
            axi_wuser => open,
            axi_wvalid => axi_wvalid,
            axi_wready => axi_wready,
            axi_bid => axi_bid,
            axi_bresp => axi_bresp,
            axi_buser => (others=>'0'),
            axi_bvalid => axi_bvalid,
            axi_bready => axi_bready,
            error_data => open);
    -- axi read controller.
    plasoc_cpu_axi4_read_cntrl_inst :
    plasoc_cpu_axi4_read_cntrl 
        generic map (
            cpu_address_width => cpu_width,
            cpu_data_width => cpu_width,
            cache_offset_width => cache_offset_width,
            axi_aruser_width => axi_user_width,
            axi_ruser_width => axi_user_width)
        port map (
            clock => aclk,
            nreset => aresetn,
            mem_read_address => mem_in_address,
            mem_read_data => mem_in_data,
            mem_read_enable => mem_in_enable,
            mem_read_valid => mem_in_valid,
            mem_read_ready => mem_in_ready,
            cache_cacheable => cache_cacheable,
            axi_arid => axi_arid,
            axi_araddr => axi_araddr,
            axi_arlen => axi_arlen,
            axi_arsize => axi_arsize,
            axi_arburst => axi_arburst,
            axi_arlock => axi_arlock,
            axi_arcache => axi_arcache,
            axi_arprot => axi_arprot,
            axi_arqos => axi_arqos,
            axi_arregion => axi_arregion,
            axi_aruser => open,
            axi_arvalid => axi_arvalid,
            axi_arready => axi_arready,
            axi_rid => axi_rid,
            axi_rdata => axi_rdata,
            axi_rresp => axi_rresp,
            axi_rlast => axi_rlast,
            axi_ruser => (others=>'0'),
            axi_rvalid => axi_rvalid,
            axi_rready => axi_rready,
            error_data => open);
end Behavioral;
