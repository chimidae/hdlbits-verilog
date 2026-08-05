//==============================================================
// Problem : Edgedetect2
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Edgedetect2
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 1차 시도에서 if (save > in)으로 상승과 하강을 분기로 나누려 함.
//==============================================================

module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    wire [7:0] save;
    always @(posedge clk) begin
        save  <= in;
        anyedge <= save ^ in;
    end
endmodule
