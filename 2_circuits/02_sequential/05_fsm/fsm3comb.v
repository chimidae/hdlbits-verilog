//==============================================================
// Problem : Fsm3comb
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm3comb
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 조합 논리 부분만 떼어낸 문제라 clk이 없다.
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
