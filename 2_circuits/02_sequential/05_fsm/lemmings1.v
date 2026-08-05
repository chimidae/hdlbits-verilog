//==============================================================
// Problem : Lemmings1
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Lemmings1
// Solved  : 2026-07-29
//--------------------------------------------------------------
// 헷갈린 부분: 없음.
// 상태 두 개(LEFT, RIGHT)로 끝나는 기본 FSM이다. 벽에 부딪히면
// 반대 방향으로 전이하고, 출력은 상태에서 바로 나온다.
//==============================================================

module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter LEFT=0, RIGHT=1;
    reg state, next_state;
    always @(*) begin
        case (state)
            LEFT : next_state = bump_left ? RIGHT : LEFT;
            RIGHT : next_state = bump_right ? LEFT : RIGHT;
        endcase
        // State transition logic
    end

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end
        else begin
            state <= next_state;
        end
        // State flip-flops with asynchronous reset
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
