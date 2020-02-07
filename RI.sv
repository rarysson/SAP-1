module RI(
	input Li,
	input CLK,
	input CLR,
	input Ei,
	input [7:0] barramento_w,
	input ciclo_busca,
	output [3:0] op_code,
	output [4:0] endereco_dado
);

logic [4:0] addrs_data;

initial begin
	addrs_data = 5'd0;
end

always_ff @(posedge CLK) begin
	if (CLR) begin
		op_code <= 4'd0;
		endereco_dado <= 5'd0;
	end

	if (!Li) begin
		if (!ciclo_busca) begin
			op_code <= barramento_w[3:0];
			addrs_data <= barramento_w[7:4];
		end
	end
	else if (!Ei) begin
		if (!ciclo_busca) begin
			endereco_dado <= addrs_data;
		end
	end
end

endmodule
