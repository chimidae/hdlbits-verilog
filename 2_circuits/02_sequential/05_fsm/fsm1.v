//==============================================================
// Problem : Fsm1
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm1
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 헷갈린 부분:
// FSM의 기본 골격을 처음 잡은 문제. 2-always 구조로 나눈다.
//   1. always @(*)        : 조합 논리. state로부터 next_state를 계산
//   2. always @(posedge)  : 순차 논리. next_state를 state에 반영
//   3. assign             : 출력. state에서 바로 나온다
//
// parameter로 상태에 이름을 붙이면 인코딩을 바꿀 때 parameter
// 줄만 고치면 되고 본문은 건드리지 않아도 된다.
//
// areset이 비동기이므로 감지 리스트에 posedge areset을 넣는다.
//
// 남은 문제:
// 조합 블록의 if-else 사슬에 else가 없다. 지금은 상태가 둘뿐이라
// 네 경우가 전부 커버되지만, 상태가 늘면 빠뜨린 조합에서
// next_state가 값을 받지 못해 래치가 생긴다.
// 기본값을 먼저 쓰거나(next_state = state;) case에 default를
// 붙이면 막을 수 있다.
//==============================================================

module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);
    parameter A=0, B=1; 
    reg state, next_state;
    always @(*) begin
        // State transition logic
        if (state == B & ~in) begin
            next_state = A;
        end
        else if (state == A & ~in) begin
            next_state = B;
        end
        else if (state == A & in) begin
            next_state = A;
        end
        else if (state == B & in) begin
            next_state = B;
        end
    end
    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= B;
        end
        else begin
            state <= next_state;
        end
    end
    // Output logic
    assign out = (state == B);
endmodule
