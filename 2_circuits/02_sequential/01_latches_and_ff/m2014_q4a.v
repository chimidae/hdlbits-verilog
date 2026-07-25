//==============================================================
// Problem : Exams/m2014 q4a
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Exams/m2014_q4a
// Solved  : 2026-07-25
//--------------------------------------------------------------
// 헷갈린 부분:
// 래치를 만드는 다른 RTL 표현이 있는지, else가 없는 if 외에
// 다른 해결책이 있는지 궁금했다.
//==============================================================

module top_module (
    input d, 
    input ena,
    output q
);
    always @(*) begin
        if (ena) begin
            q = d;
        end
    end

endmodule
