`timescale 1 ns/ 1 ns
module ARM_TB();

  reg clk,rst;
  
	Processor Processor_inst( 
   clk, rst
  );

	always begin
    #5 clk = ~clk;
  end
  
  initial begin
    rst = 1'b0;
    clk = 1'b0;
    #11 rst = 1'b1;
    #41 rst = 1'b0;

    #3000 $stop;
  end 

endmodule






