//==============================================================
// Problem : Exams/ece241 2013 q12
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q12
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// 시프트 레지스터의 구조가 헷갈렸다. S -> Q[0] -> Q[1] -> ... -> Q[7]
// 로 이어진 단방향 체인이고, 되돌아오는 경로가 없어 Q[7]에서 밀려난
// 값은 사라진다. "MSB가 먼저 시프트되어 들어간다"는 것은 순서에 대한
// 설명이지 배선이 다르다는 뜻이 아니다.
//
// 8:1 MUX는 손으로 짜지 않고 Q[{A,B,C}]로 가변 인덱싱하면 된다.
// A가 MSB이므로 ABC=101이면 인덱스 5, 즉 Q[5]가 선택된다.
// 합성기가 이 표현을 MUX로 만든다.
//
// 이 회로가 3입력 LUT다. FPGA의 기본 구성 요소이며, 시프트로 값을
// 채워 넣고 주소로 읽는 구조가 실제 FPGA 비트스트림 로딩과 같다.
//==============================================================

module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    reg [7:0] Q;
    man u0 (.clk(clk), .enable(enable), .d(S), .q(Q[0]));
    man u1 (.clk(clk), .enable(enable), .d(Q[0]), .q(Q[1]));
    man u2 (.clk(clk), .enable(enable), .d(Q[1]), .q(Q[2]));
    man u3 (.clk(clk), .enable(enable), .d(Q[2]), .q(Q[3]));
    man u4 (.clk(clk), .enable(enable), .d(Q[3]), .q(Q[4]));
    man u5 (.clk(clk), .enable(enable), .d(Q[4]), .q(Q[5]));
    man u6 (.clk(clk), .enable(enable), .d(Q[5]), .q(Q[6]));
    man u7 (.clk(clk), .enable(enable), .d(Q[6]), .q(Q[7])); //generate 쓸까 고민했지만 걍 함. 8개 정도야.
    assign Z = Q[{A,B,C}];
endmodule

module man (
    input clk,
    input enable,   // synchronous reset
    input d,
    output q);
    always @(posedge clk) begin
        if (enable) q <= d;
    end
endmodule
