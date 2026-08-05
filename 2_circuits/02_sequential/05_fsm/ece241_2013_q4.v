//==============================================================
// Problem : Exams/ece241 2013 q4
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q4
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 이해하는 게 어려웠다. 뭐 하라는 건지 헷갈려서 많이 헤맸다.
// 처음에는 상태가 수위 4개고 전이가 한 방향이라고 생각했다.
// 모식도: notes/images/ece241-2013-q4-memo.jpg
//==============================================================

module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter BS1=0, S1S2H=1, S2S3H=2, AS3=3, S2S3L=4, S1S2L=5;
    reg [2:0] state, nextstate;
    always @(*) begin // 상태 전이 코드
        case (state)
            BS1 : nextstate = s[1] ? S1S2H : BS1;
            S1S2H : nextstate = (s[2] & s[1]) ? S2S3H : (s[1] ? S1S2H : BS1);
            S2S3H : nextstate = (s[3] & s[2] & s[1]) ? AS3 : (s[2] ? S2S3H : S1S2L);
            AS3 : nextstate = s[3] ? AS3 : S2S3L;
            S2S3L : nextstate =(s[3] & s[2] & s[1]) ? AS3 : (s[2] ? S2S3L : S1S2L);
            S1S2L : nextstate = (s[2] & s[1]) ? S2S3H : (s[1] ? S1S2L : BS1);
            default : nextstate = state;
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
            state <= BS1;
        end
        else begin
            state <= nextstate;
        end
    end
    assign fr3 = (state==BS1);
    assign fr2 = ((state==S1S2H) | (state==S1S2L) | (state==BS1));
    assign fr1 = (state!=AS3);
    assign dfr = ((state==S2S3L) | (state==S1S2L) | (state==BS1));
endmodule
