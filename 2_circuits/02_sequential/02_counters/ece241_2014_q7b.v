//==============================================================
// Problem : Exams/ece241 2014 q7b
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q7b
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// 세 카운터 모두 같은 1000 Hz clk을 직접 받는다. 클럭을 나누는 것이
// 아니라 enable로 속도 차이를 만드는 구조다.
//
// c_enable[0]은 매 클럭 세야 하므로 항상 1.
// c_enable[1]은 1의 자리가 한 바퀴 돌 때, 즉 one == 9일 때.
// c_enable[2]는 ten == 9이면서 one == 9일 때.
//
// OneHertz를 always 블록에 넣으면 한 클럭 늦게 나오므로, 999가
// 아니라 998을 검사해야 999인 사이클에 펄스가 뜬다. 레지스터
// 지연을 조건 쪽에서 상쇄한 것이다.
// 조합으로 빼면 assign OneHertz = (one==9 & ten==9 & hund==9)가
// 되고 파형은 같다.
//
// 1차 시도에서 인스턴스 이름을 counter1로 두 번 써서 컴파일 실패했다.
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
