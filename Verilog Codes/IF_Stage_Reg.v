module IF_Stage_Reg (
	input clk, rst, freeze, flush,
	input[31:0] PC, Instruction_in,
	output reg[31:0] PC_out, Instruction
);

always @(posedge clk, posedge rst) begin 
  if(rst) begin
    PC_out <= 32'd0; 
    Instruction <= 32'd0;
  end
  else if(~freeze) begin
    PC_out <= PC;
    Instruction <= Instruction_in;
  end
end

endmodule

