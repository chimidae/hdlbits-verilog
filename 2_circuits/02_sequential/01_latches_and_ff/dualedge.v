//==============================================================
// Problem : Dualedge
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dualedge
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 헷갈린 부분:
// always @(posedge clk or negedge clk)는 쓸 수 없다.
// 그래서 posedge 블록과 negedge 블록을 따로 두고 각각 d를 받았다.
// 문제는 둘 중 어느 쪽 값을 내보낼지 판별하는 방법이었다.
// 1차 시도에서 "동작했다"는 플래그를 세우고 조합 블록에서 지우려
// 했으나, 두 블록이 같은 신호를 할당해 드라이버 충돌이 나고
// 조합 블록이 자기 출력을 자기 입력으로 읽어 발진했다.
// 매 클럭 두 블록이 모두 돌기 때문에 플래그는 계속 1로 남는다.
// 대신 각 블록에서 1비트 신호를 토글시키면 pon ^ non이
// 마지막으로 온 엣지가 어느 쪽인지를 알려준다.
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
