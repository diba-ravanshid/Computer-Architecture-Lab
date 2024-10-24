module WB_MUX (
	input MEM_R_EN,
	input [31:0] ALU_Res, memData,
	output [31:0] WB_Value
);
	assign WB_Value = MEM_R_EN ? memData : ALU_Res;
endmodule