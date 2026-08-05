//==============================================================
// Problem : Exams/m2014 q4k
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Exams/m2014_q4k
// Solved  : 2026-07-28
//--------------------------------------------------------------
// resetn이 active-low라는 것은 앞에서 한 번 겪어봐서 바로 처리.
//==============================================================

module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output reg out);
    reg one, two, three;
    man u0 (.clk(clk), .resetn(resetn), .d(in), .q(one));
    man u1 (.clk(clk), .resetn(resetn), .d(one), .q(two));
    man u2 (.clk(clk), .resetn(resetn), .d(two), .q(three));
    man u3 (.clk(clk), .resetn(resetn), .d(three), .q(out));
endmodule

module man (
    input clk,
    input resetn,   // synchronous reset
    input d,
    output q);
    always @(posedge clk) begin
        q <= resetn ? d : 1'b0;
    end
endmodule
