module HzrdDtctr (
	input MEM_WB_EN, EXE_WB_EN, Two_src,
	input [3:0] EXE_Dest, MEM_Dest, src1, src2,
	output Hazard
);

 	  assign Hazard = ((EXE_WB_EN == 1'b1)&&(src2 == EXE_Dest)) ||
	   ((MEM_WB_EN == 1'b1)&&(src2 == MEM_Dest)) ||
	   ((EXE_WB_EN == 1'b1)&&(Two_src && (src1 == EXE_Dest)))||
	   ((MEM_WB_EN == 1'b1)&&(Two_src && (src1 == MEM_Dest)));
	

	
endmodule