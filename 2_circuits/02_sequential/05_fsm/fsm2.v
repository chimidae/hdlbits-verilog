//==============================================================
// Problem : Fsm2
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm2
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 헷갈린 부분: 없음.
// Fsm1에서 지적받은 대로 if-else 사슬을 case로 바꾸고 default를
// 붙였다. 이 형태가 FSM 표준 골격이며, 상태만 늘리면 나머지
// 문제도 같은 틀로 커버된다.
//
// 동작 자체는 Exams/ece241 2013 q7의 JK 플립플롭과 같다.
// 그때는 진리표로 풀었고 여기서는 상태 기계로 푼 것이라,
// 같은 회로를 두 관점에서 본 셈이다.
//==============================================================

module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); 
    parameter OFF=0, ON=1; 
    reg state, next_state;
    always @(*) begin
        case (state)
            OFF : next_state = j ? ON : OFF;
            ON : next_state = k ? OFF : ON;
            default : next_state = state;
        endcase
        // State transition logic
    end
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end
        // State flip-flops with asynchronous reset
    end
    // Output logic
    assign out = (state == ON);
endmodule
