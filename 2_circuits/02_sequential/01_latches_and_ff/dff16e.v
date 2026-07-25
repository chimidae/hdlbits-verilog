//==============================================================
// Problem : Dff16e
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff16e
// Solved  : 2026-07-25
//--------------------------------------------------------------
// 헷갈린 부분:
// 처음에는 active-low reset 조건을 반대로 썼다.
// 또 byteena가 0인 바이트에 0을 할당했는데, 이 경우에는 값을
// 지우는 것이 아니라 기존 값을 유지해야 한다.
// clocked always 블록에서 해당 레지스터를 할당하지 않으면
// 플립플롭이 이전 값을 유지하므로 래치가 생기지 않는다.
//==============================================================

module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    always @(posedge clk) begin
        if (resetn) begin
            if (byteena[1]) begin
                q[15:8] <= d[15:8];
            end
            if (byteena[0]) begin
                q[7:0] <= d[7:0];
            end
        end
        else begin
            q <= 16'b0;
        end
    end
endmodule
