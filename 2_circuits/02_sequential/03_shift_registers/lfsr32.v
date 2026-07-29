//==============================================================
// Problem : Lfsr32
// Section : Circuits / Sequential / Shift Registers
// URL     : https://hdlbits.01xz.net/wiki/Lfsr32
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// Lfsr5의 압축 형태를 32비트로 확장했다. 탭은 32, 22, 2, 1이고
// 탭 번호는 1부터, 비트 인덱스는 0부터라 한 칸씩 밀린다.
//
// {} 안의 폭 합이 32가 되어야 한다.
//     1 + 9 + 1 + 19 + 1 + 1 = 32
// 폭이 어긋나면 컴파일은 통과하고 동작만 틀려서 찾기 어렵다.
//==============================================================

module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    always @(posedge clk) begin
        q <= reset ? 32'h1 : { q[0], q[31:23], q[22] ^ q[0], q[21:3], q[2] ^ q[0], q[1] ^ q[0] };
    end
endmodule
