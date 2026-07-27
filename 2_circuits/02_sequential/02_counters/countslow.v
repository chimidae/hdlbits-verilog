//==============================================================
// Problem : Countslow
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Countslow
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 헷갈린 부분:
// slowena를 바깥 분기로 두는 바람에 reset 처리가 양쪽 가지에
// 모두 필요해져 같은 코드를 두 번 썼다. 통과는 했지만 구조가 꼬였다.
//
// if-else 사슬은 위에서부터 우선순위이므로 reset을 맨 위로 올리면
// 중복이 사라진다. slowena가 0일 때 아무것도 할당하지 않는 것이
// 곧 유지 동작이다.
//
//     if (reset)        q <= 0;
//     else if (slowena) q <= (q >= 9) ? 0 : q + 1;
//
// 조건이 여러 개면 우선순위 순서대로 위에서 아래로 쓴다.
//==============================================================

module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    wire w;
    always @(posedge clk) begin
        if (slowena ) begin
            if (reset | q >= 9) begin
                q <= 0;
            end
            else begin
                q <= q + 1;
            end
        end
        else if (reset) begin
            q <= 0;
        end
    end
endmodule
