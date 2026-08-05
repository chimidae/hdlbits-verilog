//==============================================================
// Problem : Fsm onehot
// Section : Circuits / Sequential / Finite State Machines
// URL     : https://hdlbits.01xz.net/wiki/Fsm_onehot
// Solved  : 2026-07-29
//==============================================================

module top_module(
    input in,
    input reg [9:0] state,
    output reg [9:0] next_state,
    output out1,
    output out2);
    parameter S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6,S7=7,S8=8,S9=9;
    assign next_state[0] = ( state[0] | state[1] | state[2] | state[3] | state[4] | state[7] | state[8] | state[9] ) & ~in;
    assign next_state[1] = ( state[0] | state[8] | state[9] ) & in;
    assign next_state[2] = state[1] & in;
    assign next_state[3] = state[2] & in;
    assign next_state[4] = state[3] & in;
    assign next_state[5] = state[4] & in;
    assign next_state[6] = state[5] & in;
    assign next_state[7] = (state[6] | state[7]) & in;
    assign next_state[8] = state[5] & ~in;
    assign next_state[9] = state[6] & ~in;
    assign out1 = (state[8] | state[9]);
    assign out2 = (state[7] | state[9]);
endmodule
