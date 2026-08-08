//==============================================================
// Problem : Exams/ece241 2013 q8
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q8
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 11이 반복되면 씹힌다는 문제는 알고 있었지만 해결책이 떠오르지
// 않아 힌트를 받았다. TWO에서 x=1일 때 ONE으로 보내던 것을
// TWO에 머물도록 고쳐 통과.
//==============================================================

module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z );
    parameter ONE=0,TWO=1,THREE=2,FOUR=3;
    reg [1:0] state, nextstate;
    wire check;
    always @(*) begin
        case (state)
            ONE : nextstate = x ? TWO : ONE;
            TWO : nextstate = x ? TWO : THREE;
            THREE : nextstate = x ? FOUR : ONE;
            FOUR : nextstate = x ? TWO : THREE;
            default : nextstate = state;
        endcase
    end
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= ONE;
        end
        else begin
            state <= nextstate;
        end
    end
    assign z = (state == THREE) & x;
endmodule
