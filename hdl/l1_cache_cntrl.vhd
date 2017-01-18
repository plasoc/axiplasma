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
use ieee.numeric_std.all;
use work.mlitesoc_pack.all;

entity l1_cache_cntrl is
    generic (
        -- global constants
        glb_address_width : integer := 16;
        glb_data_width : integer := 32;
        -- cache constants
        cache_way_width : integer := 1; 
        cache_index_width : integer := 4;
        cache_offset_width : integer := 4;
        cache_replace_strat : string := "plru";
        -- cache control constants
        cache_invalidate_address : std_logic_vector := X"1000";
        cache_flush_address : std_logic_vector := X"1004" ); -- 
    port ( 
        -- global interface.
        clock : in std_logic; 
        resetn : in std_logic;
        -- cpu interface.
        cpu_address : in std_logic_vector(glb_address_width-1 downto 0); 
        cpu_in_data : in std_logic_vector(glb_data_width-1 downto 0);
        cpu_out_data : out std_logic_vector(glb_data_width-1 downto 0) := (others=>'0');
        cpu_strobe : in std_logic_vector(glb_data_width/8-1 downto 0);
        cpu_pause : out std_logic;
        -- cache interface.
        cache_out_address: out std_logic_vector(cache_index_width-1 downto 0);
        cache_out_data : out std_logic_vector(((glb_address_width-cache_index_width-cache_offset_width)+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
        cache_out_tag_enable : out std_logic_vector(2**cache_way_width-1 downto 0);
        cache_out_block_enable : out std_logic_vector(2**cache_way_width*2**cache_offset_width/(glb_data_width/8)-1 downto 0);
        cache_in_address : out std_logic_vector(cache_index_width-1 downto 0);
        cache_in_data : in std_logic_vector(((glb_address_width-cache_index_width-cache_offset_width)+8*2**cache_offset_width)*2**cache_way_width-1 downto 0);
        -- simple mem interface
        mem_in_address : out std_logic_vector(glb_address_width-1 downto 0) := (others=>'0');
        mem_in_data : in std_logic_vector(glb_data_width-1 downto 0);
        mem_in_enable : out std_logic;
        mem_in_valid : in std_logic;
        mem_in_ready : out std_logic;
        mem_out_address : out std_logic_vector(glb_address_width-1 downto 0) := (others=>'0');
        mem_out_data : out std_logic_vector(glb_data_width-1 downto 0) := (others=>'0');
        mem_out_enable : out std_logic;
        mem_out_valid : out std_logic;
        mem_out_ready : in std_logic);
end l1_cache_cntrl;

architecture Behavioral of l1_cache_cntrl is
    function cache_plru_width return integer is
    	variable result : integer := 0;
    begin
        for each_way in 0 to 2**cache_way_width-1 loop
            result := result+each_way;
        end loop; 
        return result;
    end; --function
    constant cache_word_offset_width : integer := cache_offset_width-clogb2(glb_data_width/8);
    constant cache_tag_width : integer := glb_address_width-cache_index_width-cache_offset_width;
    constant cache_line_width : integer := cache_tag_width+8*2**cache_offset_width;
    constant cache_lineset_width : integer := cache_line_width*2**cache_way_width;
    constant cache_write_zeros : std_logic_vector(glb_data_width/8-1 downto 0) := (others=>'0');
    subtype byte_type is std_logic_vector(7 downto 0);
    subtype word_type is std_logic_vector(glb_data_width-1 downto 0);
    subtype cache_tag_type is std_logic_vector(cache_tag_width-1 downto 0);
    subtype cache_index_type is std_logic_vector(cache_index_width-1 downto 0);
    subtype cache_offset_type is std_logic_vector(cache_offset_width-1 downto 0);
    subtype cache_word_offset_type is std_logic_vector(cache_word_offset_width-1 downto 0);
    subtype cache_valid_type is std_logic;
    subtype cache_plruset_type is std_logic_vector(cache_plru_width-1 downto 0);
    subtype cache_line_type is std_logic_vector(cache_line_width-1 downto 0);
    subtype cache_way_type is integer range 0 to 2**cache_way_width-1;
    subtype cache_out_block_enable_type is std_logic_vector(2**cache_way_width*2**cache_word_offset_width-1 downto 0);
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
    signal cache_out_control_enables : std_logic_vector(2**cache_way_width-1 downto 0) := (others=>'0');
    signal cache_validsets : cache_validsets_type := (others=>(others=>'0'));
    signal cache_plrusets : cache_plrusets_type := (others=>(others=>'0'));
    signal cache_hit : boolean;
    signal cache_invalidate : boolean;
    signal cache_invalidate_enable : boolean := False;
    signal cache_flush : boolean;
    signal cache_flush_enable : boolean := False;
    signal cache_write_oper : boolean;
    signal cache_way : cache_way_type;
    signal cache_way_replace : cache_way_type;
    signal cache_plruset_replace : cache_plruset_type;
    signal cache_strobe_replace : std_logic_vector(glb_data_width/8-1 downto 0) := (others=>'0');
    signal cache_state : cache_state_type := cache_state_run;
    signal mem_in_ready_buff : std_logic := '0';
    signal mem_out_valid_buff : std_logic := '0';
    signal mem_write_needed : boolean;
    signal mem_read_needed : boolean;
    signal mem_write_counter : integer range 0 to 2**cache_offset_width-1;
    signal mem_read_counter : integer range 0 to 2**cache_offset_width-1;
    signal mem_way_replace : cache_way_type;
    signal mem_tag_replace : cache_tag_type;
--    attribute keep : string;
--    attribute keep of cache_way_replace : signal is "true";
--    attribute keep of cache_plruset_replace : signal is "true";
begin
    -- Get cache control information from cpu address.
    cpu_pause <= cpu_pause_buff;
    cache_in_address <= cache_index;
    cache_tag <= cpu_address(glb_address_width-1 downto glb_address_width-cache_tag_width);
    cache_index <= cpu_address(glb_address_width-cache_tag_width-1 downto cache_offset_width);
    cache_word_offset <= cpu_address(cache_offset_width-1 downto clogb2(glb_data_width/8));
    cache_write_oper <= cache_write_zeros/=cpu_strobe;
    cache_in_validset <= cache_validsets(to_integer(unsigned(cache_index)));
    cache_in_plruset <= cache_plrusets(to_integer(unsigned(cache_index)));
    cache_invalidate <= True when cpu_address=cache_invalidate_address else False;
    cache_flush <= True when cpu_address=cache_flush_address else False;
--    cache_inval_tag <= cpu_in_data(glb_address_width-1 downto glb_address_width-cache_tag_width);
--    cache_inval_index <= cpu_in_data(glb_address_width-cache_tag_width-1 downto cache_offset_width);
    mem_in_enable <= '1' when mem_read_needed else '0';
    mem_out_enable <= '1' when mem_write_needed else '0';
    mem_in_ready <= mem_in_ready_buff;
    mem_out_valid <= mem_out_valid_buff;
    -- Set flag registers.
    process (clock)
        variable index : integer;
    begin
        if rising_edge(clock) then
            if resetn='0' then
                cache_validsets <= (others=>(others=>'0'));
                cache_plrusets <= (others=>(others=>'0'));
            else
                index := to_integer(unsigned(cache_index));
                for each_way in 0 to 2**cache_way_width-1 loop
                    if cache_out_control_enables(each_way)='1' then
                        cache_validsets(index)(each_way) <= cache_out_validset(each_way);
                        cache_plrusets(index) <= cache_out_plruset;
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
                cache_block(each_word) := cache_line((1+each_word)*glb_data_width-1 downto each_word*glb_data_width);
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
                cache_line((1+each_word)*glb_data_width-1 downto 
                    each_word*glb_data_width) := cache_block(each_word);
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
    -- Replacement Strategy: Pseudo Least Recently Used
    gen_plru : 
    if cache_replace_strat="plru" generate
        process (cache_in_plruset)
            subtype int_type is integer range 0 to 2**(cache_way_width+1);
            variable plruset : cache_plruset_type;
            variable this_bit : int_type;
            variable left_bit : int_type;
            variable right_bit : int_type;
            variable next_row_bit : int_type;
            variable row_width : int_type;
        begin
            if cache_offset_width/=0 then
                plruset := cache_in_plruset;
                this_bit := 0;
                row_width := 0;
                next_row_bit := 0;
                for each_row in 0 to 2**cache_way_width-2 loop
                    row_width := row_width+1;
                    next_row_bit := next_row_bit+row_width;
                    left_bit := next_row_bit+this_bit;
                    right_bit := next_row_bit+this_bit+1;
                    if plruset(this_bit)='0' then
                        plruset(this_bit) := '1';
                        this_bit := left_bit;
                    else
                        plruset(this_bit) := '0';
                        this_bit := right_bit;
                    end if;
                end loop;
                cache_way_replace <= this_bit-(2**cache_way_width-1);
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
        variable out_block_enable : cache_out_block_enable_type;
    begin
        if rising_edge(clock) then
            if resetn='0' then
                cache_out_control_enables <= (others=>'0');
                cache_out_tag_enable <= (others=>'0');
                cache_out_block_enable <= (others=>'0');
                cache_flush_enable <= False;
                cache_invalidate_enable <= False;
                cpu_pause_buff <= '0';
                cpu_pause_delayed <= False;
                cache_state <= cache_state_run;
            else
                -- Main State Machine.
                case cache_state is
                when cache_state_run=>
                    -- Check for flush
                    if cache_flush or cache_flush_enable then
                        -- Ensure writing control and block enables are disabled.
                        cache_out_control_enables <= (others=>'0');  
                        cache_out_block_enable <= (others=>'0');
                        -- If flushing is enabled, check and see if the requested
                        -- tag and index is actually valid in the cache. If it is,
                        -- write cache block into memory.
                        if cache_flush_enable then
                            if cache_hit then
                                cpu_pause_delayed <= True;
                                cpu_pause_buff <= '1';
                                cache_state <= cache_state_mem;
                                mem_write_needed <= True;
                                mem_write_counter <= 1;
                                mem_out_data <= cache_in_blockset(cache_way)(0);
                                mem_out_address(glb_address_width-1 downto glb_address_width-cache_tag_width-cache_index_width)  <= 
                                    cache_in_tagset(cache_way) & cache_index;
                            end if;
                            cache_flush_enable <= False;
                        else
                            cache_flush_enable <= True;
                        end if;
                    -- Check for invalidation
                    elsif cache_invalidate or cache_invalidate_enable then
                        -- Ensure writing block enables are disabled.
                        cache_out_block_enable <= (others=>'0'); 
                        -- If invalidation is enabled, check and see if the 
                        -- requested tag and index is actually valid in the cache. If
                        -- they is, invalidate cache line. 
                        if cache_invalidate_enable then
                            if cache_hit then
                                cache_out_control_enables(cache_way_replace) <= '1';
                                cache_out_validset(cache_way_replace) <= '0';
                                if cache_replace_strat="plru" then
                                    cache_out_plruset <= cache_in_plruset;
                                end if;
                            end if;
                            cache_invalidate_enable <= False;
                        else
                            cache_invalidate_enable <= True; 
                            cache_out_control_enables <= (others=>'0');  
                        end if;
                    -- Check for cache hit
                    elsif cache_hit then
                        cache_out_control_enables <= (others=>'0');  
                         -- Set cache control signals and offset.
                        if not cpu_pause_delayed then
                            cpu_pause_delayed <= True;
                        else
                            cpu_pause_buff <= '0';
                            cache_strobe_replace <= (others=>'0');
                        end if;
                        word_offset := to_integer(unsigned(cache_word_offset));
                        -- Perform the write operation to cache from CPU.
                        out_block_enable := (others=>'0');
                        for each_byte in 0 to glb_data_width/8-1 loop
                            if (cpu_pause_buff='0' and cpu_strobe(each_byte)='1') or 
                                    (cpu_pause_buff='1' and cache_strobe_replace(each_byte)='1') then
                                cache_out_address <= cache_index;
                                out_block_enable(cache_way*2**cache_word_offset_width+word_offset) := '1';
                                cache_out_blockset(cache_way)(word_offset)
                                    (7+each_byte*8 downto each_byte*8) <=
                                    cpu_in_data(7+each_byte*8 downto each_byte*8);
                            end if;
                        end loop;
                        cache_out_block_enable <= out_block_enable;
                        -- Perform read operation from cache to CPU.
                        cpu_out_data <= cache_in_blockset(cache_way)(word_offset);
                    -- If miss, begin memory transactions.
                    else
                        cpu_pause_delayed <= False;
                        cpu_pause_buff <= '1';
                        cache_strobe_replace <= cpu_strobe;
                        cache_state <= cache_state_mem;
                        cache_out_control_enables <= (others=>'0');  
                        cache_out_block_enable <= (others=>'0');
                        mem_way_replace <= cache_way_replace;
                        mem_tag_replace <= cache_tag;
                        mem_read_needed <= True;
                        mem_read_counter <= 0;
                        mem_in_address(glb_address_width-1 downto glb_address_width-cache_tag_width-cache_index_width) 
                            <= cache_tag & cache_index;
                        if cache_in_validset(cache_way_replace)='1' then
                            mem_write_needed <= True;
                            mem_write_counter <= 1;
                            mem_out_data <= cache_in_blockset(cache_way_replace)(0);
                            mem_out_address(glb_address_width-1 downto glb_address_width-cache_tag_width-cache_index_width)  <= 
                                cache_in_tagset(cache_way_replace) & cache_index;
                        end if;
                    end if;
                when cache_state_mem=>
                    -- Memory write block.
                    if mem_write_needed then
                        -- Point to next word on successful handshake.
                        if mem_out_valid_buff='1' and mem_out_ready='1' then 
                            mem_out_data <= cache_in_blockset(mem_way_replace)(mem_write_counter);
                            mem_write_counter <= mem_write_counter+1;
                        end if;
                        if mem_write_counter/=2**cache_word_offset_width-1 then
                            mem_out_valid_buff <= '1';
                        else
                            mem_write_needed <= False;
                            mem_out_valid_buff <= '0';
                        end if;
                    end if;   
                    -- Memory read block.
                    if mem_read_needed then
                        -- Perform read operation on handshake.
                        if mem_in_valid='1' and mem_in_ready_buff='1' then
                            -- Set the corresponding control information.
                            cache_out_address <= cache_index;
                            out_block_enable := (others=>'0');
                            out_block_enable(mem_way_replace*2**cache_word_offset_width+mem_read_counter) := '1';
                            cache_out_block_enable <= out_block_enable;
                            -- Store the newly acquired word.
                            cache_out_blockset(mem_way_replace)(mem_read_counter) <= mem_in_data;
                            mem_read_counter <= mem_read_counter+1;
                            -- On completion, shut down read operation.
                            if mem_read_counter=2**cache_word_offset_width-1 then
                                mem_read_needed <= False;
                                -- Set tag and valid flag.
                                cache_out_control_enables(mem_way_replace) <= '1';
                                cache_out_tag_enable(mem_way_replace) <= '1';
                                if cache_replace_strat="plru" then
                                    cache_out_plruset <= cache_plruset_replace;
                                end if;
                                cache_out_validset(mem_way_replace) <= '1';
                                cache_out_tagset(mem_way_replace) <= mem_tag_replace;
                            end if;
                        -- Enable for block should only remain for single clock cycle.
                        else
                            cache_out_block_enable <= (others=>'0');
                        end if;
                        -- If memory write is needed, then write operation should always precede
                        -- the read operation.
                        if (not mem_write_needed or mem_write_counter/=mem_read_counter)  
                                and mem_read_counter/=2**cache_word_offset_width-1 then
                            mem_in_ready_buff <= '1';
                        else
                            mem_in_ready_buff <= '0';
                        end if;
                    end if;
                    -- If both operations are finished, return cache back to 
                    -- its original state.
                    if not mem_write_needed and not mem_read_needed then
                        cache_state <= cache_state_run;
                    end if;
                    -- Once the read operation finishes, ensure all enables
                    -- are reset.
                    if not mem_read_needed then
                        cache_out_control_enables <= (others=>'0');
                        cache_out_tag_enable <= (others=>'0');
                        cache_out_block_enable <= (others=>'0');
                    end if;
                end case;
            end if;
        end if;
    end process;
end Behavioral;