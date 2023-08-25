module atividade2(SW, HEX0, HEX1);

input [17:0] SW;
output [0:6] HEX0;
output [0:6] HEX1;
wire [7:0] saida;
wire [3:0] n1, n2;

memoram ram(.wraddress({2'b00, SW[15:13]}),
	.rdaddress(SW[12:8]),
	.clock(SW[17]),
	.data(SW[7:0]),
	.wren(SW[16]),
	.q(saida));

assign n1 = saida%10;
assign n2 = saida/10;
	
decodificadorComportamental d1(n1, HEX0);
decodificadorComportamental d2(n2, HEX1);

/*
initial begin
	SW[12:8] = 0;
	SW[16] = 0;
	SW[17] = 0;
	$monitor("%b | %0d | %0d | %b", saida, SW[17], SW[16], SW[12:8]);
end

always begin
	#3; SW[12:8] = SW[12:8] + 1'b1;
end

always begin
	#1; SW[17] = ~SW[17];
end
*/


endmodule