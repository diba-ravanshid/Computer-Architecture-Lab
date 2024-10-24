module EXE_Mux1 (
	input [31:0] Val_Rn_EXE, ALU_Res, WB_Value,
	input [1:0] Sel_src1,
	output reg [31:0] Val1
);
always @(Sel_src1, Val_Rn_EXE, ALU_Res, WB_Value) begin
    Val1 = 32'd0;
    case(Sel_src1)
      2'b00: Val1 = Val_Rn_EXE;                      
      2'b01: Val1 = ALU_Res;                     
      2'b10: Val1 = WB_Value;            
      default: Val1 = {32{1'b0}};
    endcase
  end
endmodule