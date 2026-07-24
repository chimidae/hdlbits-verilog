//==============================================================
// Problem : Dff8ar
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff8ar
// Tier    : 1
// Solved  : 2026-07-24
//--------------------------------------------------------------
// 비동기 리셋이므로 sensitivity list에 posedge areset이 들어간다.
// 합성 툴은 이 블록을 템플릿으로 매칭해서 FF의 비동기 clear 핀에
// areset을 연결한다. 그래서 sensitivity list의 엣지 방향, if 조건의
// 극성, 리셋 값이 들어가는 분기가 셋 다 일치해야 한다.
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
