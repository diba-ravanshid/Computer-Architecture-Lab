module IF_PCReg (
	input clk, rst, freeze,
	input[31:0] IF_MUX_out,
	output reg[31:0] IF_PCReg_out
);

always @(posedge clk, posedge rst) begin //??? or or comma
  if(rst) begin
    IF_PCReg_out <= 32'd0; //??? = or <=
  end
  else if(~freeze) begin
    IF_PCReg_out <= IF_MUX_out;
  end
end

endmodule



