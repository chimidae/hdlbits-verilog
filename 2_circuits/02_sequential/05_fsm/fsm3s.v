//==============================================================
// Problem : Fsm3s
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm3s
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 헷갈린 부분: 없음.
// Fsm3의 동기 리셋 버전. 감지 리스트에서 posedge areset을 뺐다.
// Fsm3에서 지적받은 두 가지도 함께 고쳤다. 상태 폭을 [1:0]으로
// 줄이고 case에 default를 붙였다.
//==============================================================

module top_module(
    input clk,
    input in,
    input reset,
    output out);
    parameter A=0, B=1, C=2, D=3;
    reg [1:0] state, nextstate;
    // State transition logic
    always @(*) begin
        case (state)
            A : nextstate = in ? B : A;
            B : nextstate = in ? B : C;
            C : nextstate = in ? D : A;
            D : nextstate = in ? B : C;
            default : nextstate = state;
        endcase
    end
    // State flip-flops with asynchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= A; 
        end 
        else begin
            state <= nextstate;
        end
    end
    // Output logic
    assign out = (state == D);
endmodule
