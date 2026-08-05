//==============================================================
// Problem : Rotate100
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Rotate100
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 1차 시도에서 q <= data >> 1과 q[99] <= data[0]으로 작성해 FAIL.
// 왜 틀렸는지 몰라 힌트를 받음. 회전 대상은 data가 아니라 q다.
//==============================================================

module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 
    reg save;
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else if (ena == 2'b01) begin
            q <= {q[0],q[99:1]};
        end
        else if (ena == 2'b10) begin
            q <= {q[98:0],q[99]};
        end
    end
endmodule
