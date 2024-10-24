module Status_Register(
input S, clk, rst,
input [3:0]status_bits,
output reg [3:0]status_out
);
always@(negedge clk, posedge rst) begin
  if(rst) begin
    status_out <= 4'd0;
  end
  else if (S) begin
    status_out <= status_bits;
  end
end
endmodule
