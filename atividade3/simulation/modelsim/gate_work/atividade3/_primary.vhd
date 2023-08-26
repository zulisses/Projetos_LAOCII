library verilog;
use verilog.vl_types.all;
entity atividade3 is
    port(
        clock           : in     vl_logic;
        wren            : in     vl_logic;
        endereco        : in     vl_logic_vector(6 downto 0);
        data            : in     vl_logic_vector(6 downto 0);
        saida           : out    vl_logic_vector(6 downto 0);
        hit             : out    vl_logic
    );
end atividade3;
