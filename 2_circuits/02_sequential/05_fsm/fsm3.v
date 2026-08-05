//==============================================================
// Problem : Fsm3
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm3
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 헷갈린 부분: 없음.
// Fsm3comb에 상태 레지스터와 비동기 리셋을 붙인 형태다.
// 전이 논리와 출력 논리는 그대로 재사용했다.
//
// 남은 것:
// reg [3:0] state는 폭이 과하다. 상태가 넷이면 2비트로 충분하므로
// [1:0]이 맞다. 값이 0~3이라 상위 두 비트는 항상 0이고 합성기가
// 대개 제거하지만, 의도를 정확히 쓰는 편이 낫다.
// Fsm3onehot의 4비트 선언이 손에 남은 듯하다.
//==============================================================

module top_module(
    input clk,
    input in,
    input areset,
    output out);
    parameter A=0, B=1, C=2, D=3;
    reg [3:0] state, nextstate;
    // State transition logic
    always @(*) begin
        case (state)
            A : nextstate = in ? B : A;
            B : nextstate = in ? B : C;
            C : nextstate = in ? D : A;
            D : nextstate = in ? B : C;
        endcase
    end
    // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= A; 
        end 
        else begin
            state <= nextstate;
        end
    end
    // Output logic
    assign out = (state == D);
endmodule
