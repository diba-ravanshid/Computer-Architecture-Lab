module EXE_Stage_Reg (
	input clk, rst, freeze,
	input WB_EN, MEM_R_EN, MEM_W_EN,
	input [31:0] ALU_Res, Val_Rm,
	input [3:0] Dest,
	output reg WB_EN_out, MEM_R_EN_out, MEM_W_EN_out,
	output reg[31:0] ALU_Res_out, Val_Rm_out,
	output reg [3:0] Dest_out
);

always @(posedge clk, posedge rst) begin 
  if(rst) begin
    Val_Rm_out <= 32'd0;
    ALU_Res_out <= 32'd0;
	  Dest_out <= 4'd0;
	  WB_EN_out <= 1'd0;
	  MEM_R_EN_out <= 1'd0;
	  MEM_W_EN_out <= 1'd0;
  end
  else if (~freeze) begin
    Val_Rm_out <= Val_Rm;
    ALU_Res_out <= ALU_Res;
	  Dest_out <= Dest;
	  WB_EN_out <= WB_EN;
	  MEM_R_EN_out <= MEM_R_EN;
	  MEM_W_EN_out <= MEM_W_EN;
	 end
end

endmodule

