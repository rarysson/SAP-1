module RAM(
	input CE,
	input [4:0] endereco_pc,
	input [4:0] endereco_dado,
	input ciclo_busca,
	output [7:0] barramento_w
);

logic [7:0] memoria [0:15];
logic [3:0] LDA;
logic [3:0] ADD;
logic [3:0] SUB;
logic [3:0] OUT;
logic [3:0] HLT;

initial begin
	LDA = 4'b0000;
	ADD = 4'b0001;
	SUB = 4'b0010;
	OUT = 4'b1110;
	HLT = 4'b1111;
end


always_ff @(CE) begin
	memoria[0] = {LDA, 4'd10};
	memoria[1] = {ADD, 4'd11};
	memoria[2] = {ADD, 4'd12};
	memoria[3] = {SUB, 4'd13};
	memoria[4] = {OUT, 4'd0};
	memoria[5] = {HLT, 4'd0};
	memoria[6] = 8'd0;
	memoria[7] = 8'd0;
	memoria[8] = 8'd0;
	memoria[9] = 8'd0;
	memoria[10] = 8'd1;
	memoria[11] = 8'd4;
	memoria[12] = 8'd5;
	memoria[13] = 8'd6;
	memoria[14] = 8'd0;
	memoria[15] = 8'd0;

	if (!CE) begin
		if (ciclo_busca) begin
			barramento_w <= memoria[endereco_pc];
		end
		else begin
			barramento_w <= memoria[endereco_dado];
		end
	end
	else begin
		barramento_w <= 8'dz;
	end
end

endmodule
