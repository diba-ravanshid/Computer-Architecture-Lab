module IF_MUX (
	input Branch_taken,
	input[31:0] BranchAddr, PC,
	output[31:0] IF_MUX_out
);

assign IF_MUX_out = Branch_taken ? BranchAddr : PC ;

endmodule



