//==============================================================
// Problem : Fsm1s
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm1s
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 문제가 준 템플릿은 Verilog-1995 문법과 1-always 스타일이었으나
// Fsm1의 2-always 구조를 그대로 썼다.
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
