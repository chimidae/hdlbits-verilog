//==============================================================
// Problem : Rule90
// Section : Circuits / Sequential / More Circuits
// URL     : https://hdlbits.01xz.net/wiki/Rule90
// Solved  : 2026-07-28
//==============================================================

module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    integer i;
    always @(posedge clk) begin
        for (i=0; i < 512; i = i + 1) begin
            if (load) begin
                q[i] <= data[i];
            end
            else if (i == 511) begin
                q[i] <= q[i-1] ^ 1'b0;
            end
            else if (i == 0) begin
                q[i] <= q[i+1] ^ 1'b0;
            end
            else begin
                q[i] <= q[i-1] ^ q[i+1];
            end
        end
    end
endmodule
