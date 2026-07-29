//==============================================================
// Problem : Rule110
// Section : Circuits / Sequential / More Circuits
// URL     : https://hdlbits.01xz.net/wiki/Rule110
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// 처음에 i+1과 i-1을 반대로 써서 고생했다. Rule90은 XOR이라 좌우
// 대칭이어서 방향이 틀려도 통과했지만, Rule110은 비대칭이라 방향이
// 결과를 바꾼다.
//
// q[511]이 가장 왼쪽 셀이므로 인덱스가 클수록 왼쪽이다.
//     q[i+1] = 왼쪽 이웃 L
//     q[i-1] = 오른쪽 이웃 R
//
// 진리표를 정리하면 next = (C ^ R) | (~L & C)가 된다.
// 경계는 q[-1] = q[512] = 0으로 두고 각각 대입하면
// i == 511에서는 ~L = 1, i == 0에서는 R = 0이 된다.
//
// 벡터로 접으면 한 줄이 된다.
//     q <= load ? data
//                : ((q ^ {q[510:0], 1'b0}) | (~{1'b0, q[511:1]} & q));
// 앞이 오른쪽 이웃 전체, 뒤가 왼쪽 이웃 전체다.
//==============================================================

module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);     
    integer i;
    always @(posedge clk) begin
        for (i=0; i < 512; i = i + 1) begin
            if (load) begin
                q[i] <= data[i];
            end
            else if (i == 511) begin
                q[i] <= (q[i] ^ q[i-1]) | ( 1'b1 & q[i]);
            end
            else if (i == 0) begin
                q[i] <= (q[i] ^ 1'b0) | ( ~q[i+1] & q[i]);
            end
            else begin
                q[i] <= (q[i] ^ q[i-1]) | ( ~q[i+1] & q[i]);
            end
        end
    end
endmodule
