//==============================================================
// Problem : Fsm serialdp
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm_serialdp
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 제공된 parity 모듈은 쓰지 않고 리덕션 XOR로 처리했다.
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
    reg parity;
    always @(*) begin
        case (state)
            IDLE : nextstate = in ? IDLE : COUNT;
            COUNT : nextstate = (counter > 8) ? (in ? DONE : DISCARD) : COUNT;
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
        if ((state == COUNT) & counter < 8) begin
            counter <= counter + 1;
            out_byte[counter] <= in;
        end
        else if ((state == COUNT) & counter == 8) begin
            parity <= in;
            counter <= counter + 1;
        end
        else begin
            counter <= 0;
        end
    end
    assign done = (state == DONE) & ^{out_byte, parity};
endmodule
