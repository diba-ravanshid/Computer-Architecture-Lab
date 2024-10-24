module DataMem (
  input clk, rst, MEM_W_EN, MEM_R_EN,
	input [31:0] ALU_Res, Rm_Val,
	output reg[31:0] memData
);
	wire [31:0] aligned_add, add;
	reg [31:0] memory [0:63];
	
	assign add = ALU_Res - 32'd1024;
	assign aligned_add = {2'b00, add[31:2]};
	
  integer i;	
	always @(negedge clk, posedge rst) begin 
		if (rst) 
			for (i = 0; i < 64; i = i + 1) begin
				memory[i] = 32'd0;
			end
		else if (MEM_W_EN) 
			memory[aligned_add] <= Rm_Val; 
	end
	
	//assign memData = memory[aligned_add];
	always @(MEM_R_EN, aligned_add) begin
    if (MEM_R_EN)
      memData = memory[aligned_add];
  end
	
endmodule