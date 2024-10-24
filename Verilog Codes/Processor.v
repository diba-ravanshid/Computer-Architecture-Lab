module Processor(
  input clk, rst
);

//IF Wires
wire hazard, freeze, Branch_taken, flush;
wire[31:0] IF_PC, IF_Instruction;
//ID Wires
wire[31:0] ID_PC, ID_Instruction;
wire[31:0] ID_Val_Rn, ID_Val_Rm;
wire imm, imm_out;
wire[11:0] shiftOp, shiftOp_out;
wire[23:0] Signed_imm_24, Signed_imm_24_out;
wire[8:0] ID_CntrlUnt_bits;
wire[3:0] ID_Dest, Rmd;
wire Two_src;
// Status Reg Wires
wire[3:0] status, status_bits;
// EXE Wires
wire[31:0] EXE_PC, BranchAddr, EXE_ALU_Res;
wire[3:0] EXE_status, EXE_Dest;
wire[31:0] EXE_Val_Rn, EXE_Val_Rm;
wire[8:0] EXE_CntrlUnt_bits;
wire EXE_S, EXE_WB_EN, EXE_MEM_R_EN, EXE_MEM_W_EN;
wire [31:0] Rm_out_EXE;
// SRAM Wires
wire MEM_WB_EN, MEM_MEM_W_EN, MEM_MEM_R_EN;
wire[3:0] MEM_Dest;
wire [31:0] MEM_ALU_Res, MEM_Val_Rm, MEM_memData;
wire ready, sram_freeze, SRAM_MUX_out;
wire [15:0] SRAM_DQ;
wire [17:0] SRAM_ADDR;
wire SRAM_UB_N, SRAM_LB_N, SRAM_WE_N, SRAM_CE_N, SRAM_OE_N;
// WB Wires
wire[3:0] WB_Dest;
wire[31:0] WB_Value;
wire WB_WB_EN;
wire WB_MEM_R_EN;
wire [31:0] WB_ALU_Res, WB_memData;
//Forwarding unit
wire forward_EN;
wire[3:0] src1_EXE, src2_EXE;
wire[3:0] src1, src2;
wire [1:0] sel_Src1, sel_Src2;

assign forward_EN = 1'b1;
assign src1 = ID_Instruction[19:16];
assign src2 = Rmd;
assign freeze = hazard;
assign flush = Branch_taken;
assign Branch_taken = EXE_CntrlUnt_bits[1];
assign EXE_S = EXE_CntrlUnt_bits[0];
assign sram_freeze = ~ready;

IF_Stage IF_Stage_inst(
	clk, rst, (freeze|sram_freeze), Branch_taken,
	BranchAddr,
	IF_PC, IF_Instruction
);
IF_Stage_Reg IF_Stage_Reg_inst(
	clk, rst, (freeze|sram_freeze), flush,
	IF_PC, IF_Instruction,
	ID_PC, ID_Instruction
);
ID_Stage ID_Stage_inst(
	clk,
	rst,
	hazard,
	WB_Dest, status,
	WB_Value,
	WB_WB_EN,
	ID_PC,
	ID_Instruction,
	ID_CntrlUnt_bits,
	ID_Val_Rn, ID_Val_Rm,
	imm, 
	shiftOp,
	Signed_imm_24,
	ID_Dest, Rmd,
	Two_src
);
ID_Stage_Reg ID_Stage_Reg_inst(
	clk,
	rst,
	sram_freeze,
	status,
	ID_PC,
	ID_CntrlUnt_bits,
	ID_Val_Rn, ID_Val_Rm,
	imm, 
	shiftOp,
	Signed_imm_24,
	ID_Dest,
	src1, src2,
	EXE_PC,
	EXE_CntrlUnt_bits,
	EXE_Val_Rn, EXE_Val_Rm,
	EXE_status,
	imm_out, 
	shiftOp_out,
	Signed_imm_24_out,
	EXE_Dest,
	src1_EXE, src2_EXE
);
EXE_Stage EXE_Stage_inst(
	clk,
	rst,
	EXE_PC,
	EXE_CntrlUnt_bits,
	EXE_Val_Rn, EXE_Val_Rm,
	EXE_status,
	imm_out, 
	shiftOp_out,
	Signed_imm_24_out,
	src1_EXE, src2_EXE,
	sel_Src2, sel_Src1,
	MEM_ALU_Res, WB_Value,
	EXE_WB_EN , EXE_MEM_R_EN, EXE_MEM_W_EN,
	status_bits,
	EXE_ALU_Res, BranchAddr,
	Rm_out_EXE
);
Status_Register Status_Register_inst(
	EXE_S, clk, rst,
	status_bits,
	status
);

HzrdDtctr_2 HzrdDtctr_2_inst(
	MEM_WB_EN, EXE_WB_EN, Two_src, EXE_MEM_R_EN,
	EXE_Dest, MEM_Dest, src1, src2,
	forward_EN,
	hazard
);
EXE_Stage_Reg EXE_Stage_Reg_inst(
	clk, rst, sram_freeze,
	EXE_WB_EN, EXE_MEM_R_EN, EXE_MEM_W_EN,
	EXE_ALU_Res, Rm_out_EXE,
	EXE_Dest,
	MEM_WB_EN, MEM_MEM_R_EN, MEM_MEM_W_EN,
	MEM_ALU_Res, MEM_Val_Rm,
	MEM_Dest
);
SRAM Sram_inst(
    clk, rst,
    MEM_MEM_W_EN,
    SRAM_ADDR,
    SRAM_DQ
);
SRAM_Controller SRAM_Controller_inst( 
  clk, rst, 
  MEM_MEM_W_EN, MEM_MEM_R_EN,
  MEM_ALU_Res, MEM_Val_Rm, 
  
  MEM_memData,
  ready,
  SRAM_DQ,
  SRAM_ADDR,
  SRAM_UB_N,
  SRAM_LB_N,
  SRAM_WE_N,
  SRAM_CE_N,
  SRAM_OE_N  
);
SRAM_MUX SRAM_MUX_inst(
  sram_freeze,
	MEM_WB_EN,
	SRAM_MUX_out
);
MEM_Stage_Reg MEM_Stage_Reg_inst(
	clk, rst, sram_freeze, SRAM_MUX_out, MEM_MEM_R_EN,
	MEM_ALU_Res, MEM_memData,
	MEM_Dest,
	WB_WB_EN, WB_MEM_R_EN,
	WB_ALU_Res, WB_memData,
	WB_Dest
);
WB_MUX WB_MUX_inst(
  WB_MEM_R_EN,
	WB_ALU_Res, WB_memData,
	WB_Value
);
Forward_Unit Forward_Unit_inst(
    forward_EN,
    src1_EXE, src2_EXE,
    MEM_WB_EN, WB_WB_EN,
    MEM_Dest, WB_Dest,
    sel_Src1, sel_Src2
    );
    
endmodule

