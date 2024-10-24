module ID_Stage (
	input clk,
	input rst,
	input hazard,
	input[3:0] Dest_wb, status,
	input[31:0] Result_WB,
	input writeBackEn,
	input[31:0] IF_PC_out,
	input [31:0] Instruction,
	output [8:0] CntrlUnt_MUX_out,
	output [31:0] Rn, Rm,
	output  imm, 
	output [11:0] shiftOp,
	output [23:0] Signed_imm_24,
	output [3:0] Dest, Rmd,
	output Two_src
);

wire cond_out, ID_MEM_W_EN;
wire [8:0] CntrlUnt_out;
wire [3:0] ID_RegFile_MUX_out, cond;
wire [31:0] ID_PC;
assign cond = Instruction[31:28];
assign ID_MEM_W_EN = CntrlUnt_out[4];
assign ID_PC = IF_PC_out;
assign imm = Instruction[25];
assign shiftOp = Instruction[11:0];
assign Signed_imm_24 = Instruction[23:0];
assign Dest = Instruction[15:12];
assign Two_src = (~imm) | ID_MEM_W_EN;
assign Rmd = ID_RegFile_MUX_out;
CntrlUnt CntrlUnt_Inst(
  Instruction[20],
  Instruction[27:26],
  Instruction[24:21],
  CntrlUnt_out
);
ID_MUX ID_MUX_Inst(
  ((~cond_out) | hazard),
	CntrlUnt_out,
	CntrlUnt_MUX_out
);
RegisterFile RegisterFile_Inst(
	clk, rst,
	Instruction[19:16], ID_RegFile_MUX_out, Dest_wb,
	Result_WB,
	writeBackEn,
	Rn, Rm
);
ID_RegFile_MUX ID_RegFile_MUX_Inst(
  ID_MEM_W_EN,
	Instruction[15:12],Instruction[3:0],
	ID_RegFile_MUX_out
);
ID_CondChck ID_CondChck_Inst(
  cond,
  status,
  cond_out
);
endmodule