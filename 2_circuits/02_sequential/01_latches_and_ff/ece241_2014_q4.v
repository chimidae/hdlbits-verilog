//==============================================================
// Problem : Exams/ece241 2014 q4
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q4
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 회로도에서 Q 위의 언더바를 못 보고 반전 없이 작성해 FAIL.
//==============================================================

module top_module (
    input clk,
    input x,
    output z
); 
    wire Dx, Da, Do;
    wire outx, outa, outo;
    assign Dx = x ^ outx;
    assign Da = x & ~outa;
    assign Do = x | ~outo;
    always @(posedge clk) begin
        outx <= Dx;
        outa <= Da;
        outo <= Do;
    end
    assign z = ~( outx | outa | outo );
endmodule
