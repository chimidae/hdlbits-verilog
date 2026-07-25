//==============================================================
// Problem : Dff8p
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff8p
// Solved  : OPEN
//--------------------------------------------------------------
// 풀이:
// 2026-07-24에 작성한 1차 시도다. negedge clk에서 reset에 따라
// d 또는 8'h34를 q에 할당하도록 작성했지만 HDLBits 결과는 FAIL이었다.
//
// 헷갈린 부분:
// 실패 원인은 별도 기록 없음. 통과 코드는 아직 없다.
//==============================================================

module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    always @(negedge clk) begin
        if (reset) begin 
            q <= d;
        end
        else begin
            q <= 8'h34;
        end
    end
endmodule
