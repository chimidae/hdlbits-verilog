//==============================================================
// Problem : Dff
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff
// Solved  : 2026-07-24
//==============================================================

module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q );
    always @(posedge clk) begin
        q = d;
    end
endmodule
