module Saida(
	input Lo,
	input CLK,
	input [7:0] barramento_w,
	output [7:0] saida
);

always_ff @(posedge CLK) begin
	if (!Lo) begin
		saida = barramento_w;
	end
end

endmodule
