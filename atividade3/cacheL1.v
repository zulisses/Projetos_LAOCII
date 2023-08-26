module cacheL1(clock_in, wren_in, endereco_in, data_in, data_memPrin_in, q_out, hit_out, dirty_ctr_out, tag_dirty_out, lru_out, validade_out, dirty_out);
	
	// input e output do modulo da cache
	input clock_in, wren_in; // clock / write enable
	input [4:0] endereco_in; // endereço de escrita ou leitura
	input [7:0] data_in, data_memPrin_in; // dado a ser escrito quando ocorre um hit na escrita / dado a ser escrito vindo da memoria quando ocorrer um miss
	output [7:0] q_out; // saida da cache
	output reg [4:0] tag_dirty_out; // tag(ou endereco) que está com sujeira
	output reg hit_out, dirty_ctr_out, validade_out, dirty_out; // bit de hit / bit de sujeira da posição i para controle / bit de validade da posição i / bit de sujeira da posição i para visualização
	output reg [1:0] lru_out; // lru para vizualizacao

	reg [2:0] i, j; // index para buscar dado na cache / auxiliar para usar em for para atualizar os lrus
	reg existe_validade0, break, miss_aux, aux_dirty; // bit que indica se existe alguma validade igual a 0, e támbem usado para quebra do for / auxiliar para quebra do for quando encontar um lru == 3
	reg wren_cache; // bit usado para controlar a escrita na cache

	reg [4:0] tags [0:3]; // memoria das tags
	reg [1:0] lrus [0:3]; // memoria dos lrus
	reg validades [0:3]; // memoria das validades
	reg dirty [0:3]; // memoria das sujeiras

	// memoria dos dados
	memoriaCache memoria(.clock(clock_in), .wren(wren_cache), .data(~hit_out ? data_memPrin_in : data_in), .q(q_out), .address(i));

	initial begin // inicialização das memorias das tags, lrus, validades e sujeiras
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
		
		dirty_ctr_out = 0;
		
	end
	
	always @(posedge clock_in) begin
		
		
		// verifica a ocorrencia de hit e salva o index em que o hit ocorreu comparano as tags e as validades
		hit_out = 0; 
		for (i = 0; i <= 3 && hit_out == 0; i = i + 1) begin
			if(endereco_in == tags[i] && validades[i] == 1'b1) begin
				hit_out = 1;
			end
		end
		
		// ajusra o index caso ocorra um hit
		if(hit_out == 1)
			i = i - 1;

		// logica usada para quando der hit na cache ou quando tiver um miss com bit de sujeira == 0
		wren_cache = (~hit_out && ~aux_dirty) ? 1 : wren_in;
		
		if(hit_out == 1) begin // cache hit
		
			// ajusta os lrus
			for (j = 0; j <= 3; j = j + 1) begin
				if(j != i && lrus[j] < lrus[i])
					lrus[j] = lrus[j] + 1;
			end
			lrus[i] = 0;
			
			// aciona o dirty no index do hit caso seja uma escrita
			if(wren_in == 1) begin
				dirty[i] = 1;
			end
			
			// variaveis de controle auxiliares 
			miss_aux = 0;
			aux_dirty = 0;
		end else begin // cache miss
			
			aux_dirty = 0;
			
				
				// faz com que quando ocorra um miss a cache permaneça nesse estado por mais tempo para que ela possa ser atualizada com a dado vindo da memoria 
				if(miss_aux == 1) begin
					// procura uma posição em que o bit de validade seja 0
					existe_validade0 = 0;
					for (i = 0; i <= 3 && existe_validade0 == 0; i = i + 1) begin
						if(validades[i] == 0) begin
							existe_validade0 = 1;
						end
					end
					
					// caso não encontre o bit de validade == 0 e procurado um lru igual a 3
					if(~existe_validade0) begin
						break = 0;
						for (i = 0; i <= 3 && break == 0; i = i + 1) begin
							if(lrus[i] == 3) begin
								break = 1;
							end
						end
					end
					
					// ajusta o valor de i para que ele possa ser usado como index
					i = i - 1;
					
					
					// atualiza os registradores de saida da tag e o bit de sujeira para serem passado para a memoria principal 
					dirty_ctr_out = dirty[i];
					tag_dirty_out = tags[i];
					
					if(dirty[i]) begin // caso a posição a ser buscada na memoria estiver com sujeira a cache é atrasad em um ciclo para que a memoria principal possar ser atualizada 
						
						dirty[i] = 0;
						aux_dirty = 1;
						
						// logica usada quando tiver um miss e bit de sujeira == 1
						wren_cache = (~hit_out && aux_dirty) ? 1 : wren_in;
					
					end else begin
						
						// atualiza os lrus 
						for (j = 0; j <= 3; j = j + 1) begin
							if(j != i && lrus[j] < lrus[i])
								lrus[j] = lrus[j] + 1;
						end
						lrus[i] = 0;
						
						// atualiza a validade e a tag do index
						validades[i] = 1;
						tags[i] = endereco_in;
						
						// caso seja uma escrita o bit de sujeirta é habilitado 
						if(wren_in == 1) begin
							dirty[i] = 1;
						end
					end
				
				end
					
				miss_aux = 1;
			
		end
		
		// atribuição dos valores de saida para visualização
		lru_out = lrus[i];
		validade_out = validades[i];
		dirty_out = dirty[i];
		
	end

endmodule