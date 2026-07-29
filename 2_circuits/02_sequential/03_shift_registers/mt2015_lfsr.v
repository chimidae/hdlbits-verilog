//==============================================================
// Problem : Mt2015 lfsr
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Mt2015_lfsr
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// Lfsr5에서 배운 "다음 상태 전체를 concatenation 한 줄로 기술"을
// 그대로 적용했다. {} 안의 삼항 연산자 세 개가 회로도의 MUX 세 개와
// 1:1로 대응한다.
//
// L(KEY[1])이 세 MUX에 공통으로 들어가므로 밖으로 뺄 수도 있다.
//     LEDR <= KEY[1] ? SW : {LEDR[1]^LEDR[2], LEDR[0], LEDR[2]};
// 합성 결과는 같고, 지금 형태는 MUX 하나하나가 보여서 회로도
// 대조에는 더 낫다.
//==============================================================

module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    always @(posedge KEY[0]) begin
        LEDR <= {KEY[1] ? SW[2] : (LEDR[1] ^ LEDR[2]) ,KEY[1] ? SW[1] : LEDR[0] ,KEY[1] ? SW[0] : LEDR[2]};
    end
endmodule
