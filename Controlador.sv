module Controlador(
	input clock,
	input reset,
	input [3:0] operacao,
	output [3:0] estado_atual,
	output Cp,
	output Ep,
	output Lm,
	output CE,
	output Li,
	output Ei,
	output La,
	output Ea,
	output Su,
	output Eu,
	output Lb,
	output Lo
);

logic [3:0] LDA_t;
logic [3:0] ADD_t;
logic [3:0] SUB_t;
logic [3:0] OUT_t;
logic [3:0] HLT_t;
logic [3:0] T0_t;
logic [3:0] T1_t;
logic [3:0] T2_t;
logic [3:0] T3_t;
logic [3:0] T4_t;
logic [3:0] T5_t;
logic [3:0] T6_t;
logic [3:0] proximo_estado;
logic LDA;
logic ADD;
logic SUB;
logic OUT;
logic T1;
logic T2;
logic T3;
logic T4;
logic T5;
logic T6;

initial begin
	LDA_t = 4'b0000;
	ADD_t = 4'b0001;
	SUB_t = 4'b0010;
	OUT_t = 4'b1110;
	HLT_t = 4'b1111;
	T0_t = 4'd0;
	T1_t = 4'd1;
	T2_t = 4'd2;
	T3_t = 4'd3;
	T4_t = 4'd4;
	T5_t = 4'd5;
	T6_t = 4'd6;
	LDA = 1'b0;
	ADD = 1'b0;
	SUB = 1'b0;
	OUT = 1'b0;
	T1 = 1'b0;
	T2 = 1'b0;
	T3 = 1'b0;
	T4 = 1'b0;
	T5 = 1'b0;
	T6 = 1'b0;
	estado_atual = T0_t;
	proximo_estado = T1_t;
end

always_ff @(posedge clock) begin
	if (reset) begin
		{Cp, Ep, Lm, CE, Li, Ei, La, Ea, Su, Eu, Lb, Lo} <= 12'b0011_1110_0011;
	end
	else begin
		estado_atual <= proximo_estado;

		Cp <= T2;
		Ep <= T1;
		Lm <= ~(T1 | (LDA & T4) | (ADD & T4) | (SUB & T4));
		CE <= ~(T3 | (LDA & T5) | (ADD & T5) | (SUB & T5));
		Li <= ~T3;
		Ei <= ~((ADD & T4) | (LDA & T4) | (SUB & T4));
		La <= ~((LDA & T5) | (ADD & T6) | (SUB & T6));
		Ea <= OUT & T4;
		Su <= SUB & T6;
		Eu <= (ADD & T6) | (SUB & T6);
		Lb <= ~((ADD & T5) | (SUB & T5));
		Lo <= ~(OUT & T4);
	end
end

always_ff @(negedge clock) begin
	T1 <= 1'b0;
	T2 <= 1'b0;
	T3 <= 1'b0;
	T4 <= 1'b0;
	T5 <= 1'b0;
	T6 <= 1'b0;
	LDA <= 1'b0;
	ADD <= 1'b0;
	SUB <= 1'b0;
	OUT <= 1'b0;

	if (reset) begin
		proximo_estado <= T1_t;
	end
	else begin
		case (estado_atual)
		T1_t: begin
			T1 <= 1'b1;
			proximo_estado <= T2_t;
		end
		T2_t: begin
			T2 <= 1'b1;
			proximo_estado <= T3_t;
		end
		T3_t: begin
			T3 <= 1'b1;
			proximo_estado <= T4_t;
		end
		T4_t: begin
			T4 <= 1'b1;
			proximo_estado <= T5_t;

			case (operacao)
			LDA_t: begin
				LDA <= 1'b1;
			end
			OUT_t: begin
				OUT <= 1'b1;
			end
			HLT_t: begin
				proximo_estado <= T0_t;
			end
			ADD_t: begin
				ADD <= 1'b1;
			end
			SUB_t: begin
				SUB <= 1'b1;
			end
			default: begin
				LDA <= 1'b0;
				ADD <= 1'b0;
				SUB <= 1'b0;
				OUT <= 1'b0;
			end
			endcase
		end
		T5_t: begin
			T5 <= 1'b1;
			proximo_estado <= T6_t;

			case (operacao)
			LDA_t: begin
				LDA <= 1'b1;
			end
			OUT_t: begin
				OUT <= 1'b1;
			end
			ADD_t: begin
				ADD <= 1'b1;
			end
			SUB_t: begin
				SUB <= 1'b1;
			end
			default: begin
				LDA <= 1'b0;
				ADD <= 1'b0;
				SUB <= 1'b0;
				OUT <= 1'b0;
			end
			endcase
		end
		T6_t: begin
			T6 <= 1'b1;
			proximo_estado <= T1_t;

			case (operacao)
			LDA_t: begin
				LDA <= 1'b1;
			end
			OUT_t: begin
				OUT <= 1'b1;
			end
			ADD_t: begin
				ADD <= 1'b1;
			end
			SUB_t: begin
				SUB <= 1'b1;
			end
			default: begin
				LDA <= 1'b0;
				ADD <= 1'b0;
				SUB <= 1'b0;
				OUT <= 1'b0;
			end
			endcase
		end
		default: begin
			T1 <= 1'b0;
			T2 <= 1'b0;
			T3 <= 1'b0;
			T4 <= 1'b0;
			T5 <= 1'b0;
			T6 <= 1'b0;
		end
		endcase
	end
end

endmodule
