//==============================================================
// Problem : Fsm3comb
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm3comb
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 헷갈린 부분:
// FSM에서 조합 논리 부분만 떼어낸 문제라 clk이 없다. 상태
// 레지스터는 바깥에 있다고 치고, next_state 계산과 출력만 만든다.
//
// out = f(state)이므로 Moore 머신이다. 입력 in이 출력에 직접
// 영향을 주지 않고 상태를 거쳐서만 반영된다.
//
// 남은 문제:
// case에 default가 빠졌다. 상태가 2비트고 A~D 네 개가 전부라
// 지금은 래치가 생기지 않지만, 상태 수가 2의 거듭제곱이 아니면
// 남는 조합에서 바로 래치가 된다. 습관으로 붙이는 편이 낫다.
//==============================================================

module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); 
    parameter A=0, B=1, C=2, D=3;
    always @(*) begin
        case(state)
            A : next_state = in ? B : A;
            B : next_state = in ? B : C;
            C : next_state = in ? D : A;
            D : next_state = in ? B : C;
        endcase
    end
    assign out = (state == D);
    // State transition logic: next_state = f(state, in)
    // Output logic:  out = f(state) for a Moore state machine
endmodule
