//==============================================================
// Problem : Fsm3s
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm3s
// Solved  : 2026-07-29
//==============================================================

module top_module(
    input clk,
    input in,
    input reset,
    output out);
    parameter A=0, B=1, C=2, D=3;
    reg [1:0] state, nextstate;
    // State transition logic
    always @(*) begin
        case (state)
            A : nextstate = in ? B : A;
            B : nextstate = in ? B : C;
            C : nextstate = in ? D : A;
            D : nextstate = in ? B : C;
            default : nextstate = state;
        endcase
    end
    // State flip-flops with asynchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= A; 
        end 
        else begin
            state <= nextstate;
        end
    end
    // Output logic
    assign out = (state == D);
endmodule
