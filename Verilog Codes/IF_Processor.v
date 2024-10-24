module IF_Processor(
  input clk, rst,
	output[31:0] WB_PC_out
);

wire freeze, Branch_taken, flush;
wire[31:0] BranchAddr, PC, Instruction, IF_PC_out, IF_Instruction_out;
wire[31:0] ID_PC, ID_PC_out, EXE_PC, EXE_PC_out, MEM_PC, MEM_PC_out, WB_PC;

// WARNING !!!
assign {freeze, Branch_taken, BranchAddr, flush} = 35'd0;

IF_Stage IF_Stage_Inst(
	clk, rst, freeze, Branch_taken,
	BranchAddr,
	PC, Instruction
);

IF_Stage_Reg IF_Stage_Reg_Inst(
	clk, rst, freeze, flush,
	PC, Instruction,
	IF_PC_out, IF_Instruction_out
);

ID_Stage ID_Stage_Inst (
	clk,
	rst,
	IF_PC_out,
	ID_PC
);

ID_Stage_Reg ID_Stage_Reg_Inst(
	clk, rst,
	ID_PC,
	ID_PC_out
);

EXE_Stage EXE_Stage_Inst (
	clk,
	rst,
	ID_PC_out,
	EXE_PC
);

EXE_Stage_Reg EXE_Stage_Reg_Inst(
	clk, rst,
	EXE_PC,
	EXE_PC_out
);

MEM_Stage MEM_Stage_Inst (
	clk,
	rst,
	EXE_PC_out,
	MEM_PC
);

MEM_Stage_Reg MEM_Stage_Reg_INst(
	clk, rst,
	MEM_PC,
	MEM_PC_out
);

WB_Stage WB_Stage_Inst (
	clk,
	rst,
	MEM_PC_out,
	WB_PC
);

WB_Stage_Reg WB_Stage_Reg_Inst(
	clk, rst,
	WB_PC,
	WB_PC_out
);

endmodule


