//==============================================================
// Problem : Dff8r
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff8r
// Solved  : 2026-07-24
//--------------------------------------------------------------
// 풀이:
// 동기 리셋이므로 reset이 sensitivity list에 들어가지 않는다.
// 클럭 엣지에서만 리셋이 평가된다.
//
// 헷갈린 부분:
// 처음에는 if (!reset)로 정상 동작을 먼저 쓰고 else에서 리셋했다.
// 기능은 같지만 active-low 신호를 다루는 형태와 시각적으로 겹쳐서
// 극성을 반대로 읽기 쉽다. 리셋 조건을 앞에 두는 쪽으로 정리.
//==============================================================

module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b0;
        end
        else begin
            q <= d;
        end
    end
endmodule
