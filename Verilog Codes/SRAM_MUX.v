module SRAM_MUX (
  input sel,
	input MEM_WB_EN,
	output SRAM_MUX_out
);

assign SRAM_MUX_out = sel ? 1'd0: MEM_WB_EN;

endmodule


