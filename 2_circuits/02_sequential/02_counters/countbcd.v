//==============================================================
// Problem : Countbcd
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Countbcd
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분: 없음. Exams/ece241 2014 q7b의 구조를 그대로 옮겼다.
// 한 자리짜리 decade_counter를 직접 정의해 네 개 인스턴스화하고,
// 윗자리 enable은 아랫자리 조건을 누적해서 만든다. 캐리 전파와
// 같은 구조다.
//==============================================================

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    decade_counter u0 (.clk(clk), .reset(reset), .enable(1'b1), .q(q[3:0]));
    decade_counter u1 (.clk(clk), .reset(reset), .enable(ena[1]), .q(q[7:4]));
    decade_counter u2 (.clk(clk), .reset(reset), .enable(ena[2]), .q(q[11:8]));
    decade_counter u3 (.clk(clk), .reset(reset), .enable(ena[3]), .q(q[15:12]));
    assign ena[1] = ( q[3:0] == 9 );
    assign ena[2] = ( q[7:4] == 9 & q[3:0] == 9 );
    assign ena[3] = ( q[11:8] == 9 & q[7:4] == 9 & q[3:0] == 9 );
endmodule

module decade_counter (
    input clk,
    input reset, // Synchronous active-high reset
    input enable,
    output [3:0] q);
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0;
        end
        else if (enable) begin
            q <= (q >= 9 ) ? 0 : q + 1;
        end
    end
endmodule
