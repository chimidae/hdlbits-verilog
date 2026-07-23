//==============================================================
// Section : Verilog Language / Basics
//--------------------------------------------------------------
// 묶음 파일. 한 줄로 끝나는 문제들이라 개별 커밋하지 않는다.
// HDLBits 원본은 전부 모듈명이 top_module이므로 여기서는 충돌을 피하려고
// 문제명 접미사를 붙였다. 로직 자체는 제출한 것과 동일하다.
//
// 각 모듈 위의 //-- 한 줄이 scripts/gen_readme.py가 읽는 헤더다.
//==============================================================

//-- Wire | https://hdlbits.01xz.net/wiki/Wire
module wire_top (
    input  in,
    output out
);
    assign out = in;
endmodule


//-- GND | https://hdlbits.01xz.net/wiki/GND
module gnd_top (
    output out
);
    assign out = 1'b0;
endmodule


//-- NOR | https://hdlbits.01xz.net/wiki/Norgate
module norgate_top (
    input  in1,
    input  in2,
    output out
);
    assign out = ~(in1 | in2);
endmodule


// 여기에 나머지 basics 문제를 같은 형식으로 이어 붙인다.
