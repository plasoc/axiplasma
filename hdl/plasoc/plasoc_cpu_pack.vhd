library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

package plasoc_cpu_pack is

    -- Default parameters.
    constant default_cpu_mult_type       : string  := "DEFAULT";
    constant default_cpu_shifter_type    : string  := "DEFAULT";
    constant default_cpu_alu_type        : string  := "DEFAULT";
    constant default_cache_address_width : integer := 25;
    constant default_cache_way_width : integer := 1;
    constant default_cache_index_width : integer := 6;
    constant default_cache_offset_width : integer := 4;
    constant default_cache_replace_strat : string := "rr";
    constant default_cache_enable : boolean := True;
    constant default_oper_base : std_logic_vector := X"ffffff";
    constant default_oper_invalidate_offset : integer := 0;
    constant default_oper_flush_offset : integer := 4;
    
    -- AXI4-Full error constants.
    constant error_axi_read_exokay : integer := 0;
    constant error_axi_read_slverr : integer := 1;
    constant error_axi_read_decerr : integer := 2;
    constant error_axi_read_rlast : integer := 3;
    constant error_axi_read_id : integer := 4;
    
    -- AXI4-Full constants.
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
    
    -- Function declarations.
    function clogb2(bit_depth : in integer ) return integer;
    function add_offset2base( base_address : in std_logic_vector; offset : in integer ) return std_logic_vector;
    
    -- Component declaration.
    component plasoc_cpu is
        generic(
            cpu_mult_type       : string  := default_cpu_mult_type;
            cpu_shifter_type    : string  := default_cpu_shifter_type;
            cpu_alu_type        : string  := default_cpu_alu_type;
            cache_address_width : integer := default_cache_address_width;
            cache_way_width : integer := default_cache_way_width; 
            cache_index_width : integer := default_cache_index_width;
            cache_offset_width : integer := default_cache_offset_width;
            cache_replace_strat : string := default_cache_replace_strat;
            cache_enable : boolean := default_cache_enable;
            oper_base : std_logic_vector := default_oper_base;
            oper_invalidate_offset : integer := default_oper_invalidate_offset;
            oper_flush_offset : integer := default_oper_flush_offset );
        port(
            aclk : in std_logic;
            aresetn     : in std_logic;
            axi_awid : out std_logic_vector(-1 downto 0);
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
            axi_bid : in std_logic_vector(-1 downto 0);
            axi_bresp : in  std_logic_vector(1 downto 0);
            axi_bvalid : in std_logic;
            axi_bready : out std_logic;
            axi_arid : out std_logic_vector(-1 downto 0);
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
            axi_rid : in std_logic_vector(-1 downto 0);
            axi_rdata : in std_logic_vector(31 downto 0);
            axi_rresp : in std_logic_vector(1 downto 0);
            axi_rlast : in std_logic;
            axi_rvalid : in std_logic;
            axi_rready : out std_logic;
            intr_in      : in std_logic);
    end component;
end;

package body plasoc_cpu_pack is

    function flogb2(bit_depth : in natural ) return integer is
		variable result : integer := 0;
		variable bit_depth_buff : integer := bit_depth;
	begin
		while bit_depth_buff>1 loop
			bit_depth_buff := bit_depth_buff/2;
			result := result+1;
		end loop; 
		return result;
	end function flogb2; 
	
	function clogb2 (bit_depth : in natural ) return natural is
        variable result : integer := 0;
    begin
        result := flogb2(bit_depth);
        if (bit_depth > (2**result)) then
            return(result + 1);
        else
            return result;
        end if;
    end function clogb2;
	
	function add_offset2base( base_address : in std_logic_vector; offset : in integer ) return std_logic_vector is
        variable result : std_logic_vector(base_address'length-1 downto 0);
    begin
        result := std_logic_vector(to_unsigned(to_integer(unsigned(base_address))+offset,base_address'length));
        return result;
    end;

end; 
