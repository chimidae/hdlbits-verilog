//==============================================================
// Problem : Dff
// Section : Circuits / Sequential / Latches and Flip-Flops
// URL     : https://hdlbits.01xz.net/wiki/Dff
// Tier    : 1
// Solved  : 2026-07-23
//--------------------------------------------------------------
// 이 파일은 헤더 형식 참고용 예시다. 실제로 풀고 나면 내용을 덮어쓴다.
// 순차 로직이므로 non-blocking(<=)을 쓴다.
//==============================================================

module top_module (
    input        clk,
    input        d,
    output reg   q
);

    always @(posedge clk) begin
        q <= d;
    end

endmodule
