module ID_MUX (
  input sel,
	input[8:0] CntrlUnt_out,
	output[8:0] CntrlUnt_MUX_out
);

assign CntrlUnt_MUX_out = sel ? 8'd0: CntrlUnt_out;

endmodule
