//==============================================================
// Problem : Fsm3
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm3
// Solved  : 2026-07-29
//==============================================================

module top_module(
    input clk,
    input in,
    input areset,
    output out);
    parameter A=0, B=1, C=2, D=3;
    reg [3:0] state, nextstate;
    // State transition logic
    always @(*) begin
        case (state)
            A : nextstate = in ? B : A;
            B : nextstate = in ? B : C;
            C : nextstate = in ? D : A;
            D : nextstate = in ? B : C;
        endcase
    end
    // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= A; 
        end 
        else begin
            state <= nextstate;
        end
    end
    // Output logic
    assign out = (state == D);
endmodule
