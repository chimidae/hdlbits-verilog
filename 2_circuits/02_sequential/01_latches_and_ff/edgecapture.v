//==============================================================
// Problem : Edgecapture
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Edgecapture
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 헷갈린 부분:
// 1차 시도에서 out에 하강 검출 결과를 그대로 대입해 이미 잡아둔
// 비트가 지워졌다. capture는 누적이므로 out이 자기 자신을 재료로
// 써야 한다. out | (save & ~in)이면 한 번 1이 된 비트는 0으로
// 돌아갈 경로가 없고, 지우는 것은 reset뿐이다.
// 같은 always 블록에서 out에 두 번 할당하면 마지막 것이 이기므로
// reset 분기를 아래에 두면 문제가 요구한 reset 우선이 만족된다.
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
