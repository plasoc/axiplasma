-------------------------------------------------------
--! @author Andrew Powell
--! @date January 7, 2017
--! @brief Contains the package referenced by the cores
--! defined for the Plasma-SoC.
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--! This package contains the default parameters, component declarations,
--! and uitility functions necessary for the cores created for the Plasma-SoC. 
--!
--! Many changes with this package will occur overtime with the progression of the 
--! Plasma-SoC project. At some point, packages will be defined separately for each
--! core whose component declaration is located within this package.
package plasoc_pack is

	-- Default CPU parameters. These values are modifiable. At this current time, 
	-- though, some parameter combinations are incompatible. If these parameters are 
	-- modified, though, modifications will also be necessary for the corresponding header file 
	-- for the CPU. 
    constant default_cpu_mult_type       : string  := "DEFAULT"; 						--! Defines the default Plasma Mlite multiplier type. The possible options are "DEFAULT" and "AREA_OPTIMIZED".
    constant default_cpu_shifter_type    : string  := "DEFAULT"; 						--! Defines the default Plasma Mlite shifter type. The possible options are "DEFAULT" and "AREA_OPTIMIZED".
    constant default_cpu_alu_type        : string  := "DEFAULT"; 						--! Defines the default Plasma Mlite ALU type. The possible options are "DEFAULT" and "AREA_OPTIMIZED".
    constant default_cache_address_width : integer := 12;								--! Defines the default address width of the cacheable addresses.
    constant default_cache_way_width : integer := 2; 									--! Associativity = 2^default_cache_way_width.	
    constant default_cache_index_width : integer := 4;									--! Cache Size (rows) = 2^default_cache_index_width.
    constant default_cache_offset_width : integer := 5;									--! Line Size (bytes) = 2^default_cache_offset_width.
    constant default_cache_replace_strat : string := "plru";							--! Defines the default replacement strategy in case of miss. Only "plru" is available.
    constant default_cache_base_address : std_logic_vector := X"10000000";				--! Defines the default base address of the cache controller registers.
    constant default_cache_enable : boolean := False;									--! Defines whether or not the cache is enabled by default. 	
    
	-- Default Interrupt Controller parameters. These values are modifiable. If these parameters are 
	-- modified, though, modifications will also be necessary for the corresponding header file. 
    constant default_interrupt_total : integer := 8;                                    --! Defines the default number of available device interrupts.
    constant default_int_id_offset : integer := 4;                                      --! For the Interrupt Identifier register, defines the default offset from the Interrupt Controller's axi_base_address.				
    constant default_int_enables_offset : integer := 0;                                 --! For the Interrupt Enables register, defines the default offset from the instantiations's base address.
    constant default_int_active_address : integer := 8;                                 --! For the Interrupt Active register, defines the default offset from the instantiations's base address.
    
	-- Default Interrupt Controller parameters. These values are modifiable. If these parameters are 
	-- modified, though, modifications will also be necessary for the corresponding header file. 
    constant default_timer_width : integer := 32;                                       --! Defines the width of the timer's Trigger and Tick Value registers.
    constant default_timer_axi_control_offset : integer := 0;                           --! For the Control register, defines the default offset from the instantiation's base address
    constant default_timer_axi_control_start_bit_loc : integer := 0;                    --! For the Start bit, defines the bit location in the Control register.
    constant default_timer_axi_control_reload_bit_loc : integer := 1;                   --! For the Reload bit, defines the bit location in the Control register.
    constant default_timer_axi_control_ack_bit_loc : integer := 2;                      --! For the Ack bit, defines the bit location in the Control register.
    constant default_timer_axi_control_done_bit_loc : integer := 3;                     --! For the Done bit, defines the bit location in the Control register.
    constant default_timer_axi_trig_value_offset : integer := 4;                        --! For the Trigger Value register, defines the default offset from the instantiation's base address.
    constant default_timer_axi_tick_value_offset : integer := 8;                        --! For the Tick Value register, defines the default offset from the instantiation's base address.
    
    constant error_axi_read_exokay : integer := 0;
    constant error_axi_read_slverr : integer := 1;
    constant error_axi_read_decerr : integer := 2;
    constant error_axi_read_rlast : integer := 3;
    constant error_axi_read_id : integer := 4;
    
    subtype axi_resp_type is std_logic_vector(1 downto 0);
    constant axi_lock_normal_access : std_logic := '0';
    constant axi_burst_incr : std_logic_vector(1 downto 0) := "01";
    constant axi_resp_okay : axi_resp_type := "00";
    constant axi_resp_exokay : axi_resp_type := "01";
    constant axi_resp_slverr : axi_resp_type := "10";
    constant axi_resp_decerr : axi_resp_type := "11";
    constant axi_cache_device_nonbufferable : std_logic_vector(3 downto 0) := "0000"; 
    constant axi_prot_priv : std_logic := '1';
    constant axi_prot_sec : std_logic := '0';
    constant axi_prot_instr : std_logic := '1';

    function clogb2(bit_depth : in integer ) return integer;
    function add_offset2base( base_address : in std_logic_vector; offset : in integer ) return std_logic_vector;
    function remove_baseFaddress(  address : in std_logic_vector; base_address : in std_logic_vector ) return std_logic_vector;

    component plasoc_cpu is
        generic(
            -- cpu constants
            cpu_mult_type       : string  := default_cpu_mult_type; -- DEFAULT --AREA_OPTIMIZED
            cpu_shifter_type    : string  := default_cpu_shifter_type; -- DEFAULT --AREA_OPTIMIZED
            cpu_alu_type        : string  := default_cpu_alu_type; --DEFAULT --AREA_OPTIMIZED
            -- cache constants
            cache_address_width : integer := default_cache_address_width;
            cache_way_width : integer := default_cache_way_width; 
            cache_index_width : integer := default_cache_index_width;
            cache_offset_width : integer := default_cache_offset_width;
            cache_replace_strat : string := default_cache_replace_strat;
            cache_base_address : std_logic_vector := default_cache_base_address;
            cache_enable : boolean := default_cache_enable );
        port(
            -- global signals
            aclk : in std_logic;
            aresetn     : in std_logic;
            -- axi write interface.
            axi_awid : out std_logic_vector(0 downto 0);
            axi_awaddr : out std_logic_vector(31 downto 0);
            axi_awlen : out std_logic_vector(7 downto 0);
            axi_awsize : out std_logic_vector(2 downto 0);
            axi_awburst : out std_logic_vector(1 downto 0);
            axi_awlock : out std_logic;
            axi_awcache : out std_logic_vector(3 downto 0);
            axi_awprot : out std_logic_vector(2 downto 0);
            axi_awqos : out std_logic_vector(3 downto 0);
            axi_awregion : out std_logic_vector(3 downto 0);
            axi_awvalid : out std_logic;
            axi_awready : in std_logic;
            axi_wdata : out std_logic_vector(31 downto 0);
            axi_wstrb : out std_logic_vector(3 downto 0);
            axi_wlast : out std_logic;
            axi_wvalid : out std_logic;
            axi_wready : in std_logic;
            axi_bid : in std_logic_vector(0 downto 0);
            axi_bresp : in  std_logic_vector(1 downto 0);
            axi_bvalid : in std_logic;
            axi_bready : out std_logic;
            -- axi read interface.
            axi_arid : out std_logic_vector(0 downto 0);
            axi_araddr : out std_logic_vector(31 downto 0);
            axi_arlen : out std_logic_vector(7 downto 0);
            axi_arsize : out std_logic_vector(2 downto 0);
            axi_arburst : out std_logic_vector(1 downto 0);
            axi_arlock : out std_logic;
            axi_arcache : out std_logic_vector(3 downto 0);
            axi_arprot : out std_logic_vector(2 downto 0);
            axi_arqos : out std_logic_vector(3 downto 0);
            axi_arregion : out std_logic_vector(3 downto 0);
            axi_arvalid : out std_logic;
            axi_arready : in std_logic;
            axi_rid : in std_logic_vector(0 downto 0);
            axi_rdata : in std_logic_vector(31 downto 0);
            axi_rresp : in std_logic_vector(1 downto 0);
            axi_rlast : in std_logic;
            axi_rvalid : in std_logic;
            axi_rready : out std_logic;
            -- cpu signals
            intr_in      : in std_logic);
    end component;
    
    component plasoc_int is
        generic(
            -- axi parameters.
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            axi_base_address : std_logic_vector := X"0000";
            axi_int_id_offset : integer := default_int_id_offset;
            axi_int_enables_offset : integer := default_int_enables_offset;
            axi_int_active_offset : integer := default_int_active_address;
            -- interrupt controller parameters.
            interrupt_total : integer := default_interrupt_total);
        port(
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
            -- axi read interface.
            axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
            axi_arprot : in std_logic_vector(2 downto 0);
            axi_arvalid : in std_logic;
            axi_arready : out std_logic;
            axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
            axi_rvalid : out std_logic;
            axi_rready : in std_logic;
            axi_rresp : out std_logic_vector(1 downto 0);
            -- cpu interface.
            cpu_int : out std_logic;
            -- dev interface.
            dev_ints : in std_logic_vector(interrupt_total-1 downto 0));
        end component;
        
    component plasoc_timer is
        generic (
            -- timer parameters.
            timer_width : integer := default_timer_width;
            -- axi parameters.
            axi_address_width : integer := 16;
            axi_data_width : integer := 32;
            axi_base_address : std_logic_vector := X"0000";
            axi_control_offset : integer := default_timer_axi_control_offset;
            axi_control_start_bit_loc : integer := default_timer_axi_control_start_bit_loc;
            axi_control_reload_bit_loc : integer := default_timer_axi_control_reload_bit_loc;
            axi_control_ack_bit_loc : integer := default_timer_axi_control_ack_bit_loc;
            axi_control_done_bit_loc : integer := default_timer_axi_control_done_bit_loc;
            axi_trig_value_offset : integer := default_timer_axi_trig_value_offset;
            axi_tick_value_offset : integer := default_timer_axi_tick_value_offset);
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
            -- axi read interface.
            axi_araddr : in std_logic_vector(axi_address_width-1 downto 0);
            axi_arprot : in std_logic_vector(2 downto 0);
            axi_arvalid : in std_logic;
            axi_arready : out std_logic;
            axi_rdata : out std_logic_vector(axi_data_width-1 downto 0) := (others=>'0');
            axi_rvalid : out std_logic;
            axi_rready : in std_logic;
            axi_rresp : out std_logic_vector(1 downto 0);
            -- timer controller interface.
            done : out std_logic);
    end component;

end; --package body

package body plasoc_pack is

	function clogb2(bit_depth : in natural ) return integer is
		variable result : integer := 0;
		variable bit_depth_buff : integer := bit_depth;
	begin
		while bit_depth_buff>1 loop
			bit_depth_buff := bit_depth_buff/2;
			result := result+1;
		end loop; 
		return result;
	end; --function
	
	function add_offset2base( base_address : in std_logic_vector; offset : in integer ) return std_logic_vector is
        variable result : std_logic_vector(base_address'length-1 downto 0);
    begin
        result := std_logic_vector(to_unsigned(to_integer(unsigned(base_address))+offset,base_address'length));
        return result;
    end;
    
    function remove_baseFaddress(  address : in std_logic_vector; base_address : in std_logic_vector ) return std_logic_vector is
        variable result : std_logic_vector(base_address'length-1 downto 0);
        variable address_0 : integer :=  to_integer(unsigned(address));
        variable base_address_0 : integer :=  to_integer(unsigned(base_address));
    begin
        result := std_logic_vector(to_unsigned(address_0-base_address_0,base_address'length));
        return result;
    end;

end; --package body
