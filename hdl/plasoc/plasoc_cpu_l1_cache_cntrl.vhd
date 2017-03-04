-------------------------------------------------------
--! @author Andrew Powell
--! @date January 17, 2017
--! @brief Contains the entity and architecture of the 
--! CPU's Write-Back Cache Controller. 
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use work.plasoc_cpu_pack.all;


entity plasoc_cpu_l1_cache_cntrl is
    generic (
        cpu_address_width : integer := 32;
        cpu_data_width : integer := 32;
        cache_cacheable_width : integer := 16;
        cache_way_width : integer := 1;
        cache_index_width : integer := 4;
        cache_offset_width : integer := 5;
        cache_policy : string := "plru";
        oper_base : std_logic_vector := X"200000"; -- msb
        oper_invalidate_offset : std_logic_vector := X"00";
        oper_flush_offset : std_logic_vector := X"04"); 
    port ( 
        clock : in std_logic;
        resetn : in std_logic;
        cpu_next_address : in std_logic_vector(cpu_address_width-1 downto 0);
        cpu_write_data : in std_logic_vector(cpu_data_width-1 downto 0);
        cpu_write_enables : in std_logic_vector(cpu_data_width/8-1 downto 0);
        cpu_read_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
        cpu_pause : out std_logic;
        memory_write_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
        memory_write_data : out std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
        memory_write_enable : out std_logic;
        memory_write_enables : out std_logic_vector(cpu_data_width/8-1 downto 0) := (others=>'0');
        memory_write_valid : out std_logic;
        memory_write_ready : in std_logic;
        memory_read_address : out std_logic_vector(cpu_address_width-1 downto 0) := (others=>'0');
        memory_read_enable : out std_logic;
        memory_read_data: in std_logic_vector(cpu_data_width-1 downto 0);
        memory_read_valid : in std_logic;
        memory_read_ready : out std_logic;
        memory_cacheable : out std_logic); 
end plasoc_cpu_l1_cache_cntrl;

architecture Behavioral of plasoc_cpu_l1_cache_cntrl is

    constant tag_width : integer := cache_cacheable_width-cache_index_width-cache_offset_width;
    constant block_word_width : integer := cache_offset_width-clogb2(cpu_data_width/8);
    constant oper_base_width : integer := oper_base'length;
    constant oper_offset_width : integer := oper_invalidate_offset'length;
    
    function plru_width return integer is
        variable result : integer := 0;
    begin
        if cache_way_width/=0 then
            for each_way in 1 to 2**cache_way_width/2 loop
                result := result+each_way;
            end loop; 
        end if;
        return result;
    end; 
    
    type block_rows_type is array(0 to 2**cache_index_width-1) of std_logic_vector(2**cache_way_width*2**cache_offset_width*8-1 downto 0);
    type tag_rows_type is array(0 to 2**cache_index_width-1) of std_logic_vector(2**cache_way_width*tag_width-1 downto 0);
    type valid_rows_type is array(0 to 2**cache_index_width-1) of std_logic_vector(2**cache_way_width-1 downto 0);
    type plru_rows_type is array(0 to 2**cache_index_width-1) of std_logic_vector(plru_width-1 downto 0);
    type memory_access_mode_type is (msm_read_block,msm_write_block,msm_exchange_block,msm_write_word,msm_read_word);
    
    signal block_rows : block_rows_type := (others=>(others=>'0'));
    signal tag_rows : tag_rows_type := (others=>(others=>'0'));
    signal valid_rows : valid_rows_type := (others=>(others=>'0'));
    signal plru_rows : plru_rows_type := (others=>(others=>'0'));
    signal cpu_tag : std_logic_vector(tag_width-1 downto 0) := (others=>'0');
    signal cpu_index : integer range 0 to 2**cache_index_width-1 := 0;
    signal cpu_offset : integer range 0 to 2**cache_offset_width-1 := 0;
    signal cpu_way : integer range 0 to 2**cache_way_width-1 := 0;
    signal cpu_hit : Boolean := False;
    signal cpu_cacheable : Boolean := False;
    signal cpu_pause_buff : std_logic := '0';
    signal replace_plru : std_logic_vector(plru_width-1 downto 0);
    signal replace_way : integer range 0 to 2**cache_way_width-1 := 0;
    signal replace_write_enables : std_logic_vector(cpu_data_width/8-1 downto 0) := (others=>'0');
    signal replace_write_data : std_logic_vector(cpu_data_width-1 downto 0) := (others=>'0');
    signal replace_offset : integer range 0 to 2**cache_offset_width-1 := 0;
    signal memory_prepared : Boolean := False;
    signal memory_way : integer range 0 to 2**cache_way_width-1 := 0;
    signal memory_access_needed : Boolean := False;
    signal memory_access_mode : memory_access_mode_type := msm_read_block;
    signal memory_write_counter : integer range 0 to 2**block_word_width-1 := 0;
    signal memory_read_counter : integer range 0 to 2**block_word_width-1 := 0;
    signal memory_write_enable_buff : std_logic := '0';
    signal memory_read_enable_buff : std_logic := '0';
    signal memory_write_valid_buff : std_logic := '0';
    signal memory_read_ready_buff : std_logic := '0';
    signal memory_index : integer range 0 to 2**cache_index_width-1 := 0;
    signal oper_request : Boolean := False;
    signal oper_request_invalidate : Boolean := False;
    signal oper_request_flush : Boolean := False;
    signal oper_started : Boolean := False;
    signal oper_started_invalidate : Boolean := False;
    signal oper_started_flush : Boolean := False;
    
