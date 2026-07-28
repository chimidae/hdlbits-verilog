//==============================================================
// Problem : Shift4
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Shift4
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분: 없음.
// 비동기 리셋이라 감지 리스트에 posedge areset을 추가한다.
// 그 뒤로 load, ena 순서로 else if를 쌓으면 문제가 요구한
// 우선순위(load > ena)가 그대로 만들어진다.
// 우측 시프트는 q >> 1이면 끝이고, 빈 자리에 0이 채워지며
// q[0]은 버려진다.
//==============================================================

module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0;
        end
        else if (load) begin
            q <= data;
        end
        else if (ena) begin
            q <= q >> 1;
        end
    end
endmodule
