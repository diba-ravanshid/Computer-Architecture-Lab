module IF_Adder (
	input[31:0] IF_PCReg_out,
	output[31:0] PC
);

assign PC = IF_PCReg_out + 4;

endmodule



