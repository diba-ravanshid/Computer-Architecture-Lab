module Forward_Unit(
    input forward_En,
    input [3:0] src1, src2,
    input wbEnMem, wbEnWb,
    input [3:0] destMem, destWb,
    output reg [1:0] sel_Src1, sel_Src2
    );
    always @(forward_En, src1, wbEnMem, wbEnWb, destMem, destWb) begin
        sel_Src1 = 2'b00;
        if (forward_En) begin
            if (wbEnMem && (destMem == src1)) begin
                sel_Src1 = 2'b01;
            end
            else if (wbEnWb && (destWb == src1)) begin
                sel_Src1 = 2'b10;
            end
        end
    end

    always @(forward_En, src2, wbEnMem, wbEnWb, destMem, destWb) begin
        sel_Src2 = 2'b00;
        if (forward_En) begin
            if (wbEnMem && (destMem == src2)) begin
                sel_Src2 = 2'b01;
            end
            else if (wbEnWb && (destWb == src2)) begin
                sel_Src2 = 2'b10;
            end
        end
      end
endmodule