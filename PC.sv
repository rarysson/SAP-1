module PC(
	input Cp,
	input CLK,
	input CLR,
	input Ep,
	output [7:0] proximo_endereco
);

logic [3:0] endereco_atual;

initial begin
	endereco_atual = 4'd0;
end

always_ff @(negedge CLK) begin
	if (CLR) begin
		endereco_atual <= 4'd0;
	end

	if (Ep) begin
		proximo_endereco <= endereco_atual;
	end
	else if (Cp & (endereco_atual < 4'b1111)) begin
		endereco_atual <= endereco_atual + 4'd1;
	end
end

endmodule
