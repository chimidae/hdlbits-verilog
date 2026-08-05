//==============================================================
// Problem : Exams/ece241 2013 q4
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q4
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 헷갈린 부분:
// 문제가 요구하는 바를 파악하는 데 시간이 걸렸다.
//
// dfr(보조 밸브)은 수위가 내려왔을 때만 열린다. 같은 수위라도
// 어디서 도달했느냐로 출력이 갈린다.
//   아래에서 올라와 도달  -> 물이 차는 중 -> 공칭 유량만
//   위에서 내려와 도달    -> 물이 빠지는 중 -> 공칭 + dfr
//
// 그래서 수위 4개로는 부족하고 상태를 6개로 나눠야 한다.
// 중간 두 구간만 H(올라온 것)와 L(내려온 것)로 쪼갠다.
// 최상단(AS3)과 최하단(BS1)은 방향이 하나뿐이라 나눌 필요가 없다.
//
// 방향 정보를 별도 신호로 기억하는 대신 상태 자체에 담은 것이
// 이 문제의 핵심이다. Moore 머신이므로 출력이 상태만으로 정해져야
// 하기 때문이다.
//
// 물은 차기도 하고 빠지기도 하므로 전이는 위아래 양방향이다.
//
// 출력식에서 assign fr1 = (state != AS3)은 나머지 다섯을 나열하는
// 대신 예외 하나만 뺀 형태다.
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
