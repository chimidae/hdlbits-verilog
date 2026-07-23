//==============================================================
// Testbench 템플릿
// tb_<problem>.v 로 복사해서 쓴다.
// scripts/sim.py 가 build/ 에서 실행하므로 dumpfile 경로는 상대경로로 둔다.
//==============================================================
`timescale 1ns / 1ps

module tb_template;

    // 클럭 주기 (ns)
    localparam CLK_PERIOD = 10;

    reg  clk;
    reg  reset;
    reg  d;
    wire q;

    // DUT 연결
    top_module dut (
        .clk   (clk),
        .reset (reset),
        .d     (d),
        .q     (q)
    );

    // 클럭 생성
    initial clk = 1'b0;
    always #(CLK_PERIOD / 2) clk = ~clk;

    // 파형 덤프
    initial begin
        $dumpfile("template.vcd");
        $dumpvars(0, tb_template);
    end

    // 자가 검증용 카운터
    integer error_count = 0;

    task check(input exp, input act, input [127:0] label);
        begin
            if (exp !== act) begin
                $display("[FAIL] %0t | %0s : expected=%b actual=%b", $time, label, exp, act);
                error_count = error_count + 1;
            end
        end
    endtask

    // 자극 인가
    initial begin
        reset = 1'b1;
        d     = 1'b0;
        @(negedge clk);
        @(negedge clk);
        reset = 1'b0;

        // 여기에 테스트 시퀀스를 채운다
        d = 1'b1;
        @(negedge clk);
        check(1'b1, q, "d=1 after one clock");

        d = 1'b0;
        @(negedge clk);
        check(1'b0, q, "d=0 after one clock");

        if (error_count == 0)
            $display("[PASS] all checks passed");
        else
            $display("[DONE] %0d failure(s)", error_count);

        $finish;
    end

endmodule
