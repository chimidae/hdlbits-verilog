//==============================================================
// Problem : Shift18
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Shift18
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// 산술 우측 시프트는 빈 자리에 0이 아니라 부호 비트 q[63]을 채운다.
// 그래야 음수가 음수로 남는다. 좌측 시프트는 산술과 논리가 같아서
// 아래에 0을 채우면 된다.
//
// 8비트 시프트일 때는 위쪽 8칸을 전부 q[63]으로 채워야 하므로
// 반복 연결 {8{q[63]}}을 쓴다. {n{신호}}는 부호 확장, 벡터 채우기,
// 폭 맞추기에 계속 쓰이는 패턴이다.
//
// >>> 연산자도 있으나 피연산자가 signed여야 산술 시프트로 동작한다.
//==============================================================

module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else if (ena) begin
            case (amount) 
                2'b00 : q <= {q[62:0],1'b0};
                2'b01 : q <= {q[55:0],8'b0};
                2'b10 : q <= {q[63],q[63:1]};
                2'b11 : q <= {{8{q[63]}},q[63:8]};
            endcase
        end
    end
endmodule
