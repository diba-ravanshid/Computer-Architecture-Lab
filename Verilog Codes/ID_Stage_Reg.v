module ID_Stage_Reg (
	input clk,
	input rst,
	input freeze,
	input[3:0] status_out,
	input [31:0] ID_PC,
	input[8:0] CntrlUnt_out,
	input[31:0] Rn, Rm,
	input  imm, 
	input [11:0] shiftOp,
	input [23:0] Signed_imm_24,
	input [3:0] Dest,
	input [3:0] src1, src2,
	
	output reg[31:0] ID_PC_out,
	output reg[8:0] CntrlUnt_reg_out,
	output reg [31:0] Rn_out, Rm_out,
	output reg [3:0] status_reg_out,
	output reg imm_out, 
	output reg[11:0] shiftOp_out,
	output reg[23:0] Signed_imm_24_out,
	output reg[3:0] Dest_out,
	output reg[3:0] src1_EXE, src2_EXE
);

always @(posedge clk, posedge rst) begin 
  if(rst) begin
    ID_PC_out <= 32'd0; 
	  CntrlUnt_reg_out <= 9'd0;
	  Rn_out <= 32'd0;
	  Rm_out <= 32'd0;
	  status_reg_out <= 4'd0;
	  imm_out <= 1'd0;
	  shiftOp_out <= 12'd0;
	  Signed_imm_24_out <= 24'd0;
	  Dest_out <= 4'd0;
	  src1_EXE <= 4'd0;
	  src2_EXE <= 4'd0;
  end
  else if (~freeze) begin
    ID_PC_out <= ID_PC; 
	  CntrlUnt_reg_out <= CntrlUnt_out;
	  Rn_out <= Rn;
	  Rm_out <= Rm;
	  status_reg_out <= status_out;
	  imm_out <= imm;
	  shiftOp_out <= shiftOp;
	  Signed_imm_24_out <= Signed_imm_24;
	  Dest_out <= Dest;
	  src1_EXE <= src1;
	  src2_EXE <= src2;
	end
end

endmodule
