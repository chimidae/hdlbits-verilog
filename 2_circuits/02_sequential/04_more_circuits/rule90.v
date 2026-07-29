//==============================================================
// Problem : Rule90
// Section : Circuits / Sequential / More Circuits
// URL     : https://hdlbits.01xz.net/wiki/Rule90
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// 규칙 자체는 "다음 상태 = 좌우 이웃의 XOR" 한 줄이다. 진리표를
// 다 옮길 필요가 없다. 경계 q[-1], q[512]는 0으로 두므로 i == 0과
// i == 511만 따로 처리했다.
//
// for 루프 없이 concatenation 하나로도 된다.
//     q <= load ? data : ({1'b0, q[511:1]} ^ {q[510:0], 1'b0});
// 앞쪽이 왼쪽 이웃 전체, 뒤쪽이 오른쪽 이웃 전체이며, 경계에 0을
// 붙이는 것이 곧 q[-1], q[512]를 0으로 두는 것이다.
// Edgedetect에서 8비트를 비트와이즈로 처리한 것과 같은 발상이고
// 규모만 커졌다.
//==============================================================

module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    integer i;
    always @(posedge clk) begin
        for (i=0; i < 512; i = i + 1) begin
            if (load) begin
                q[i] <= data[i];
            end
            else if (i == 511) begin
                q[i] <= q[i-1] ^ 1'b0;
            end
            else if (i == 0) begin
                q[i] <= q[i+1] ^ 1'b0;
            end
            else begin
                q[i] <= q[i-1] ^ q[i+1];
            end
        end
    end
endmodule
