//==============================================================
// Problem : Dff8r
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff8r
// Tier    : 1
// Solved  : 2026-07-24
//--------------------------------------------------------------
// 동기 리셋이므로 reset이 sensitivity list에 들어가지 않는다.
// 클럭 엣지에서만 리셋이 평가된다.
//==============================================================

module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk) begin
        if (!reset) begin
            q <= d;
        end
        else begin
            q <= 8'b00000000;
        end
    end
endmodule
