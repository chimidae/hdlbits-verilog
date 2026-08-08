//==============================================================
// Problem : Fsm hdlc
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm_hdlc
// Solved  : 2026-07-29
//==============================================================

module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    parameter IDLE=0, COUNT=1, DISC=2, FLAG=3, ERR=4;
    reg [2:0] state, nextstate;
    reg [6:0] counter;
    always @(*) begin
        case (state)
            IDLE : nextstate = in ? COUNT : IDLE;
            COUNT : nextstate = in ? ((counter > 4) ? ERR : COUNT) : ((counter > 4) ? FLAG : (counter > 3) ? DISC : IDLE);
            DISC : nextstate = in ? COUNT : IDLE;
            FLAG : nextstate = in ? COUNT : IDLE;
            ERR : nextstate = in ? ERR : IDLE;
            default : nextstate = state;
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end
        else begin
            state <= nextstate;
        end
        //Counts.
        if (state == COUNT | state == ERR) begin
            counter <= counter + 1;
        end
        else begin
            counter <= 0;
        end
    end 
    // Output logic
    assign disc = (state == DISC);
    assign flag = (state == FLAG);
    assign err = (state == ERR);
endmodule
