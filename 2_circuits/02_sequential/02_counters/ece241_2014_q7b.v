//==============================================================
// Problem : Exams/ece241 2014 q7b
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q7b
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 세 카운터의 속도가 이미 조정된 것인지 직접 만들어야 하는 것인지
// 헷갈렸다.
// 1차 시도에서 인스턴스 이름을 counter1로 두 번 써서 컴파일 실패.
// c_enable을 always 안에서 만들려 했던 것도 assign으로 수정.
//==============================================================

module top_module (
    input clk,
    input reset,
    output reg OneHertz,
    output reg [2:0] c_enable
);
    reg [3:0] one, ten, hund;
    bcdcount counter0 (clk, reset, c_enable[0], one);
    bcdcount counter1 (clk, reset, c_enable[1], ten);
    bcdcount counter2 (clk, reset, c_enable[2], hund);
    assign c_enable[0] = 1'b1;
    assign c_enable[1] = ( one == 9 );
    assign c_enable[2] = ( ten == 9 & one == 9);
    always @(posedge clk) begin
        OneHertz <= ( one == 8 & ten == 9 & hund == 9 );
    end
endmodule
