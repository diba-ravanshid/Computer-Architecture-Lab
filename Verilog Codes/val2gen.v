module val2gen(
input [31:0] val_Rm,
input [11:0] shift_OP,
input imm, read_write,
output reg [31:0]val2
);
integer i;
always @(val_Rm, shift_OP, imm, read_write)begin
  val2 = 32'd0;
  if (read_write)
    val2 = {{20{shift_OP[11]}}, shift_OP};
  else if (imm)
    begin
    val2 = {24'd0, shift_OP[7:0]};
    for (i=0 ; i<2*shift_OP[11:8] ; i = i+1)
    val2 = {val2[0], val2[31:1]};
    end
  else 
    begin
      case(shift_OP[6:5])
        2'b00: val2 = val_Rm << shift_OP[11:7];
        2'b01: val2 = val_Rm >> shift_OP[11:7];
        2'b10: val2 = $signed(val_Rm) >>> shift_OP[11:7];
        2'b11:
         begin 
          val2 = val_Rm;
          for (i=0 ; i<2*shift_OP[11:8] ; i = i+1) begin
            val2 = {val2[0], val2[31:1]};
				end
         end
       endcase
    end  
end

endmodule




