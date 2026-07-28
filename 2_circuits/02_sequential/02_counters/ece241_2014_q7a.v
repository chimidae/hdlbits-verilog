//==============================================================
// Problem : Exams/ece241 2014 q7a
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q7a
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// 처음에 count4 인스턴스화를 always 블록 안에 넣어 syntax error가
// 났다. 모듈 인스턴스화는 문장이 아니라 배선이므로 assign과 같은
// 층위에 놓이고 always 밖에만 올 수 있다.
//
// 카운트는 count4가 하고 top_module은 c_enable, c_load, c_d
// 세 신호만 조합 논리로 결정한다. always 블록 자체가 필요 없다.
//
// count4는 스스로 랩을 못 하므로 12에서 1로 되돌리는 유일한 수단이
// load다. 그래서 c_load는 reset일 때와 Q가 12일 때 모두 1이어야 한다.
//
// (Q >= 12)만으로 걸면 enable이 0으로 정지한 상태에서도 12에서
// 로드가 걸려 정지가 깨진다. load가 enable보다 우선순위가 높기
// 때문이다. enable을 함께 물려야 한다.
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
