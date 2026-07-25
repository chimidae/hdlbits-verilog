//==============================================================
// Problem : Exams/m2014 q4c
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Exams/m2014_q4c
// Solved  : 2026-07-25
//==============================================================

module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q
);
    always @(posedge clk) begin
        if (r) begin
            q <= 1'b0;
        end
        else begin
            q <= d;
        end
    end
endmodule
