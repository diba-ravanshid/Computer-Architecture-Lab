module ALU(
  input[31:0] val1, val2,
  input[3:0] EXE_cmd,
  input[3:0] status,
  output[3:0] status_bits,
  output reg[31:0] ALU_Res
);
reg c, v;
wire z, n;
wire [31:0] carry_pos, carry_neg;
assign carry_pos = {{(31){1'b0}}, status[1]};
assign carry_neg = {{(31){1'b0}}, ~status[1]};
assign status_bits = {n ,z ,c ,v};
assign z = ~|ALU_Res;
assign n = ALU_Res[31];
always @(val1, val2, EXE_cmd, carry_pos, carry_neg) begin
ALU_Res = 32'd0;
c = 1'b0;

  case(EXE_cmd)
    4'b0001: ALU_Res = val2;                      
    4'b1001: ALU_Res = ~val2;                     
    4'b0010: {c, ALU_Res} = val1 + val2;             
    4'b0011: {c, ALU_Res} = val1 + val2 + carry_pos;  
    4'b0100: {c, ALU_Res} = val1 - val2;       
    4'b0101: {c, ALU_Res} = val1 - val2 - carry_neg; 
    4'b0110: ALU_Res = val1 & val2;                  
    4'b0111: ALU_Res = val1 | val2;                  
    4'b1000: ALU_Res = val1 ^ val2;                  
    default: ALU_Res = {32{1'b0}};
  endcase
  v = 1'b0;
  /*if (ALU_Res == 4'b0100 || ALU_Res == 4'b0101) begin
    v = (val1[31] == val2[31])&&(val1[31] != ALU_Res[31]);
  end
  else if (ALU_Res == 4'b0010 || ALU_Res == 4'b0110) begin
    v = (val1[31] != val2[31])&&(val1[31] != ALU_Res[31]);
  end*/
  if (EXE_cmd[3:1] == 3'b001) begin   
	v = (val1[31] == val2[31])&&(val1[31] != ALU_Res[31]);
  end
  else if (EXE_cmd[3:1] == 3'b010) begin
	v = (val1[31] != val2[31])&&(val1[31] != ALU_Res[31]);
  end
    
end
endmodule
