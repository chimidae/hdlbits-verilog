//==============================================================
// Problem : Lfsr5
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Lfsr5
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// reset이 5'h1이므로 q[0]만 1이고 나머지는 0이다. 그래서 리셋값이
// 다른 플립플롭 모듈을 둘로 나누어 인스턴스화했다.
//
// 탭이 있는 위치(5, 3)는 출력 비트 q[0]과 XOR되고, 탭이 없는
// 위치는 그냥 시프트된다. 위치 5의 XOR은 입력 하나가 0이라
// 사실상 통과지만 다이어그램과 맞추려고 그대로 남겼다.
//
// 압축하면 always 블록 하나로 끝난다.
//     if (reset) q <= 5'h1;
//     else       q <= {q[0], q[4], q[3]^q[0], q[2], q[1]};
//==============================================================

module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
);
    man u0 (.clk(clk), .reset(reset), .d(1'b0 ^ q[0]), .q(q[4]));
    man u1 (.clk(clk), .reset(reset), .d(q[4]), .q(q[3]));
    man u2 (.clk(clk), .reset(reset), .d(q[3] ^ q[0]), .q(q[2]));
    man u3 (.clk(clk), .reset(reset), .d(q[2]), .q(q[1]));
    man1 u4 (.clk(clk), .reset(reset), .d(q[1]), .q(q[0]));
endmodule

module man(
    input clk,
    input reset,
    input d,
    output q
);
    always @(posedge clk) begin
        if (reset) begin
            q <= 1'b0;
        end
        else begin
            q <= d;
        end
    end
endmodule

module man1 (
    input clk,
    input reset,
    input d,
    output q
);
    always @(posedge clk) begin
        if (reset) begin
            q <= 1'b1;
        end
        else begin
            q <= d;
        end
    end
endmodule
