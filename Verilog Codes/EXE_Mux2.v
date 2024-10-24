module EXE_Mux2 (
	input [31:0] Val_Rm_EXE, ALU_Res, WB_Value,
	input [1:0] Sel_src2,
	output reg [31:0] Val_Rm_mux_out
);
always @(Sel_src2, Val_Rm_EXE, ALU_Res, WB_Value) begin
    Val_Rm_mux_out = 32'd0;
    case(Sel_src2)
      2'b00: Val_Rm_mux_out = Val_Rm_EXE;                      
      2'b01: Val_Rm_mux_out = ALU_Res;                     
      2'b10: Val_Rm_mux_out = WB_Value;            
      default: Val_Rm_mux_out = {32{1'b0}};
    endcase
  end
endmodule
