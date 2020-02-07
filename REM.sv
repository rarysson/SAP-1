module REM(
	input Lm,
	input CLK,
	input [7:0] barramento_w,
	output [4:0] endereco_da_memoria
);

always_ff @(posedge CLK) begin
	if (!Lm) begin
		endereco_da_memoria = {1'b0, barramento_w[3:0]};
	end
end

endmodule
