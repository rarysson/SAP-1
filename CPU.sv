module CPU(
	input clock,
	input reset,
	output [7:0] resultado_programa
);

logic Cp;
logic Ep;
logic Lm;
logic CE;
logic Li;
logic Ei;
logic La;
logic Ea;
logic Su;
logic Eu;
logic Lb;
logic Lo;
logic busca;
logic [3:0] codigo_de_operacao;
logic [4:0] endereco;
logic [7:0] barramento;

initial begin
	busca = 1'b1;
end

Controlador controlador(
	.clock(clock),
	.reset(reset),
	.operacao(codigo_de_operacao),
	.estado_atual(estado),
	.Cp(Cp),
	.Ep(Ep),
	.Lm(Lm),
	.CE(CE),
	.Li(Li),
	.Ei(Ei),
	.La(La),
	.Ea(Ea),
	.Su(Su),
	.Eu(Eu),
	.Lb(Lb),
	.Lo(Lo)
);

always_ff @(estado) begin
	if (estado > 4'd3) begin
		endereco <= endereco_dado;
		busca <= 1'b0;
	end
	else begin
		endereco <= endereco_rem;
		busca <= 1'b1;
	end
end

logic [7:0] barramento_pc;
PC pc(
	.Cp(Cp),
	.CLK(clock),
	.CLR(reset),
	.Ep(Ep),
	.proximo_endereco(barramento_pc)
);

logic [4:0] endereco_rem;
REM rem(
	.Lm(Lm),
	.CLK(clock),
	.barramento_w(barramento_pc),
	.endereco_da_memoria(endereco_rem)
);

RAM ram(
	.CE(CE),
	.endereco_pc(endereco_rem),
	.endereco_dado(endereco_dado),
	.ciclo_busca(busca),
	.barramento_w(barramento)
);

logic [4:0] endereco_dado;
RI ri(
	.Li(Li),
	.CLK(clock),
	.CLR(reset),
	.Ei(Ei),
	.barramento_w(barramento),
	.ciclo_busca(busca),
	.op_code(endereco_dado),
	.endereco_dado(codigo_de_operacao)
);

logic [7:0] valor_ula_reg_a, barramento_reg_a;
Acumulador registrador_a(
	.La(La),
	.CLK(clock),
	.Ea(Ea),
	.barramento_w(barramento),
	.data_out_barramento(barramento_reg_a),
	.data_out_ula(valor_ula_reg_a)
);

logic [7:0] valor_ula_reg_b;
Registrador registrador_b(
	.Lb(Lb),
	.CLK(clock),
	.barramento_w(barramento),
	.data_out_ula(valor_ula_reg_b)
);

ULA ula(
	.Su(Su),
	.Eu(Eu),
	.acumulador(valor_ula_reg_a),
	.registrador(valor_ula_reg_b),
	.resultado(barramento)
);

Saida registrador_saida(
	.Lo(Lo),
	.CLK(clock),
	.barramento_w(barramento),
	.saida(resultado_programa)
);

endmodule
