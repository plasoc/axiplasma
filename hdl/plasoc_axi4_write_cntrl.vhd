
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use work.mlitesoc_pack.all;

entity plasoc_axi4_write_cntrl is
    generic(
        -- cpu constants
        cpu_address_width : integer := 16;
        cpu_data_width : integer := 32;
        -- cache constants
        cache_offset_width : integer := 5;
        -- axi read constants
        axi_awuser_width : integer := 0;
        axi_wuser_width : integer := 0;
        axi_buser_width : integer := 0);
    port(
        -- global interfaces.
        clock : in std_logic;
        nreset : in std_logic;
        -- mem write interface.
        mem_write_address : in std_logic_vector(cpu_address_width-1 downto 0);
        mem_write_data : in std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
        mem_write_strobe : in std_logic_vector(cpu_data_width/8-1 downto 0);
        mem_write_enable : in std_logic;
        mem_write_valid : in std_logic;
        mem_write_ready  : out std_logic;
        -- cache interface.
        cache_cacheable : in std_logic;
        -- axi write interface.
        axi_awid : out std_logic_vector(0 downto 0);
        axi_awaddr : out std_logic_vector(cpu_address_width-1 downto 0);
        axi_awlen : out std_logic_vector(7 downto 0);
        axi_awsize : out std_logic_vector(2 downto 0);
        axi_awburst : out std_logic_vector(1 downto 0);
        axi_awcache : out std_logic_vector(3 downto 0);
        axi_awprot : out std_logic_vector(2 downto 0);
        axi_awqos : out std_logic_vector(3 downto 0);
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
        axi_bready : out std_logic);
end plasoc_axi4_write_cntrl;

architecture Behavioral of plasoc_axi4_write_cntrl is

begin


end Behavioral;
