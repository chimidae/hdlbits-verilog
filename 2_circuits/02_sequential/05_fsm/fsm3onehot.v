//==============================================================
// Problem : Fsm3onehot
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm3onehot
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 헷갈린 부분:
// one-hot 인코딩은 정확히 하나의 상태 비트만 1임을 보장한다.
// 따라서 "현재 상태 A인가"를 검사하는 식이 그냥 state[A] 하나다.
// 상태 비트 전부를 비교할 필요가 없다.
//
// 그래서 각 상태로 들어오는 간선(incoming edge)만 모아 OR로 묶으면
// 전이식이 완성된다. 한 번에 최대 하나의 곱항만 활성이라 절끼리
// 충돌하지 않는다.
//
//     next_state[A] = (A로 들어오는 간선들의 OR)
//
// 이것이 one-hot FSM의 논리가 단순해지는 이유다. 대가로 상태 비트
// 저장 공간을 더 쓴다. RTL 설계에서는 합성기가 알아서 처리하지만
// 디지털 논리 시험에 자주 나온다.
//
// 남은 것:
// 왼쪽은 next_state[A]로 이름을 쓰고 오른쪽은 state[0]으로 숫자를
// 썼다. 양쪽 모두 이름으로 통일하면 상태 전이도와 바로 대조된다.
//     assign next_state[A] = (state[A] | state[C]) & ~in;
//==============================================================

module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out);
    parameter A=0, B=1, C=2, D=3;
    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = (state[0] | state[2]) & ~in;
    assign next_state[B] = (state[0] | state[1] | state[3]) & in;
    assign next_state[C] = (state[1] | state[3]) & ~in;
    assign next_state[D] = state[2] & in;
    // Output logic: 
    assign out = state[3];
endmodule
