module Registrador(
	input Lb,
	input CLK,
	input barramento_w,
	output data_out_ula
);

always_ff @(posedge CLK) begin
	if (!Lb) begin
		data_out_ula = barramento_w;
	end
end

endmodule