--    attribute keep : boolean;
--    attribute keep of cpu_next_address : signal is true;
--    attribute keep of cpu_write_data : signal is true;
--    attribute keep of cpu_write_enables : signal is true;
--    attribute keep of cpu_read_data : signal is true;
--    attribute keep of cpu_tag : signal is true;
--    attribute keep of cpu_index : signal is true;
--    attribute keep of cpu_offset : signal is true;
--    attribute keep of cpu_way : signal is true;
begin

    cpu_pause <= cpu_pause_buff;
    cpu_tag <= cpu_next_address(cache_cacheable_width-1 downto cache_offset_width+cache_index_width);
    cpu_index <= to_integer(unsigned(cpu_next_address(cache_offset_width+cache_index_width-1 downto cache_offset_width)));
    cpu_offset <= to_integer(unsigned(cpu_next_address(cache_offset_width-1 downto 0)));
    cpu_cacheable <= True when or_reduce(cpu_next_address(cpu_address_width-1 downto cache_cacheable_width))='0' else False;
    
    memory_write_enable <= memory_write_enable_buff;
    memory_write_valid <= memory_write_valid_buff;
    memory_read_ready <= memory_read_ready_buff;
    memory_read_enable <= memory_read_enable_buff;
    
    oper_request <= True when cpu_next_address(cpu_address_width-1 downto cpu_address_width-oper_base_width)=oper_base and and_reduce(cpu_write_enables)='1' else False;
    oper_request_invalidate <= True when cpu_next_address(oper_offset_width-1 downto 0)=oper_invalidate_offset else False;
    oper_request_flush <= True when cpu_next_address(oper_offset_width-1 downto 0)=oper_flush_offset else False;
    oper_started <= True when (oper_started_invalidate or oper_started_flush) and and_reduce(cpu_write_enables)='1' else False;
    
    process(cpu_index,cpu_tag,tag_rows,valid_rows)
        variable cpu_hit_buff : Boolean;
        variable cpu_way_buff : integer range 0 to 2**cache_way_width-1 := 0;
        variable tag_buff : std_logic_vector(tag_width-1 downto 0);
    begin
        cpu_hit_buff := False;
        cpu_way_buff := 0;
        for each_way in 0 to 2**cache_way_width-1 loop
            tag_buff := tag_rows(cpu_index)((each_way+1)*tag_width-1 downto each_way*tag_width);
            if tag_buff=cpu_tag and valid_rows(cpu_index)(each_way)='1' then
                cpu_hit_buff := True;
                cpu_way_buff := each_way;
                exit;
            end if;
        end loop;
        cpu_hit <= cpu_hit_buff;
        cpu_way <= cpu_way_buff;
    end process; 
    
    generate_policy_plru:
    if cache_policy= "plru" generate
        process (plru_rows,cpu_index)
            subtype int_type is integer range 0 to plru_width; 
            variable plru_buff : std_logic_vector(plru_width-1 downto 0);   
            variable this_bit : int_type;
            variable left_bit : int_type;
            variable right_bit : int_type;
            variable row_width : int_type;
            variable replace_bit : int_type;
        begin
            if cache_way_width/=0 then
                plru_buff := plru_rows(cpu_index);
                this_bit := 0;
                row_width := 0;
                for each_row in 1 to 2**cache_way_width/2-1 loop
                    row_width := row_width+1;
                    left_bit := row_width+this_bit;
                    right_bit := left_bit+1;
                    if plru_buff(this_bit)='0' then
                        plru_buff(this_bit) := '1';
                        this_bit := left_bit;
                    else
                        plru_buff(this_bit) := '0';
                        this_bit := right_bit;
                    end if;
                end loop;
                replace_bit := this_bit-row_width;
                left_bit := replace_bit*2;
                right_bit := left_bit+1;
                if plru_buff(this_bit)='0' then
                    plru_buff(this_bit) := '1';
                    this_bit := left_bit;
                else
                    plru_buff(this_bit) := '0';
                    this_bit := right_bit;
                end if;
                replace_way <= this_bit;
                replace_plru <= plru_buff;
            else
                replace_way <= 0;
                replace_plru <= (others=>'0');
            end if;
        end process;
        process (clock)
        begin
            if rising_edge(clock) then
                if resetn='0' then
                    plru_rows <= (others=>(others=>'0'));
                elsif not memory_access_needed and 
                        not oper_started and not oper_request and 
                        cpu_cacheable and not cpu_hit and memory_prepared then
                    plru_rows(cpu_index) <= replace_plru;
                end if;
            end if;
        end process;
    end generate 
    generate_policy_plru;

    process (clock)
        variable memory_write_handshake : Boolean;
        variable memory_read_handshake : Boolean;
        variable memory_access_exread_block : Boolean;
        variable memory_access_exwrite_block : Boolean;
        variable memory_access_word : Boolean;
    begin
        if rising_edge(clock) then
            if resetn='0' then
                memory_prepared <= False;
                memory_access_needed <= False;
                memory_write_enable_buff <= '0';
                memory_write_valid_buff <= '0';
                memory_read_ready_buff <= '0';
                memory_read_enable_buff <= '0';
                cpu_pause_buff <= '0';
                valid_rows <= (others=>(others=>'0'));
                oper_started_flush <= False;
                oper_started_invalidate <= False;
            else
                if memory_access_needed then
                
                    memory_write_handshake := memory_write_valid_buff='1' and memory_write_ready='1';
                    memory_read_handshake := memory_read_valid='1' and memory_read_ready_buff='1';
                    memory_access_exread_block := memory_access_mode=msm_read_block or memory_access_mode=msm_exchange_block;
                    memory_access_exwrite_block := memory_access_mode=msm_write_block or memory_access_mode=msm_exchange_block;
                    memory_access_word := memory_access_mode=msm_read_word or memory_access_mode=msm_write_word;
                
                    if memory_write_handshake and memory_access_exwrite_block and memory_write_counter/=2**block_word_width-1 then
                        memory_write_data <= 
                            block_rows(memory_index)(
                            memory_way*2**cache_offset_width*8+(memory_write_counter+2)*cpu_data_width-1 downto 
                            memory_way*2**cache_offset_width*8+(memory_write_counter+1)*cpu_data_width);
                    end if;
                    if memory_read_handshake and memory_access_exread_block then
                        block_rows(memory_index)(
                            memory_way*2**cache_offset_width*8+(memory_read_counter+1)*cpu_data_width-1 downto 
                            memory_way*2**cache_offset_width*8+memory_read_counter*cpu_data_width) <=
                            memory_read_data;
                    end if;
                    if memory_read_handshake and memory_access_mode=msm_read_word then
                        cpu_read_data <= memory_read_data;
                    end if;
                    
                    if (memory_access_exwrite_block and memory_write_counter=2**block_word_width-1) or 
                            (memory_access_mode=msm_write_word and memory_write_handshake) then
                        memory_write_enable_buff <= '0';
                    end if;
                    if (memory_access_exread_block and memory_read_counter=2**block_word_width-1) or
                            (memory_access_mode=msm_read_word and memory_read_handshake) then
                        memory_read_enable_buff <= '0';
                    end if;
                    
                    if (memory_access_exwrite_block and memory_write_counter/=2**block_word_width-1) or 
                            (memory_access_mode=msm_write_word and not memory_write_handshake) then
                        memory_write_valid_buff <= '1';
                    else
                        memory_write_valid_buff <= '0';
                    end if;
                    if ((memory_access_mode=msm_read_block or (memory_access_mode=msm_exchange_block and memory_read_counter/=memory_write_counter)) and memory_read_counter/=2**block_word_width-1) or
                            (memory_access_mode=msm_read_word and not memory_read_handshake) then
                        memory_read_ready_buff <= '1';
                    else
                        memory_read_ready_buff <= '0';
                    end if;
                    
                    if memory_access_exwrite_block and
                            memory_write_handshake and
                            memory_write_counter/=2**block_word_width-1 then
                        memory_write_counter <= memory_write_counter+1;
                    end if;
                    if (memory_access_mode=msm_read_block or (memory_access_mode=msm_exchange_block and memory_read_counter/=memory_write_counter)) and 
                            memory_read_handshake and
                            memory_read_counter/=2**block_word_width-1 then
                        memory_read_counter <= memory_read_counter+1;
                    end if;
                    
                    if memory_access_exread_block and memory_read_counter=2**block_word_width-1 then
                        for each_byte in 0 to cpu_data_width/8-1 loop
                            if or_reduce(replace_write_enables)='1' then
                                if replace_write_enables(each_byte)='1' then
                                    block_rows(memory_index)(
                                        memory_way*2**cache_offset_width*8+replace_offset*8+(each_byte+1)*8-1 downto 
                                        memory_way*2**cache_offset_width*8+replace_offset*8+each_byte*8) <=
                                        replace_write_data(7+each_byte*8 downto 0+each_byte*8);
                                end if;
                            else
                                cpu_read_data(7+each_byte*8 downto 0+each_byte*8) <=
                                    block_rows(memory_index)(
                                    memory_way*2**cache_offset_width*8+replace_offset*8+(each_byte+1)*8-1 downto 
                                    memory_way*2**cache_offset_width*8+replace_offset*8+each_byte*8);
                            end if;
                        end loop;
                    end if;
                    if ((memory_access_exwrite_block or memory_access_exread_block) and memory_write_valid_buff='0' and memory_read_enable_buff='0') or
                            (memory_access_word and (memory_write_handshake or memory_read_handshake)) then
                        memory_access_needed <= False;
                        cpu_pause_buff <= '0';
                    end if;
                    
                elsif oper_started then
                    if cpu_hit then
                        if oper_started_invalidate then
                            valid_rows(cpu_index)(cpu_way) <='0';
                        elsif oper_started_flush then
                            cpu_pause_buff <= '1';
                            memory_access_mode <= msm_write_block; 
                            memory_access_needed <= True;
                            memory_way <= cpu_way;
                            memory_cacheable <= '1';
                            memory_index <= cpu_index;
                            memory_write_address(cpu_address_width-1 downto cache_cacheable_width) <= (others=>'0');
                            memory_write_address(cache_cacheable_width-1 downto cache_offset_width) <=
                                tag_rows(cpu_index)((1+cpu_way)*tag_width-1 downto cpu_way*tag_width) & 
                                std_logic_vector(to_unsigned(cpu_index,cache_index_width));
                            memory_write_address(cache_offset_width-1 downto 0) <= (others=>'0');
                            memory_write_counter <= 0;
                            memory_write_enables <= (others=>'1');
                            memory_write_enable_buff <= '1';
                            memory_write_data <= 
                                block_rows(cpu_index)(
                                cpu_way*2**cache_offset_width*8+cpu_data_width-1 downto 
                                cpu_way*2**cache_offset_width*8);
                        end if;
                    end if;
                    oper_started_invalidate <= False;
                    oper_started_flush <= False;
                elsif oper_request then
                    if oper_request_invalidate then
                        oper_started_invalidate <= True;
                    elsif oper_request_flush then
                        oper_started_flush <= True;
                    end if;
                elsif not cpu_cacheable then
                    cpu_pause_buff <= '1';
                    memory_access_needed <= True;
                    memory_cacheable <= '0';
                    if or_reduce(cpu_write_enables)='1' then
                        memory_access_mode <= msm_write_word;
                        memory_write_address <= cpu_next_address;
                        memory_write_enables <= cpu_write_enables;
                        memory_write_data <= cpu_write_data;
                        memory_write_counter <= 0;
                        memory_write_enable_buff <= '1';
                    else
                        memory_access_mode <= msm_read_word;
                        memory_read_address <= cpu_next_address;
                        memory_read_counter <= 0;
                        memory_read_enable_buff <= '1';
                    end if;
                elsif cpu_hit then
                    for each_byte in 0 to cpu_data_width/8-1 loop
                        if or_reduce(cpu_write_enables)='1' then
                            if cpu_write_enables(each_byte)='1' then
                                block_rows(cpu_index)(
                                    cpu_way*2**cache_offset_width*8+cpu_offset*8+(each_byte+1)*8-1 downto 
                                    cpu_way*2**cache_offset_width*8+cpu_offset*8+each_byte*8) <=
                                    cpu_write_data(7+each_byte*8 downto 0+each_byte*8);
                            end if;
                        else
                            cpu_read_data(7+each_byte*8 downto 0+each_byte*8) <=
                                block_rows(cpu_index)(
                                cpu_way*2**cache_offset_width*8+cpu_offset*8+(each_byte+1)*8-1 downto 
                                cpu_way*2**cache_offset_width*8+cpu_offset*8+each_byte*8);
                        end if;
                    end loop;
                elsif not cpu_hit then
                    cpu_pause_buff <= '1';
                    if not memory_prepared then
                        memory_prepared <= True;
                        replace_write_enables <= cpu_write_enables;
                    else
                        memory_access_needed <= True;
                        memory_prepared <= False;
                        memory_way <= replace_way;
                        memory_cacheable <= '1';
                        replace_write_data <= cpu_write_data;
                        replace_offset <= cpu_offset;
                        tag_rows(cpu_index)((1+replace_way)*tag_width-1 downto replace_way*tag_width) <= cpu_tag;
                        memory_index <= cpu_index;
                        if valid_rows(cpu_index)(replace_way)='1' then
                            memory_access_mode <= msm_exchange_block;
                            memory_write_address(cpu_address_width-1 downto cache_cacheable_width) <= (others=>'0');
                            memory_write_address(cache_cacheable_width-1 downto cache_offset_width) <=
                                tag_rows(cpu_index)((1+replace_way)*tag_width-1 downto replace_way*tag_width) & 
                                std_logic_vector(to_unsigned(cpu_index,cache_index_width));
                            memory_write_address(cache_offset_width-1 downto 0) <= (others=>'0');
                            memory_write_counter <= 0;
                            memory_write_enables <= (others=>'1');
                            memory_write_enable_buff <= '1';
                            memory_write_data <= 
                                block_rows(cpu_index)(
                                replace_way*2**cache_offset_width*8+cpu_data_width-1 downto 
                                replace_way*2**cache_offset_width*8);
                        else
                            valid_rows(cpu_index)(replace_way) <='1';
                            memory_access_mode <= msm_read_block;
                        end if;
                        memory_read_address(cpu_address_width-1 downto cache_cacheable_width) <= (others=>'0');
                        memory_read_address(cache_cacheable_width-1 downto cache_offset_width) <=
                            cpu_tag & std_logic_vector(to_unsigned(cpu_index,cache_index_width));
                        memory_read_address(cache_offset_width-1 downto 0) <= (others=>'0');
                        memory_read_counter <= 0;
                        memory_read_enable_buff <= '1';
                    end if;
                end if;
            end if;
        end if;
    end process;
    

end Behavioral;