module HzrdDtctr_2 (
	input MEM_WB_EN, EXE_WB_EN, Two_src, EXE_MEM_R_EN,
	input [3:0] EXE_Dest, MEM_Dest, src1, src2,
	input Forward_EN,
	output reg Hazard
);
always @(MEM_WB_EN, EXE_WB_EN, Two_src,EXE_Dest, MEM_Dest, src1, src2, EXE_MEM_R_EN, Forward_EN) begin
   Hazard = 1'b0;
	 if (Forward_EN) begin
	   if (EXE_MEM_R_EN) 
	     begin
	       if (src2 == EXE_Dest || (Two_src && (src1 == EXE_Dest))) begin
	         Hazard = 1'b1;
	       end
	     end
	 end
	 else begin
	    if (EXE_WB_EN) begin
	      if (src1 == EXE_Dest || (Two_src && (src2 == EXE_Dest))) begin
	         Hazard = 1'b1;
	       end
	    end
	    if (MEM_WB_EN) begin
	      if (src1 == MEM_Dest || (Two_src && (src2 == MEM_Dest))) begin
	         Hazard = 1'b1;
	       end
	    end
	  end
end
	
endmodule