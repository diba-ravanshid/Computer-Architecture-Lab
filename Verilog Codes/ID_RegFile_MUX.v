module ID_RegFile_MUX (
  input MEM_W_EN,
	input[3:0] In1,In2,
	output[3:0] ID_RegFile_MUX_out
);

assign ID_RegFile_MUX_out = MEM_W_EN ? In1: In2;

endmodule






