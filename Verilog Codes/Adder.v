module Adder(
input [31:0]PC,
input [31:0] Signed_EX_imm_24,
output [31:0]Brach_Address
);
assign Brach_Address = PC + Signed_EX_imm_24;
endmodule


