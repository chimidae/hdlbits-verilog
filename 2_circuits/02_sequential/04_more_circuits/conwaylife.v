//==============================================================
// Problem : Conwaylife
// Section : Circuits / Sequential / More Circuits
// URL     : https://hdlbits.01xz.net/wiki/Conwaylife
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 고생 조금 했다. 힌트를 받아 해결.
// 1차: wire [15:0] row [0:15] unpacked 배열을 +:로 잘라 row별로
//      연산하려 했으나 잘 안 됐다.
// 2차: pandan 변수에 이웃 합을 담아 case에 넣으려 했다.
//      위 두 방식 다 clk 돌아갈 때 정상 동작하는지 의심이 들어
//      인덱스를 직접 계산하는 형태로 바꿨다.
// 3차: 괄호 위치를 틀려 & 15가 덧셈 전체에 걸렸다.
// 손메모: notes/images/conwaylife-memo.jpg
//==============================================================

module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q );
    integer j;
    always @(posedge clk) begin
        if (load) begin //일단 로드를 빼.
            q <= data; 
        end
        else begin
            for (j=0; j<256; j=j+1) begin
                case (q[(j/16)*16 + ((j%16 - 1) & 15)] + q[(j/16)*16 + ((j%16 + 1) & 15)] //같은 열
                      + q[((j/16 - 1) & 15)*16 + ((j%16 - 1) & 15)] + q[((j/16 - 1) & 15)*16 + j%16] + q[((j/16 - 1) & 15)*16 + ((j%16 + 1) & 15)]
                      + q[((j/16 + 1) & 15)*16 + ((j%16 - 1) & 15)] + q[((j/16 + 1) & 15)*16 + j%16] + q[((j/16 + 1) & 15)*16 + ((j%16 + 1) & 15)])
                    4'b0010 : q[j] <= q[j];
                    4'b0011 : q[j] <= 1;
                    default : q[j] <= 0;
                endcase
            end
        end
    end
endmodule
