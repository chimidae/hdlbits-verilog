//==============================================================
// Problem : Edgedetect2
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Edgedetect2
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 헷갈린 부분:
// 1차 시도에서 if (save > in)으로 상승과 하강을 나누려 했다.
// 벡터 크기 비교라 8비트가 한 판단으로 접히고, 한 사이클에
// 상승 비트와 하강 비트가 동시에 있으면 한쪽만 잡힌다.
// XOR은 "두 값이 다르다"를 비트별로 판정하므로 분기가 필요 없다.
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
