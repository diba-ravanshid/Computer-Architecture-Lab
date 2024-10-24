module EXE_Stage (
	input clk,
	input rst,
	input[31:0] ID_PC_out,
	input[8:0] CntrlUnt_reg_out,
	input [31:0] Rn_out, Rm_out,
	input [3:0] status_reg_out,
	input imm_out, 
	input[11:0] shiftOp_out,
	input[23:0] Signed_imm_24_out,
	input [3:0] src1,src2,
	input [1:0] sel_src2, sel_src1,
	input [31:0] ALU_Res_Mem, WB_Value,
	
	output wb_en , mem_r_en, mem_w_en,
	output[3:0] status_bits,
	output[31:0] ALU_Res, Brach_Address,
	output [31:0] Rm_out_EXE
);
wire[31:0] val2, val1;
wire[31:0] Rm_mux_out;

val2gen val2gen_Inst(
  Rm_mux_out,
  shiftOp_out,
  imm_out,(mem_r_en || mem_w_en),
  val2
);

ALU ALU_Inst(
  val1, val2,
  CntrlUnt_reg_out[8:5],
  status_reg_out,
  status_bits,
  ALU_Res
);

Adder Adder_Inst(
  ID_PC_out, {{6{Signed_imm_24_out[23]}}, Signed_imm_24_out, 2'b00},
  Brach_Address
);
EXE_Mux1 EXE_Mux1_Inst(
	Rn_out, ALU_Res_Mem, WB_Value,
	sel_src1,
	val1
);

EXE_Mux2 EXE_Mux2_Inst(
	Rm_out, ALU_Res_Mem, WB_Value,
	sel_src2,
	Rm_mux_out
);
assign { mem_w_en, mem_r_en, wb_en } = CntrlUnt_reg_out[4:2];
assign Rm_out_EXE = Rm_mux_out;
endmodule