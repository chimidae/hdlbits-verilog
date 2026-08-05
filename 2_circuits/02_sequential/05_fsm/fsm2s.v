//==============================================================
// Problem : Fsm2s
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm2s
// Solved  : 2026-07-29
//==============================================================

module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out);
    parameter OFF=0, ON=1; 
    reg state, next_state;
    always @(*) begin
        case (state)
            ON : next_state = k ? OFF : ON;
            OFF : next_state = j ? ON : OFF;
            default : next_state = state;
        endcase
        // State transition logic
    end
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end
        // State flip-flops with synchronous reset
    end
    // Output logic
    assign out = (state == ON);
endmodule
