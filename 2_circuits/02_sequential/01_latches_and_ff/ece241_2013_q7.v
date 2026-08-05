//==============================================================
// Problem : Exams/ece241 2013 q7
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q7
// Solved  : 2026-07-27
//--------------------------------------------------------------
// Qold를 어떻게 처리할지 고민했다. 마지막에 일부러 else를 두지 않아
// 유지시켰다.
//==============================================================

module top_module (
    input clk,
    input j,
    input k,
    output Q);
    always @(posedge clk) begin
        if (~j & k) begin
            Q <= 1'b0;
        end
        else if (j & ~k) begin
            Q <= 1'b1;
        end
        else if (j & k) begin
            Q <= ~Q;
        end
    end
endmodule
