//==============================================================
// Problem : Count clock
// Section : Circuits / Sequential / Counters
// URL     : https://hdlbits.01xz.net/wiki/Count_clock
// Solved  : 2026-07-28
//--------------------------------------------------------------
// 헷갈린 부분:
// 초/분은 max를 파라미터로 받는 decade_counter 하나로 일반화해
// 재사용했다. 시 자리는 01-12라 0이 아니라 1에서 시작하고 12에서
// 1로 돌아가야 해서 별도 모듈(decade_counter2)로 분리했다.
//
// 남은 문제 두 가지가 있다. 테스트를 우연히 통과했을 뿐이다.
//
// 1. pm 토글 조건에 ena가 빠져 있다. clk은 빠르고 ena는 초당 한 번만
//    뜨므로, 11:59:59에 머무는 동안 ena가 0인 클럭마다 pm이 뒤집힌다.
//    조건에 & ena가 있어야 한다.
//
// 2. pm 블록에서 reset 우선순위가 깨져 있다. 두 번째 if가 else if가
//    아니라서, 11:59:59에 reset이 들어오면 아래쪽이 이겨 pm이 0이
//    되는 대신 토글된다. 문제는 reset이 enable보다 우선이라고 명시한다.
//
// decade_counter2 맨 위의 if (r == 0 & q == 0)도 reset 체인 밖에
// 있어서, hh가 00이 되는 경우가 생기면 예상 못 한 타이밍에 발동한다.
//==============================================================

module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    wire stena; //세컨드 부분
    assign stena = (ss[3:0] == 9 & ena); 
    decade_counter u0 (.clk(clk), .reset(reset), .enable(ena), .max(9), .q(ss[3:0]));
    decade_counter u1 (.clk(clk), .reset(reset), .enable(stena), .max(5), .q(ss[7:4]));
    wire mmena1, mmena2; //미닛 부분
    assign mmena1 = (ss[3:0] == 9 & ss[7:4] == 5 & ena);
    assign mmena2 = (mm[3:0] == 9 & ss[3:0] == 9 & ss[7:4] == 5 & ena);
    decade_counter u2 (.clk(clk), .reset(reset), .enable(mmena1), .max(9), .q(mm[3:0]));
    decade_counter u3 (.clk(clk), .reset(reset), .enable(mmena2), .max(5), .q(mm[7:4]));
    wire hhena1, hhena2; //아워 부분 << 여기가 레전드임. ㄹㅇ.
    assign hhena1 = (mm[3:0] == 9 & mm[7:4] == 5 & ss[3:0] == 9 & ss[7:4] == 5 & ena);
    decade_counter2 u4 (.clk(clk), .reset(reset), .enable(hhena1), .r(hh[7:4]), .q(hh[3:0]),);
    always @(posedge clk) begin //pm 구조 및 리셋 설정
        if (reset) begin
            pm <= 0;
        end
        if ((hh[3:0] == 1 & hh[7:4] == 1) & (mm[3:0] == 9 & mm[7:4] == 5) & (ss[3:0] == 9 & ss[7:4] == 5)) begin
            pm <= pm + 1;
        end
    end
endmodule

module decade_counter (
    input clk,
    input reset, // Synchronous active-high reset
    input enable,
    input [3:0] max,
    output [3:0] q);
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0;
        end
        else if (enable) begin
            q <= (q >= max ) ? 0 : q + 1;
        end
    end
endmodule

module decade_counter2 (
    input clk,
    input reset, // Synchronous active-high reset
    input enable,
    output [3:0] r,
    output [3:0] q);
    always @(posedge clk) begin
        if (  r == 0 & q == 0 ) begin
            r <= 1;
            q <= 2;
        end
        if (reset) begin
            r <= 1;
            q <= 2;
        end
        else if (enable) begin
            if ( r == 1 & q == 2 ) begin
                r <= 4'b0;
                q <= 1;
            end
            else begin
                if ( q >= 9 ) begin
                    r <= 1;
                    q <= 0;
                end
                else begin
                    q <= q + 1;
                end
            end
        end
    end
endmodule
