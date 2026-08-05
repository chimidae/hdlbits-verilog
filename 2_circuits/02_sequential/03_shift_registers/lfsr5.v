//==============================================================
// Problem : Lfsr5
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Lfsr5
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 약간 복잡하게 짰다. 리셋값이 다른 플립플롭 모듈을 둘로 나누어
// 인스턴스화했다.
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
