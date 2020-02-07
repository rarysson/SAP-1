module Acumulador(
	input La,
	input CLK,
	input Ea,
	input [7:0] barramento_w,
	output [7:0] data_out_barramento,
	output [7:0] data_out_ula
);

logic [7:0] valor;

initial begin
	valor = 8'd0;
end

always_ff @(posedge CLK) begin
	if (!La) begin
		valor <= barramento_w;
		data_out_ula <= valor;
	end
	if (Ea) begin
		data_out_barramento <= valor;
	end
end

endmodule
