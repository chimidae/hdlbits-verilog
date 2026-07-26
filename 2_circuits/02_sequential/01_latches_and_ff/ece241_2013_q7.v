//==============================================================
// Problem : Exams/ece241 2013 q7
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q7
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 헷갈린 부분:
// J=K=0일 때 Qold를 유지하는 동작을 어떻게 쓸지 고민했다.
// clocked always 블록에서는 해당 조건에 Q를 할당하지 않으면
// 플립플롭이 이전 값을 그대로 들고 있다. 그래서 마지막 else를
// 일부러 두지 않는 것으로 유지 동작을 만들었다.
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
