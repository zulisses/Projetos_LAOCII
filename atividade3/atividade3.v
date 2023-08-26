module atividade3(SW, HEX0, HEX1, HEX7, LEDR);

	// input e output da FBGA
	input [17:0] SW;
	output [17:15] LEDR;
	output [0:6] HEX0, HEX1, HEX7;
	
	

	wire clock_in, wren_in; // clock / write enable
	wire [7:0] data_in; // dado a ser escrito
	wire [4:0] endereco_in, tag_dirty; // endereço de escrita ou leitura / tag(ou endereco) que está com sujeira
	wire dirty_cache, validade, dirty_out; // bit de sujeira da cache  / bit de validade / bit de sujeira da cache para visualização 
	wire [1:0] lru; // lru para visualização
	wire [7:0] q_cache, q_menPrin; // dado de saida da cache / dado de saida da memoria principal
	wire hit_cache_out; // bit de hit da cache
	wire [7:0] q_out; // saida 
	
	// atribuição dos sinais de entrada e saida da FBGA
	assign clock_in = SW[17];
	assign wren_in = SW[16];
	assign data_in = SW[7:0];
	assign endereco_in = SW[12:8];
	assign LEDR[17] = hit_cache_out;
	assign LEDR[16] = validade;
	assign LEDR[15] = dirty_out;
	wire [3:0] d1, d2;
	assign d1 = q_out%10;
	assign d2 = q_out/10;
	decodificadorComportamental dig1(d1, HEX0);
	decodificadorComportamental dig2(d2, HEX1);
	decodificadorComportamental dig7(lru, HEX7);
	
	// modulo cacheL1
	cacheL1 cache(.clock_in(clock_in), .wren_in(wren_in), .endereco_in(endereco_in), .data_in(data_in), .data_memPrin_in(q_menPrin), .q_out(q_cache), .hit_out(hit_cache_out), .dirty_ctr_out(dirty_cache), .tag_dirty_out(tag_dirty), .lru_out(lru), .validade_out(validade), .dirty_out(dirty_out));
	
	// modulo memoria principal
	memoriaPrincipal memoria(.clock(clock_in), .wren(dirty_cache), .address(dirty_cache ? tag_dirty : endereco_in), .data(q_cache), .q(q_menPrin));
	
	// quando ocorre um hit na cache o dado de saida é a saida da cache, caso contratio a saida é o dado vindo da memoria
	assign q_out = hit_cache_out ? q_cache : q_menPrin;
	
endmodule