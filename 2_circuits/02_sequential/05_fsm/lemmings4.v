//==============================================================
// Problem : Lemmings4
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Lemmings4
// Solved  : 2026-07-29
//--------------------------------------------------------------
// counter까지는 했는데 counter 크기를 [5:0]으로 했다가 작아서
// 문제가 생겼다. 해결하는 데 꽤 걸렸다.
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
    parameter LEFT = 0, RIGHT = 1, FALLRIGHT = 2, FALLLEFT = 3, DIGRIGHT = 4, DIGLEFT = 5, DEAD = 6;
    reg [2:0] state, nextstate;
    reg [6:0] counter;
    always @(*) begin
        case (state)
            LEFT : nextstate = ground ? (dig ? DIGLEFT : (bump_left ? RIGHT : LEFT)) : FALLLEFT;
            RIGHT : nextstate = ground ? (dig ? DIGRIGHT : (bump_right ? LEFT : RIGHT)) : FALLRIGHT;
            FALLRIGHT : nextstate = ground ? ((counter > 19) ? DEAD : RIGHT) : FALLRIGHT;
            FALLLEFT : nextstate = ground ? ((counter > 19) ? DEAD : LEFT) : FALLLEFT;
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
    always @(posedge clk) begin
        if ( state == FALLRIGHT | state == FALLLEFT ) begin
            counter <= counter + 1;
        end
        else if (state != DEAD) begin
            counter <= 0;
        end
    end
    assign walk_left = ( state == LEFT );
    assign walk_right = ( state == RIGHT );
    assign aaah = ( state == FALLRIGHT | state == FALLLEFT );
    assign digging = ( state == DIGRIGHT | state == DIGLEFT );
endmodule
