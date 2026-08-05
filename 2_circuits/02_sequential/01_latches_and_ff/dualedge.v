//==============================================================
// Problem : Dualedge
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dualedge
// Solved  : 2026-07-27
//--------------------------------------------------------------
// always @(posedge clk or negedge clk)가 안 된다는 것을 확인.
// posedge와 negedge를 따로 두고 둘 중 하나가 동작하면 플래그를
// 세워 판별하려 했으나, 한 always에서 받은 신호를 다른 always에서
// 덮어쓸 수 없어 실패.
// pon과 non의 연관성이 보여서 해결.
//==============================================================

module top_module (
    input clk,
    input d,
    output q
);
    wire pq, nq ,pon, non;
    always @(posedge clk) begin
        pq <= d;
        pon <= pon + 1;
    end
    always @(negedge clk) begin
        nq <= d;
        non <= non + 1;
    end
    always @(*) begin
        if (pon ^ non) begin
            q = pq;
        end
        else begin
            q = nq;
        end
    end
endmodule
