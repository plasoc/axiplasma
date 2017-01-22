---------------------------------------------------------------------
-- TITLE: L1 Cache Controller of Plasma-SoC Baseline Processor 
-- AUTHOR: Andrew Powell (andrewandrepowell2@gmail.com)
-- DATE CREATED: 1/07/2017
-- FILENAME: l1_cache_cntrl.vhd
-- PROJECT: Plasma-SoC core (extension of the Plasma CPU project)
-- COPYRIGHT: Software placed into the public domain by the author.
--    Software 'as is' without warranty.  Author liable for nothing.
-- DESCRIPTION:
--    Defines the L1 Write-Back Cache Controller. So far, the only
--    replacement policy implemented is pseudo least recently used,
--    so far there is no way to directly invalidate the cache.
---------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use work.mlitesoc_pack.all;

entity l1_cache_cntrl is
    generic (
        -- cpu constants
        cpu_address_width : integer := 16;
        cpu_data_width : integer := 32;
        -- cache constants
        cache_address_width : integer := 10;
        cache_way_width : integer := 1; 
        cache_index_width : integer := 4;
        cache_offset_width : integer := 4;
        cache_replace_strat : string := "plru";
        cache_base_address : std_logic_vector := X"0000" ); 
    port ( 
        -- global interface.
        clock : in std_logic; 
        resetn : in std_logic;
        -- cpu interface.
        cpu_address : in std_logic_vector(cpu_address_width-1 downto 0); 
        cpu_in_data : in std_logic_vector(cpu_data_width-1 downto 0);
        cpu_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
        cpu_strobe : in std_logic_vector(cpu_data_width/8-1 downto 0);
        cpu_pause : out std_logic;
        -- cache interface.
        cache_out_address: out std_logic_vector(cache_index_width-1 downto 0);
        cache_out_data : out std_logic_vector(((cache_address_width-cache_index_width-cache_offset_width)+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
        cache_out_tag_enable : out std_logic_vector(2**cache_way_width-1 downto 0);
        cache_out_block_enable : out std_logic_vector(2**cache_way_width*2**cache_offset_width/(cpu_data_width/8)-1 downto 0);
        cache_in_address : out std_logic_vector(cache_index_width-1 downto 0);
        cache_in_data : in std_logic_vector(((cache_address_width-cache_index_width-cache_offset_width)+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
        -- simple mem interface
        mem_in_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
        mem_in_data : in std_logic_vector(cpu_data_width-1 downto 0);
        mem_in_enable : out std_logic;
        mem_in_valid : in std_logic;
        mem_in_ready : out std_logic;
        mem_out_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
        mem_out_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
        mem_out_strobe : out std_logic_vector(cpu_data_width/8-1 downto 0) := (others=>'0');
        mem_out_enable : out std_logic;
        mem_out_valid : out std_logic;
        mem_out_ready : in std_logic); 
end l1_cache_cntrl;

architecture Behavioral of l1_cache_cntrl is
    function cache_plru_width return integer is
    	variable result : integer := 0;
    begin
        if cache_way_width/=0 then
            for each_way in 1 to 2**cache_way_width/2 loop
                result := result+each_way;
            end loop; 
        end if;
        return result;
    end; 
    function is_cacheable( address : in std_logic_vector ) return boolean is
        variable result : boolean;
    begin
        if or_reduce(address(cpu_address_width-1 downto cache_address_width))='1' then
            return False;
        else 
            return True;
        end if;
    end;
    constant cache_word_offset_width : integer := cache_offset_width-clogb2(cpu_data_width/8);
    constant cache_tag_width : integer := cache_address_width-cache_index_width-cache_offset_width;
    constant cache_line_width : integer := cache_tag_width+8*2**cache_offset_width;
    constant cache_lineset_width : integer := cache_line_width*2**cache_way_width;
    constant cache_write_zeros : std_logic_vector(cpu_data_width/8-1 downto 0) := (others=>'0');
    constant cache_invalidate_offset : integer := 0;
    constant cache_flush_offset : integer := 4;
    constant cache_invalidate_address : std_logic_vector := add_offset2base(cache_base_address,cache_invalidate_offset);
    constant cache_flush_address : std_logic_vector := add_offset2base(cache_base_address,cache_flush_offset);
    subtype byte_type is std_logic_vector(7 downto 0);
    subtype word_type is std_logic_vector(cpu_data_width-1 downto 0);
    subtype cache_tag_type is std_logic_vector(cache_tag_width-1 downto 0);
    subtype cache_index_type is std_logic_vector(cache_index_width-1 downto 0);
    subtype cache_offset_type is std_logic_vector(cache_offset_width-1 downto 0);
    subtype cache_word_offset_type is std_logic_vector(cache_word_offset_width-1 downto 0);
    subtype cache_valid_type is std_logic;
    subtype cache_plruset_type is std_logic_vector(cache_plru_width-1 downto 0);
    subtype cache_line_type is std_logic_vector(cache_line_width-1 downto 0);
    subtype cache_way_type is integer range 0 to 2**cache_way_width-1;
    subtype cache_valid_enable_type is std_logic_vector(2**cache_way_width-1 downto 0);
    subtype cache_plru_enable_type is std_logic;
    subtype cache_tag_enable_type is std_logic_vector(2**cache_way_width-1 downto 0);
    subtype cache_block_enable_type is std_logic_vector(2**cache_way_width*2**cache_word_offset_width-1 downto 0);
    type cache_tagset_type is array(0 to 2**cache_way_width-1) of cache_tag_type;
    type cache_block_type is array(0 to 2**cache_word_offset_width-1) of word_type;
    type cache_blockset_type is array(0 to 2**cache_way_width-1) of cache_block_type;
    type cache_validset_type is array(0 to 2**cache_way_width-1) of cache_valid_type;
    type cache_validsets_type is array(0 to 2**cache_index_width-1) of cache_validset_type;
    type cache_plrusets_type is array(0 to 2**cache_index_width-1) of cache_plruset_type;
    type cache_state_type is (cache_state_run,cache_state_mem);
    signal cpu_pause_buff : std_logic := '0';
    signal cpu_pause_buff_0 : std_logic := '0';
    signal cpu_pause_delayed : boolean;
    signal cpu_access_write : boolean;
    signal cache_noncacheable : boolean;
    signal cache_tag : cache_tag_type;
    signal cache_index : cache_index_type;
    signal cache_word_offset : cache_word_offset_type;
    signal cache_in_tagset : cache_tagset_type := (others=>(others=>'0'));
    signal cache_in_blockset : cache_blockset_type := (others=>(others=>(others=>'0')));
    signal cache_in_validset : cache_validset_type := (others=>'0');
    signal cache_in_plruset : cache_plruset_type := (others=>'0');
    signal cache_out_tagset : cache_tagset_type := (others=>(others=>'0'));
    signal cache_out_blockset : cache_blockset_type := (others=>(others=>(others=>'0')));
    signal cache_out_validset : cache_validset_type := (others=>'0');
    signal cache_out_plruset : cache_plruset_type := (others=>'0');
    signal cache_out_valid_enable : cache_valid_enable_type := (others=>'0');
    signal cache_out_plru_enable : cache_plru_enable_type := '0';
    signal cache_validsets : cache_validsets_type := (others=>(others=>'0'));
    signal cache_plrusets : cache_plrusets_type := (others=>(others=>'0'));
    signal cache_hit : boolean;
    signal cache_invalidate : boolean;
    signal cache_invalidate_enable : boolean := False;
    signal cache_flush : boolean;
    signal cache_flush_enable : boolean := False;
    signal cache_oper_tag : cache_tag_type := (others=>'0');
    signal cache_oper_index : cache_index_type := (others=>'0');
    signal cache_oper : boolean;
    signal cache_way : cache_way_type;
    signal cache_way_replace : cache_way_type;
    signal cache_plruset_replace : cache_plruset_type;
    signal cache_strobe_replace : std_logic_vector(cpu_data_width/8-1 downto 0) := (others=>'0');
    signal cache_state : cache_state_type := cache_state_run;
    signal mem_in_ready_buff : std_logic := '0';
    signal mem_out_valid_buff : std_logic := '0';
    signal mem_write_needed : boolean;
    signal mem_read_needed : boolean;
    signal mem_write_counter : integer range 0 to 2**cache_offset_width;
    signal mem_read_counter : integer range 0 to 2**cache_offset_width;
    signal mem_way_replace : cache_way_type;
    signal mem_tag_replace : cache_tag_type;
--    attribute keep : string;
--    attribute keep of cache_way_replace : signal is "true";
--    attribute keep of cache_plruset_replace : signal is "true";
begin
    -- Set CPU pause signal to stall CPU when necessary.
    cpu_pause <= cpu_pause_buff;
    -- Set input cache lineset based on current index.
    cache_in_address <= cache_index;
    -- Acquire cache look-up control information from CPU address.
    cache_tag <= cpu_address(cache_address_width-1 downto cache_address_width-cache_tag_width);
    cache_index <= cpu_address(cache_address_width-cache_tag_width-1 downto cache_offset_width);
    cache_word_offset <= cpu_address(cache_offset_width-1 downto clogb2(cpu_data_width/8));
    -- Set cache operation control signals.
    cache_invalidate <= True when cpu_address=cache_invalidate_address else False;
    cache_flush <= True when cpu_address=cache_flush_address else False;
    cache_oper <= True when (cache_oper_tag=cache_tag and cache_oper_index=cache_index) and (cache_flush_enable or cache_invalidate_enable) else False;
    -- Determine whether or not the memory access is cacheable.
    cache_noncacheable <= not is_cacheable(cpu_address);
    -- Determine whether or not the memory access from the CPU is write or read.
    cpu_access_write <= True when or_reduce(cpu_strobe)='1' else False;
    -- Set main memory access control signals.
    --mem_in_address(cpu_address_width-1 downto cache_address_width) <= (others=>'0');
    mem_in_enable <= '1' when mem_read_needed else '0';
    mem_in_ready <= mem_in_ready_buff;
    --mem_out_address(cpu_address_width-1 downto cache_address_width) <= (others=>'0');
    mem_out_enable <= '1' when mem_write_needed else '0';
    mem_out_valid <= mem_out_valid_buff;
    -- Validset storage.
    cache_in_validset <= cache_validsets(to_integer(unsigned(cache_index)));
    process (clock)
        variable index : integer range 0 to 2**cache_index_width-1;
    begin
        if rising_edge(clock) then
            if resetn='0' then
                cache_validsets <= (others=>(others=>'0'));
            else
                index := to_integer(unsigned(cache_index));
                for each_way in 0 to 2**cache_way_width-1 loop
                    if cache_out_valid_enable(each_way)='1' then
                        cache_validsets(index)(each_way) <= cache_out_validset(each_way);
                    end if;
                end loop;
            end if;
        end if;
    end process;
    -- Get cache input.
    process (cache_in_data)
        variable cache_line : cache_line_type;
        variable cache_block : cache_block_type;
    begin
        for each_way in 0 to 2**cache_way_width-1 loop
            cache_line := cache_in_data((1+each_way)*cache_line_width-1 downto each_way*cache_line_width);
            cache_in_tagset(each_way) <= cache_line(cache_line_width-1 downto cache_line_width-cache_tag_width);
            for each_word in 0 to 2**cache_word_offset_width-1 loop
                cache_block(each_word) := cache_line((1+each_word)*cpu_data_width-1 downto each_word*cpu_data_width);
            end loop;
            cache_in_blockset(each_way) <= cache_block;
        end loop;
    end process;
    -- Set cache output.
    process (cache_out_tagset,cache_out_blockset)
        variable cache_line : cache_line_type;
        variable cache_block : cache_block_type;
    begin
        for each_way in 0 to 2**cache_way_width-1 loop
            cache_line(cache_line_width-1 downto cache_line_width-cache_tag_width) := cache_out_tagset(each_way);
            cache_block := cache_out_blockset(each_way);
            for each_word in 0 to 2**cache_word_offset_width-1 loop
                cache_line((1+each_word)*cpu_data_width-1 downto 
                    each_word*cpu_data_width) := cache_block(each_word);
            end loop;
            cache_out_data((1+each_way)*cache_line_width-1 downto each_way*cache_line_width) <= cache_line;
        end loop;
    end process;
    -- Determine cache hit and way.
    process (cache_in_tagset,cache_in_validset,cache_tag)
        variable hit : boolean;
        variable way : cache_way_type;
    begin
        hit := False;
        way := 0;
        for each_way in 0 to 2**cache_way_width-1 loop
            if cache_in_tagset(each_way)=cache_tag and cache_in_validset(each_way)='1' then
                hit := True;
                way := each_way;
            end if;
        end loop;
        cache_hit <= hit;
        cache_way <= way;
    end process;
    -- Replacement Strategy: Pseudo Least Recently Used.
    gen_plru : 
    if cache_replace_strat="plru" generate
        -- Plru storage.
        cache_in_plruset <= cache_plrusets(to_integer(unsigned(cache_index)));
        process (clock)
            variable index : integer range 0 to 2**cache_index_width-1;
        begin
            if rising_edge(clock) then
                if resetn='0' then
                    cache_plrusets <= (others=>(others=>'0'));
                else
                    if cache_out_plru_enable='1' then
                        index := to_integer(unsigned(cache_index));
                        cache_plrusets(index) <= cache_out_plruset;
                    end if;
                end if;
            end if;
        end process;
        -- Pseudo Least Recently Used Implementation.
        process (cache_in_plruset)
            subtype int_type is integer range 0 to cache_plru_width;
            variable plruset : cache_plruset_type;
            variable this_bit : int_type;
            variable left_bit : int_type;
            variable right_bit : int_type;
            variable row_width : int_type;
            variable replace_bit : int_type;
        begin
            if cache_way_width/=0 then
                plruset := cache_in_plruset;
                this_bit := 0;
                row_width := 0;
                for each_row in 1 to 2**cache_way_width/2-1 loop
                    row_width := row_width+1;
                    left_bit := row_width+this_bit;
                    right_bit := left_bit+1;
                    if plruset(this_bit)='0' then
                        plruset(this_bit) := '1';
                        this_bit := left_bit;
                    else
                        plruset(this_bit) := '0';
                        this_bit := right_bit;
                    end if;
                end loop;
                replace_bit := this_bit-row_width;
                left_bit := replace_bit*2;
                right_bit := left_bit+1;
                if plruset(this_bit)='0' then
                    plruset(this_bit) := '1';
                    this_bit := left_bit;
                else
                    plruset(this_bit) := '0';
                    this_bit := right_bit;
                end if;
                cache_way_replace <= this_bit;
                cache_plruset_replace <= plruset;
            else
                cache_way_replace <= 0;
            end if;
        end process;
    end generate;
    -- Drive cache state machine.
    process (clock)
        variable word_offset : integer range 0 to 2**cache_word_offset_width-1;
        variable blockset : cache_blockset_type;
        variable tagset : cache_tagset_type;
        variable validset : cache_validset_type;
        variable out_valid_enable : cache_valid_enable_type;
        variable out_plru_enable : cache_plru_enable_type;
        variable out_tag_enable : cache_tag_enable_type;
        variable out_block_enable : cache_block_enable_type;
    begin
        if rising_edge(clock) then
            -- Reset control signals upon reset.
            if resetn='0' then
                cache_out_valid_enable <= (others=>'0');
                cache_out_plru_enable <= '0';
                cache_out_tag_enable <= (others=>'0');
                cache_out_block_enable <= (others=>'0');
                cache_flush_enable <= False;
                cache_invalidate_enable <= False;
                cpu_pause_buff <= '0';
                cpu_pause_delayed <= False;
                cache_state <= cache_state_run;
            else
                -- Ensure the default value of all the enables are zero.
                out_valid_enable := (others=>'0');
                out_plru_enable := '0';
                out_tag_enable := (others=>'0');
                out_block_enable := (others=>'0');
                -- Main State Machine.
                case cache_state is
                when cache_state_run=>
                    -- Check for the start of a cache operation.
                    if cache_flush or cache_invalidate then
                        -- Of course, the specified address must be a cacheable address. 
                        if is_cacheable(cpu_in_data) then
                            -- Set flag corresponding to the appropriate cache operation.
                            if cache_flush then
                                cache_flush_enable <= True;
                            elsif cache_invalidate then
                                cache_invalidate_enable <= True;
                            end if;
                            -- Store cache operation information.
                            cache_oper_tag <= cpu_in_data(cache_address_width-1 downto cache_address_width-cache_tag_width);
                            cache_oper_index <= cpu_in_data(cache_address_width-cache_tag_width-1 downto cache_offset_width);
                        end if;
                    -- Check for cache operation.
                    elsif cache_oper then
                        -- Check for hit and then check to see which operation is enabled.
                        if cache_hit then
                            -- If flush is enabled, check and see if the 
                            -- requested tag and index are actually valid in the cache. If
                            -- they are, flush cache line. 
                            if cache_flush_enable then
                                cpu_pause_delayed <= True;
                                cpu_pause_buff <= '1';
                                cache_state <= cache_state_mem;
                                mem_way_replace <= cache_way;
                                mem_write_needed <= True;
                                mem_write_counter <= 1;
                                mem_out_strobe <= (others=>'1');
                                mem_out_data <= cache_in_blockset(cache_way)(0);
                                mem_out_address(cpu_address_width-1 downto cache_address_width) <= (others=>'0');
                                mem_out_address(cache_address_width-1 downto cache_address_width-cache_tag_width-cache_index_width)  <= 
                                    cache_in_tagset(cache_way) & cache_index;
                                mem_out_address(cache_offset_width-1 downto 0) <= (others=>'0');
                            -- If invalidation is enabled, check and see if the 
                            -- requested tag and index are actually valid in the cache. If
                            -- they are, invalidate cache line. 
                            elsif cache_invalidate_enable then
                                out_valid_enable(cache_way_replace) := '1';
                                cache_out_validset(cache_way_replace) <= '0';
                            end if;
                        end if;
                        -- Make sure operation is disabled once started.
                        cache_flush_enable <= False;
                        cache_invalidate_enable <= False;
                    -- Check for noncachebale memory access
                    elsif cache_noncacheable then
                        -- If the CPU is not already pauses, the current memory access
                        -- must not have been serviced yet.
                        if cpu_pause_buff='0' then
                            -- Immediately stall the CPU.
                            cpu_pause_buff <= '1';
                            -- Switch the cache into memory access mode.
                            cache_state <= cache_state_mem;
                            -- Check to see if the cpu is requesting a write or read operation.
                            -- If write, perform the following operations.
                            if cpu_access_write then
                                -- Enable the memory write interface for only a single word.
                                mem_write_needed <= True;
                                mem_write_counter <= 2**cache_word_offset_width-1;
                                -- Set memory out control information.
                                mem_out_strobe <= cpu_strobe;
                                mem_out_address <= cpu_address;
                                -- Set memory out data.
                                mem_out_data <= cpu_in_data;
                            -- If read, perform the following operations.
                            else
                                -- Enable the memory read interface for only a single word.
                                mem_read_needed <= True;
                                mem_read_counter <= 2**cache_word_offset_width-1;
                                -- Set memory out control information.
                                mem_in_address <= cpu_address;
                                -- Force noop.
                                cpu_out_data <= (others=>'0');
                            end if;
                        -- If the CPU is already paused, the direct memory access was
                        -- already serviced. Return the cache back to its normal mode
                        -- of operation.
                        else
                            cpu_pause_delayed <= True;
                            cpu_pause_buff <= '0';
                        end if;
                    -- Check for cache hit
                    elsif cache_hit then
                         -- Set cache control signals and offset.
                        if not cpu_pause_delayed then
                            cpu_pause_delayed <= True;
                        else
                            cpu_pause_buff <= '0';
                            cache_strobe_replace <= (others=>'0');
                        end if;
                        word_offset := to_integer(unsigned(cache_word_offset));
                        -- Perform the write operation to cache from CPU.
                        for each_byte in 0 to cpu_data_width/8-1 loop
                            if (cpu_pause_buff='0' and cpu_strobe(each_byte)='1') or 
                                    (cpu_pause_buff='1' and cache_strobe_replace(each_byte)='1') then
                                cache_out_address <= cache_index;
                                out_block_enable(cache_way*2**cache_word_offset_width+word_offset) := '1';
                                cache_out_blockset(cache_way)(word_offset)
                                    (7+each_byte*8 downto each_byte*8) <=
                                    cpu_in_data(7+each_byte*8 downto each_byte*8);
                            end if;
                        end loop;
                        -- Perform read operation from cache to CPU.
                        cpu_out_data <= cache_in_blockset(cache_way)(word_offset);
                    -- If miss, begin memory transactions.
                    else
                        cpu_pause_delayed <= False;
                        cpu_pause_buff <= '1';
                        cache_strobe_replace <= cpu_strobe;
                        cache_state <= cache_state_mem;
                        mem_way_replace <= cache_way_replace;
                        mem_tag_replace <= cache_tag;
                        mem_read_needed <= True;
                        mem_read_counter <= 0;
                        mem_in_address(cpu_address_width-1 downto cache_address_width) <= (others=>'0');
                        mem_in_address(cache_address_width-1 downto cache_address_width-cache_tag_width-cache_index_width) 
                            <= cache_tag & cache_index;
                        mem_in_address(cache_offset_width-1 downto 0) <= (others=>'0');
                        if cache_in_validset(cache_way_replace)='1' then
                            mem_write_needed <= True;
                            mem_write_counter <= 1;
                            mem_out_strobe <= (others=>'1');
                            mem_out_address(cpu_address_width-1 downto cache_address_width) <= (others=>'0');
                            mem_out_address(cache_address_width-1 downto cache_address_width-cache_tag_width-cache_index_width)  <= 
                                cache_in_tagset(cache_way_replace) & cache_index;
                            mem_out_address(cache_offset_width-1 downto 0) <= (others=>'0');
                            mem_out_data <= cache_in_blockset(cache_way_replace)(0);
                        end if;
                    end if;
                when cache_state_mem=>
                    -- Memory write block.
                    if mem_write_needed then
                        -- Point to next word on successful handshake.
                        if mem_out_valid_buff='1' and mem_out_ready='1' then 
                            if mem_write_counter/=2**cache_word_offset_width then
                                if not cache_noncacheable then
                                    mem_out_data <= cache_in_blockset(mem_way_replace)(mem_write_counter);
                                end if;
                                mem_write_counter <= mem_write_counter+1;
                            else
                                mem_write_needed <= False;
                                mem_out_valid_buff <= '0';
                            end if;
                        else
                            mem_out_valid_buff <= '1';
                        end if;
                    end if;   
                    -- Memory read block.
                    if mem_read_needed then
                        -- Perform read operation on handshake.
                        if mem_in_valid='1' and mem_in_ready_buff='1' then
                            -- If the memory access was cacheable, store the data in cache.
                            if not cache_noncacheable then
                                -- Set the corresponding control information.
                                cache_out_address <= cache_index;
                                out_block_enable(mem_way_replace*2**cache_word_offset_width+mem_read_counter) := '1';
                                -- Store the newly acquired word.
                                cache_out_blockset(mem_way_replace)(mem_read_counter) <= mem_in_data;
                            -- If a nonecacheable memory access was performed, write directly to CPU.
                            else
                                cpu_out_data <= mem_in_data;
                            end if;
                            -- On completion, shut down read operation.
                            if mem_read_counter=2**cache_word_offset_width-1 then
                                mem_read_needed <= False;
                                -- If the memory access was cacheable, store the control information.
                                if not cache_noncacheable then
                                    -- Set tag and valid flag.
                                    out_valid_enable(mem_way_replace) := '1';
                                    out_tag_enable(mem_way_replace) := '1';
                                    if cache_replace_strat="plru" then
                                        out_plru_enable := '1';
                                        cache_out_plruset <= cache_plruset_replace;
                                    end if;
                                    cache_out_validset(mem_way_replace) <= '1';
                                    cache_out_tagset(mem_way_replace) <= mem_tag_replace;
                                end if;
                            -- Continue to increment counter until completion.
                            else
                                mem_read_counter <= mem_read_counter+1;
                            end if;
                        end if;
                        -- The ready signal should be set to low once the read operation is finished.
                        if mem_in_valid='1' and mem_in_ready_buff='1' and mem_read_counter=2**cache_word_offset_width-1 then
                            mem_in_ready_buff <= '0';
                        -- If memory write is needed, then write operation should always precede
                        -- the read operation.
                        elsif mem_write_needed and mem_write_counter=mem_read_counter then
                            mem_in_ready_buff <= '0';
                        -- By default, the ready signal should always be high, signaling the memory input data
                        -- is ready to accept more data.
                        else
                            mem_in_ready_buff <= '1';
                        end if;
                    end if;
                    -- If both operations are finished, return cache back to 
                    -- its original state.
                    if not mem_write_needed and not mem_read_needed then
                        cache_state <= cache_state_run;
                    end if;
                end case;
                -- Set enable values.
                cache_out_valid_enable <= out_valid_enable;
                cache_out_plru_enable <= out_plru_enable;
                cache_out_tag_enable <= out_tag_enable;
                cache_out_block_enable <= out_block_enable;
            end if;
        end if;
    end process;
end Behavioral;