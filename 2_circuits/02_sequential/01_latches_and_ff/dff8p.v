//==============================================================
// Problem : Dff8p
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff8p
// Solved  : 2026-07-25
//--------------------------------------------------------------
// 헷갈린 부분:
// 2026-07-24 1차 시도에서는 reset 분기에서 d를 저장하고,
// 정상 동작 분기에서 8'h34를 저장하도록 반대로 작성해 FAIL했다.
// negedge clk 사용 자체는 맞았다.
//==============================================================

module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    always @(negedge clk) begin
        if (reset) begin 
            q <= 8'h34;
        end
        else begin
            q <= d;
        end
    end
endmodule
