//==============================================================
// Problem : Fsm serialdata
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm_serialdata
// Solved  : 2026-07-29
//--------------------------------------------------------------
// Fsm serial에서 딱 한 줄 추가.
//==============================================================

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);
    parameter IDLE=0, COUNT=1, DONE=2, DISCARD=3;
    reg [1:0] state, nextstate;
    reg [3:0] counter;
    always @(*) begin
        case (state)
            IDLE : nextstate = in ? IDLE : COUNT;
            COUNT : nextstate = (counter > 7) ? (in ? DONE : DISCARD) : COUNT;
            DONE : nextstate = in ? IDLE : COUNT;
            DISCARD : nextstate = in ? IDLE : DISCARD;
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
        if (state == COUNT) begin
            counter <= counter + 1;
            out_byte[counter] <= in;
        end
        else begin
            counter <= 0;
        end
    end
    assign done = (state == DONE);
    // New: Datapath to latch input bits.
endmodule
