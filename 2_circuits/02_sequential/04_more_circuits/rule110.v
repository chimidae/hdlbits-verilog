//==============================================================
// Problem : Rule110
// Section : Circuits / Sequential / More Circuits
// URL     : https://hdlbits.01xz.net/wiki/Rule110
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 논리 구조가 복잡해서 벡터 방식 대신 for로 그대로 작성했다.
// 처음에 i+1과 i-1을 반대로 써서 고생 조금 했다.
//==============================================================

module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);     
    integer i;
    always @(posedge clk) begin
        for (i=0; i < 512; i = i + 1) begin
            if (load) begin
                q[i] <= data[i];
            end
            else if (i == 511) begin
                q[i] <= (q[i] ^ q[i-1]) | ( 1'b1 & q[i]);
            end
            else if (i == 0) begin
                q[i] <= (q[i] ^ 1'b0) | ( ~q[i+1] & q[i]);
            end
            else begin
                q[i] <= (q[i] ^ q[i-1]) | ( ~q[i+1] & q[i]);
            end
        end
    end
endmodule
