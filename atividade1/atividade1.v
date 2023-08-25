module atividade1(SW, HEX0);

input [17:0] SW;
output [0:6] HEX0;
wire [7:0] saida;


memoram ram(.address(SW[12:8]),
	.clock(SW[17]),
	.data(SW[7:0]),
	.wren(SW[16]),
	.q(saida));

decodificadorComportamental d(saida[3:0], HEX0);

/*
initial begin
	endereco = 0;
	SW[16] = 0;
	dado = 9;
	SW[17] = 0;
	$monitor("%b | %0d | %0d",saida, SW[17], SW[16]);
end

always begin
	#1; endereco = endereco + 1'b1;
end

always begin
	#9; SW[16] = ~SW[16];
end

always begin
	#1; SW[17] = ~SW[17];
end

*/

endmodule