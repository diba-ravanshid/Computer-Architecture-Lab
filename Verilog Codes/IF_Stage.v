module IF_Stage (
	input clk, rst, freeze, Branch_taken,
	input[31:0] BranchAddr,
	output[31:0] PC, Instruction
);

wire[31:0] IF_MUX_out;
wire[31:0] IF_PCReg_out; //??? reg or wire  ====>> wire!

IF_MUX IF_MUX_inst(
	Branch_taken,
	BranchAddr, PC,
	IF_MUX_out
);

IF_PCReg IF_PCReg_inst(
	clk, rst, freeze,
	IF_MUX_out,
	IF_PCReg_out
);

IF_InstMem IF_InstMem_inst(
	IF_PCReg_out,
	Instruction
);

IF_Adder IF_Adder_inst(
	IF_PCReg_out,
	PC
);

endmodule