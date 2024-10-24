module SRAM(
    input clk, rst,
    input SRAM_WE_N,
    input [17:0] SRAM_ADDR,
    inout [15:0] SRAM_DQ
);
    reg [15:0] memory [0:511];
    assign SRAM_DQ = (SRAM_WE_N == 1'b1) ? memory[SRAM_ADDR] : 16'dz;

    always @(posedge clk) begin
        if (SRAM_WE_N == 1'b0) begin
            memory[SRAM_ADDR] = SRAM_DQ;
        end
    end
endmodule
//`timescale 1ns/1ns
/*module SRAM(clk, rst, SRAM_DQ, SRAM_ADDR, SRAM_UB_N, SRAM_LB_N, SRAM_WE_N,
            SRAM_CE_N, SRAM_OE_N);
  
	input clk,rst,SRAM_UB_N,SRAM_LB_N,SRAM_WE_N,SRAM_CE_N,SRAM_OE_N;
	inout[15:0] SRAM_DQ;
	input [17:0] SRAM_ADDR;
  
	reg [15:0] memory [0:63];
	
 	integer i;
	always@(posedge rst) begin
		if (rst) 
			for(i = 0; i <= 63; i = i+1) begin
				memory[i] = 16'bz;
			end
  	end
	
	always@(posedge clk) begin
		if(~SRAM_WE_N) memory[SRAM_ADDR] <= SRAM_DQ;
	end

	assign SRAM_DQ = SRAM_WE_N ? memory[SRAM_ADDR]: 16'bz;
endmodule*/