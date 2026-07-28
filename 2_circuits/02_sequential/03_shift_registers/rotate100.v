//==============================================================
// Problem : Rotate100
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Rotate100
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// 1차 시도에서 data를 회전시켰다. data는 로드할 때만 쓰는 입력이고
// 회전 대상은 레지스터 자신인 q다. data를 굴리면 매번 원본에서
// 한 칸 돌아간 값이 들어가 누적되지 않는다.
//
// 또 q <= data >> 1 다음 줄에서 q[99] <= data[0]으로 같은 신호에
// 두 번 할당했다. 회전은 "떼어낸 비트를 반대쪽 끝에 붙이는 것"이므로
// concatenation 한 줄로 그대로 옮길 수 있다.
//
//     우회전: {q[0],   q[99:1]}
//     좌회전: {q[98:0], q[99]}
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
