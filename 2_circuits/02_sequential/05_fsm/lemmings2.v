//==============================================================
// Problem : Lemmings2
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Lemmings2
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 헷갈린 부분:
// 떨어진 뒤 착지하면 떨어지기 전 방향으로 다시 걸어야 한다는 것을
// 어떻게 구현할지 고민했다. 처음에는 original이라는 reg를 만들어
// 떨어지기 전 방향을 저장하고 불러오려 했으나 래치가 생겼다.
//
// 대신 FALL 상태를 FALLLEFT와 FALLRIGHT 둘로 나눴다. 방향 정보를
// 별도 신호로 기억하는 대신 상태 자체에 담는 것이며,
// Exams/ece241 2013 q4에서 수위를 H/L로 쪼갠 것과 같은 발상이다.
//
// Moore 머신은 출력이 상태만으로 정해져야 하므로, 출력이 달라져야
// 하거나 이후 전이가 달라져야 하면 상태를 나누는 것이 정석이다.
//==============================================================

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    parameter LEFT = 0, RIGHT = 1, FALLRIGHT = 2, FALLLEFT = 3;
    reg [1:0] state, nextstate;
    always @(*) begin
        case (state)
            LEFT : nextstate = ground ? (bump_left ? RIGHT : LEFT) : FALLLEFT;
            RIGHT : nextstate = ground ? (bump_right ? LEFT : RIGHT) : FALLRIGHT;
            FALLRIGHT : nextstate = ground ? RIGHT : FALLRIGHT;
            FALLLEFT : nextstate = ground ? LEFT : FALLLEFT;
            default : nextstate = state;
        endcase
    end
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end
        else begin 
            state <= nextstate;
        end
    end
    assign walk_left = ( state == LEFT );
    assign walk_right = ( state == RIGHT );
    assign aaah = ( state == FALLRIGHT | state == FALLLEFT );
endmodule
