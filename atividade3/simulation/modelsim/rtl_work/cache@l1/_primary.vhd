library verilog;
use verilog.vl_types.all;
entity cacheL1 is
    port(
        clock_in        : in     vl_logic;
        wren_in         : in     vl_logic;
        endereco_in     : in     vl_logic_vector(4 downto 0);
        data_in         : in     vl_logic_vector(7 downto 0);
        data_memPrin_in : in     vl_logic_vector(7 downto 0);
        q_out           : out    vl_logic_vector(7 downto 0);
        hit_out         : out    vl_logic;
        dirty_ctr_out   : out    vl_logic;
        tag_dirty_out   : out    vl_logic_vector(4 downto 0);
        lru_out         : out    vl_logic_vector(1 downto 0);
        validade_out    : out    vl_logic;
        dirty_out       : out    vl_logic
    );
end cacheL1;
