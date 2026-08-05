//==============================================================
// Problem : Edgecapture
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Edgecapture
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 1차 시도에서 보조 신호 saved를 두고 out에 하강 검출 결과를 그대로
// 대입해 기존에 잡아둔 비트가 지워졌다. 파형에서 정답이 2, 3, 7로
// 누적되는데 내 출력은 2, 1, 6으로 갈아끼워지는 것을 보고 누적이
// 필요함을 알았다.
//==============================================================

module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    wire [31:0] save;
    always @(posedge clk) begin
        save <= in;
        out <= out | (save & ~in);
        if (reset) begin
            out <= 32'b0;
        end
    end
endmodule
