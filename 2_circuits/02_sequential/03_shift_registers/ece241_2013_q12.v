//==============================================================
// Problem : Exams/ece241 2013 q12
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q12
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 시프트 레지스터의 구조를 순환 구조로 오해했다. S를 Q[0]에 넣고
// 거기서 Q[7]을 다시 뽑는 형태인 줄 알았는데, 실제로는 단방향
// 체인이다. 문제 설명의 그 부분이 이해가 잘 안 됐다.
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
