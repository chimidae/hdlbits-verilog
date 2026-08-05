//==============================================================
// Problem : Fsm1
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm1
// Solved  : 2026-07-29
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
