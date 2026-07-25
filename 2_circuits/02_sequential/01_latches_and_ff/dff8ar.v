//==============================================================
// Problem : Dff8ar
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff8ar
// Solved  : 2026-07-24
//--------------------------------------------------------------
// 헷갈린 부분:
// 동기 reset과 비동기 reset의 차이를 검색했다.
// 동기 reset은 클럭 엣지에서만 reset을 검사하고, 비동기 reset은
// reset의 활성 엣지에서도 블록이 실행된다.
//==============================================================

module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'b0;
        end
        else begin
            q <= d;
        end
    end
endmodule
