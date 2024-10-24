module MEM_Stage_Reg (
	input clk, rst, freeze, WB_EN, MEM_R_EN,
	input[31:0] ALU_Res, memData,
	input[3:0] Dest,
	output reg WB_EN_out, MEM_R_EN_out,
	output reg[31:0] ALU_Res_out, memData_out,
	output reg[3:0] Dest_out
);

always @(posedge clk, posedge rst) begin //??? or or comma
  if(rst) begin
    WB_EN_out <= 1'd0;
	MEM_R_EN_out <= 1'd0;
	ALU_Res_out <= 32'd0;
	memData_out <= 32'd0;
	Dest_out <= 4'd0;
  end
  else if (~freeze) begin
    WB_EN_out <= WB_EN;
	MEM_R_EN_out <= MEM_R_EN;
	ALU_Res_out <= ALU_Res;
	memData_out <= memData;
	Dest_out <= Dest;
	end
end

endmodule