library verilog;
use verilog.vl_types.all;
entity atividade3 is
    port(
        SW              : in     vl_logic_vector(17 downto 0);
        HEX0            : out    vl_logic_vector(0 to 6);
        HEX1            : out    vl_logic_vector(0 to 6);
        HEX7            : out    vl_logic_vector(0 to 6);
        LEDR            : out    vl_logic_vector(17 downto 15)
    );
end atividade3;
