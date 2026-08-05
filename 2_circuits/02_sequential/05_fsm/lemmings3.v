//==============================================================
// Problem : Lemmings3
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Lemmings3
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 헷갈린 부분: 없음.
// Lemmings2와 같은 방식으로 DIG를 DIGLEFT와 DIGRIGHT로 나눴다.
// 파는 도중 땅이 사라지면 그 방향의 FALL로 가야 하므로 방향
// 정보가 필요하고, 상태를 나누는 것이 그대로 해답이 된다.
//
// LEFT/RIGHT의 전이에서 dig 판정이 bump보다 바깥에 있다.
// 문제가 요구한 우선순위(ground > dig > bump)가 삼항 중첩의
// 순서로 그대로 나타난다.
//==============================================================

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    parameter LEFT = 0, RIGHT = 1, FALLRIGHT = 2, FALLLEFT = 3, DIGRIGHT = 4, DIGLEFT = 5;
    reg [2:0] state, nextstate;
    always @(*) begin
        case (state)
            LEFT : nextstate = ground ? (dig ? DIGLEFT : (bump_left ? RIGHT : LEFT)) : FALLLEFT;
            RIGHT : nextstate = ground ? (dig ? DIGRIGHT : (bump_right ? LEFT : RIGHT)) : FALLRIGHT;
            FALLRIGHT : nextstate = ground ? RIGHT : FALLRIGHT;
            FALLLEFT : nextstate = ground ? LEFT : FALLLEFT;
            DIGRIGHT : nextstate = ground ? DIGRIGHT : FALLRIGHT;
            DIGLEFT : nextstate = ground ? DIGLEFT : FALLLEFT;
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
    assign digging = ( state == DIGRIGHT | state == DIGLEFT );
endmodule
