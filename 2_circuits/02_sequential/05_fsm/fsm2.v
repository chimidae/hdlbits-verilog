//==============================================================
// Problem : Fsm2
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm2
// Solved  : 2026-07-29
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
