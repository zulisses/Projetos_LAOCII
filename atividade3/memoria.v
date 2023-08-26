module memoria(clock_in, wren_in, endereco_in, data_in, q_out, hit_cache_out, hit_memPrin_out);

	input clock_in, wren_in;
	input [4:0] endereco_in;
	input [7:0] data_in;
	output hit_cache_out, hit_memPrin_out;
	output [7:0] q_out;
	
	wire [7:0] q_cache, q_menPrin;
	wire ativaMenPrin, dirty_cache;
	
	
	cacheL1 cache(.clock_in(clock_in), .wren_in(wren_in), .endereco_in(endereco_in), .data_in(data_in), .hit_menPrin_in(hit_menPrin_out), .data_memPrin_in(q_menPrin), .q_out(q_cache), .hit_out(hit_cache_out), .dirty_out(dirty_cache));
	
	memoriaPrincipal memoria(.clock(clock_in), .wren(dirty_cache), .address(endereco_in), .data(q_cache), .clken(ativaMenPrin), .q(q_menPrin));
	
	assign ativaMenPrin = ~hit_cache_out;
	assign q_out = hit_cache_out ? q_cache : hit_memPrin_out ? q_menPrin : 8'bxxxxxxxx;

endmodule