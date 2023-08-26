module cacheL1(clock_in, wren_in, endereco_in, data_in, data_memPrin_in, q_out, hit_out, dirty_out, tag_dirty_out, lru_out, validade_out, dirty_final);
	input clock_in, wren_in;
	input [4:0] endereco_in;
	input [7:0] data_in, data_memPrin_in;
	output [7:0] q_out;
	output reg [4:0] tag_dirty_out;
	output reg hit_out, dirty_out, validade_out, dirty_final;
	output reg [1:0] lru_out;

	reg [2:0] i, j, i_writeBack;
	reg existe_validade0, break, miss_aux, aux_dirty;
	reg ativa_memoria;

	reg [4:0] tags [0:3];
	reg [1:0] lrus [0:3];
	reg validades [0:3];
	reg dirty [0:3];

	memoriaCache memoria(.clock(clock_in), .wren(ativa_memoria), .data(~hit_out ? data_memPrin_in : data_in), .q(q_out), .address(i));

	initial begin
		for (i = 0; i <= 3; i = i + 1) begin
			dirty[i] = 0;
		end
		
		validades[0] = 1;
		validades[1] = 1;
		validades[2] = 0;
		validades[3] = 1;
		
		lrus[0] = 0;
		lrus[1] = 1;
		lrus[2] = 3;
		lrus[3] = 2;
		
		tags[0] = 5'b10100;
		tags[1] = 5'b10110;
		tags[2] = 5'b11001;
		tags[3] = 5'b10101;
		
		dirty_out = 0;
		
	end
	
	always @(posedge clock_in) begin
		
		hit_out = 0;
		for (i = 0; i <= 3 && hit_out == 0; i = i + 1) begin
			if(endereco_in == tags[i] && validades[i] == 1'b1) begin
				hit_out = 1;
			end
		end
		
		if(hit_out == 1)
			i = i - 1;

		
		ativa_memoria = (~hit_out && ~aux_dirty) ? 1 : wren_in;
		
		if(hit_out == 1) begin // cache hit
			for (j = 0; j <= 3; j = j + 1) begin
				if(j != i && lrus[j] < lrus[i])
					lrus[j] = lrus[j] + 1;
			end
			lrus[i] = 0;
			
			if(wren_in == 1) begin
				dirty[i] = 1;
			end
			
			miss_aux = 0;
			aux_dirty = 1;
		end else begin // cache miss
			aux_dirty = 0;
		
				if(miss_aux == 1) begin
				
					existe_validade0 = 0;
					for (i = 0; i <= 3 && existe_validade0 == 0; i = i + 1) begin
						if(validades[i] == 0) begin
							existe_validade0 = 1;
						end
					end
					
					if(~existe_validade0) begin
						break = 0;
						for (i = 0; i <= 3 && break == 0; i = i + 1) begin
							if(lrus[i] == 3) begin
								break = 1;
							end
						end
					end
					
					i = i - 1;
					
					dirty_out = dirty[i];
					tag_dirty_out = tags[i];
					
					if(dirty[i]) begin // escrita mem principal
					
						dirty[i] = 0;
						aux_dirty = 1;
						
						ativa_memoria = (~hit_out && aux_dirty) ? 1 : wren_in;
					
					end else begin
					
						for (j = 0; j <= 3; j = j + 1) begin
							if(j != i && lrus[j] < lrus[i])
								lrus[j] = lrus[j] + 1;
						end
						lrus[i] = 0;
						
						
						validades[i] = 1;
						tags[i] = endereco_in;
						
						if(wren_in == 1) begin
							dirty[i] = 1;
						end
					end
				
				end
					
				miss_aux = 1;
			
		end
		
		lru_out = lrus[i];
		validade_out = validades[i];
		dirty_final = dirty[i];
		
	end

endmodule