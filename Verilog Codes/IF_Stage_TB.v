`timescale 1 ns/ 1 ns
module IF_Stage_TB();

  reg clk,rst;
  wire[31:0] WB_PC_out;
  
	IF_Processor IF_Processor_inst( 
   clk, rst,
	 WB_PC_out
  );

	always begin
    #5 clk = ~clk;
  end
  
  initial begin
    rst = 1'b0;
    clk = 1'b0;
    #11 rst = 1'b1;
    #11 rst = 1'b0;

    #771 $stop;
  end 

endmodule
