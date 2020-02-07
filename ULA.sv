module ULA(
	input Su,
	input Eu,
	input [7:0] acumulador,
	input [7:0] registrador,
	output [7:0] resultado
);

always_ff @* begin
	if (Eu) begin
		if (Su == 1'b0) begin
			resultado = acumulador + registrador;
		end

		else if (Su == 1'b1) begin
			resultado = acumulador - registrador;
		end
	end

	else begin
		resultado = 8'dz;
	end
end

endmodule
