//==============================================================
// Problem : Exams/m2014 q4b
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Exams/m2014_q4b
// Solved  : 2026-07-25
//==============================================================

module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q
);
    always @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= 1'b0;
        end
        else begin
            q <= d;
        end
    end
endmodule
