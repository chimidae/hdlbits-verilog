//==============================================================
// Problem : Lemmings2
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Lemmings2
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 떨어진 이후 떨어지기 전 방향이랑 똑같이 움직여야 된다를 어떻게
// 구현할지 고민했다. 처음에는 original이라는 reg를 만들어 떨어지기
// 전에 저장하고 불러오는 형태로 하려 했는데 래치가 생겨서 그냥
// FALL 상태를 두 개로 나눴다.
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
