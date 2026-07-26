//==============================================================
// Problem : Exams/ece241 2014 q4
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q4
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 헷갈린 부분:
// AND와 OR 게이트로 되돌아오는 피드백 선이 Q가 아니라 반전 출력에서
// 나온다. 회로도의 오버바를 놓쳐서 x & outa, x | outo로 작성해 FAIL했다.
// 게이트 종류보다 각 입력이 Q인지 ~Q인지를 먼저 확인해야 한다.
// 세 플립플롭은 초기값이 0으로 주어지므로 별도 reset 입력은 없다.
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
