//==============================================================
// Problem : Count1to10
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Count1to10
// Solved  : 2026-07-27
//==============================================================

module top_module (
    input clk,
    input reset,
    output [3:0] q);
    always @(posedge clk) begin
        if (reset | q >= 10) begin
            q <= 4'b0001;
        end
        else begin
            q = q + 1;
        end
    end
endmodule
