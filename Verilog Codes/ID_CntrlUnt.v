module CntrlUnt (
  input sIn,
  input[1:0] Mode,
  input[3:0] OpCode,
  output reg[8:0] CntrlUnt_out
);
reg[3:0] EXE_CMD;
reg MEM_W_EN, MEM_R_EN, WB_EN, Branch, sOut;
always @(OpCode, Mode, sIn) begin
   EXE_CMD = 4'b0;
  {MEM_W_EN, MEM_R_EN, WB_EN, Branch, sOut} = 5'b0;
  case (OpCode)
    4'b1101: EXE_CMD = 4'b0001; // MOV
    4'b1111: EXE_CMD = 4'b1001; // MVN
    4'b0100: EXE_CMD = 4'b0010; // ADD, LDR, STR
    4'b0101: EXE_CMD = 4'b0011; // ADC
    4'b0010: EXE_CMD = 4'b0100; // SUB
    4'b0110: EXE_CMD = 4'b0101; // SBC
    4'b0000: EXE_CMD = 4'b0110; // AND
    4'b1100: EXE_CMD = 4'b0111; // ORR
    4'b0001: EXE_CMD = 4'b1000; // EOR
    4'b1010: EXE_CMD = 4'b0100; // CMP
    4'b1000: EXE_CMD = 4'b0110; // TST
    default: EXE_CMD = 4'b0001;
  endcase
  case (Mode)
    2'b00: begin 
      sOut = sIn;
      WB_EN = (OpCode == 4'b1010 || OpCode == 4'b1000) ? 1'b0 : 1'b1;
      end
    2'b01: begin
        WB_EN = sIn;
        MEM_R_EN = sIn;
        MEM_W_EN = ~sIn;
    end
    2'b10: Branch = 1'b1;
  endcase
  CntrlUnt_out = {EXE_CMD, MEM_W_EN, MEM_R_EN, WB_EN, Branch, sOut};
  end
  
endmodule
