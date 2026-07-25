//==============================================================
// Problem : Dff8
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff8
// Solved  : 2026-07-24
//==============================================================

module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
