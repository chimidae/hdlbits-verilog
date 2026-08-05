//==============================================================
// Problem : Exams/ece241 2014 q7a
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q7a
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 1차: count4 인스턴스화를 always 블록 안에 넣어 syntax error.
// 2차: c_load = reset만 두어 12 이후로 계속 증가.
// 3차: c_load = reset | (Q >= 12)로 고쳤으나 파형을 보고 enable이
//      0일 때도 로드가 걸리는 것을 발견해 & enable 추가.
//==============================================================

module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); 
    assign c_enable = enable;
    assign c_d = 4'b0001;
    assign c_load = reset | (Q >= 12 & enable);
    count4 the_counter (clk, c_enable, c_load, c_d, Q);
endmodule
