//==============================================================
// Problem : Count15
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Count15
// Solved  : 2026-07-27
//==============================================================

module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0;
        end
        else begin
            q <= q + 1;
        end
    end
endmodule
