//==============================================================
// Problem : Fsm serial
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm_serial
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 사이클 그림을 그려서 풀었다. DISCARD를 추가하지 않고 했다가
// 바로 사이클이 돌아가서 두 사이클 늦는 오류가 있었고 고쳤다.
//==============================================================

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
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
        end
        else begin
            counter <= 0;
        end
    end
    assign done = (state == DONE);
endmodule
