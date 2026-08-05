//==============================================================
// Problem : Lfsr32
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Lfsr32
// Solved  : 2026-07-28
//==============================================================

module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    always @(posedge clk) begin
        q <= reset ? 32'h1 : { q[0], q[31:23], q[22] ^ q[0], q[21:3], q[2] ^ q[0], q[1] ^ q[0] };
    end
endmodule
