//==============================================================
// Problem : Countslow
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Countslow
// Solved  : 2026-07-27
//--------------------------------------------------------------
// 우여곡절이 많았다. slowena를 바깥 분기로 두어 reset 처리가 양쪽
// 가지에 중복됐다.
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
