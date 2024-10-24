module RegisterFile (
	input clk, rst,
	input[3:0] src1, src2, Dest_wb,
	input[31:0] Result_WB,
	input writeBackEn,
	output[31:0] reg1, reg2
);
reg [31:0] regfile[0:14];

integer j;
assign reg1 = regfile[src1];
assign reg2 = regfile[src2];
always @(negedge clk, posedge rst) begin 
  if(rst) begin
    for (j=0; j<15; j=j+1)
      begin 
        regfile[j] <= j;
      end
  end
  else if(writeBackEn) begin
    regfile[Dest_wb] <= Result_WB;    
  end
end
endmodule

