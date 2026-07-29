//==============================================================
// Problem : Exams/m2014 q4k
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Exams/m2014_q4k
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// 회로 자체는 4단 시프트 레지스터, 즉 지연선(delay line)이다.
// in이 4클럭 뒤에 out으로 나온다.
//
// resetn은 active-low라 0일 때 리셋된다. 앞서 한 번 겪어본
// 패턴이라 바로 처리했다. _n 접미사는 업계 관례다.
//
// 지연선은 파이프라인 정렬(연산 결과와 원본 데이터의 타이밍
// 맞추기), CDC용 2-FF synchronizer, 엣지 검출의 직전값 보관에
// 계속 쓰인다. Edgedetect의 save가 1단 지연선이었다.
//==============================================================

module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output reg out);
    reg one, two, three;
    man u0 (.clk(clk), .resetn(resetn), .d(in), .q(one));
    man u1 (.clk(clk), .resetn(resetn), .d(one), .q(two));
    man u2 (.clk(clk), .resetn(resetn), .d(two), .q(three));
    man u3 (.clk(clk), .resetn(resetn), .d(three), .q(out));
endmodule

module man (
    input clk,
    input resetn,   // synchronous reset
    input d,
    output q);
    always @(posedge clk) begin
        q <= resetn ? d : 1'b0;
    end
endmodule
