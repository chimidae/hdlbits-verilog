//==============================================================
// Problem : Fsm1s
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm1s
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 헷갈린 부분:
// Fsm1의 동기 리셋 버전이라 감지 리스트에서 posedge areset만 빼면
// 된다. 로직은 그대로 재사용했다.
//
// 문제가 준 템플릿은 두 가지를 보여주려는 의도였다.
//
// 1. Verilog-1995 포트 선언 문법
//    module top_module(clk, reset, in, out);
//        input clk;
//        output out;
//        reg out;
//    옛날 코드나 오래된 IP에서 보게 되는 형태다.
//
// 2. 1-always 스타일 FSM
//    클럭 블록 하나에 상태 전이, 상태 갱신, 출력을 모두 넣는다.
//    템플릿이 present_state = next_state로 blocking을 쓰는 이유는
//    그 아래 case가 갱신된 새 상태를 읽어야 하기 때문이다.
//    non-blocking이면 직전 상태를 읽어 출력이 한 박자 밀린다.
//    Conwaylife의 pandan과 같은 원리다.
//
// 이 코드는 2-always로 짜고 출력을 assign으로 뺐다. state가 바뀌는
// 즉시 따라오므로 타이밍은 동일하다. 조합 논리와 레지스터가 코드에서
// 분리되어 합성 결과가 예측 가능하고 실무 표준도 이쪽이다.
//==============================================================

module top_module(
    input clk,
    input reset,
    input in,
    output reg out);
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
    always @(posedge clk) begin
        // State flip-flops with asynchronous reset
        if (reset) begin
            state <= B;
        end
        else begin
            state <= next_state;
        end
    end
    // Output logic
    assign out = (state == B);
endmodule
