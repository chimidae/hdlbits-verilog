# Sequential Logic

HDLBits Sequential 문제를 풀면서 확인한 상태와 학습 포인트를 문제별로 짧게 기록한다. 문제 코드는 각 `.v` 파일에 두며, 이 파일에는 상태와 학습 포인트만 남긴다.

## Dff

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: `posedge clk`에서 입력 `d`를 `q`에 저장하는 D 플립플롭을 작성했다.
- 코드: [`dff.v`](../2_circuits/02_sequential/01_latches_and_ff/dff.v)

## Dff8

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 8비트 벡터를 한 번에 할당해 8개 플립플롭을 병렬로 표현할 수 있다.
- 코드: [`dff8.v`](../2_circuits/02_sequential/01_latches_and_ff/dff8.v)

## Dff8r

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: active-high reset을 `if (!reset)` 형태로 먼저 쓰면 active-low 신호와 극성을 혼동하기 쉬웠다.
- 배운 것: 동기 reset은 클럭 엣지에서 평가되며, reset 분기를 먼저 쓰면 극성을 더 명확하게 읽을 수 있다.
- 코드: [`dff8r.v`](../2_circuits/02_sequential/01_latches_and_ff/dff8r.v)

## Dff8ar

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 동기 reset과 비동기 reset의 차이를 검색했다.
- 배운 것: 동기 reset은 클럭 엣지에서만 평가되고, 비동기 reset은 reset의 활성 엣지에서도 즉시 적용된다.
- 코드: [`dff8ar.v`](../2_circuits/02_sequential/01_latches_and_ff/dff8ar.v)

## Dff8p

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 1차 시도에서 reset 분기와 정상 동작 분기의 할당값을 반대로 작성했다.
- 배운 것: active-high synchronous reset은 `negedge clk`에서 `reset`을 검사하며, reset이면 `8'h34`, 아니면 `d`를 저장한다.
- 코드: [`dff8p.v`](../2_circuits/02_sequential/01_latches_and_ff/dff8p.v)
- 실패 기록: 2026-07-24 1차 시도에서 `negedge clk`를 사용하고 reset 분기에서 `d`, 그 외 분기에서 `8'h34`를 할당했으나 HDLBits FAIL.

## Dff16e

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: `byteena`가 0일 때 해당 바이트를 할당하지 않아도 되는 이유와 래치가 생기는지 질문함.
- 몰랐던 부분: active-low reset의 조건을 반대로 썼고, `byteena`가 0이면 해당 바이트를 0으로 만드는 것으로 이해했다.
- 배운 것: `resetn == 0`일 때 동기 reset이 적용된다. clocked `always` 블록에서 `byteena`가 0인 바이트를 할당하지 않으면 해당 플립플롭은 이전 값을 유지하며 래치가 생기지 않는다.
- 코드: [`dff16e.v`](../2_circuits/02_sequential/01_latches_and_ff/dff16e.v)
- 실패 기록: 1차 시도에서 reset 극성을 반대로 쓰고, `byteena`가 0인 바이트에 0을 할당해 HDLBits FAIL. 파형에서 reset 반전과 부분 바이트 mismatch를 확인한 뒤 수정함.

## Exams/m2014 q4a

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 래치를 만드는 다른 RTL 표현이 있는지 질문함.
- 몰랐던 부분: `always @(*)`에서 일부 조건에 출력을 할당하지 않는 방식이 의도적으로 래치를 추론하는 표준 방식인지 궁금했다.
- 배운 것: `ena == 0`일 때 `q`가 이전 값을 유지해야 하므로 저장소가 필요하며, edge가 아닌 enable 레벨에 반응하므로 래치가 된다. Verilog에서는 불완전 할당으로 추론하고, SystemVerilog에서는 `always_latch`로 의도를 명시할 수 있다.
- 코드: [`m2014_q4a.v`](../2_circuits/02_sequential/01_latches_and_ff/m2014_q4a.v)

## Exams/m2014 q4b

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`m2014_q4b.v`](../2_circuits/02_sequential/01_latches_and_ff/m2014_q4b.v)

## Exams/m2014 q4c

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`m2014_q4c.v`](../2_circuits/02_sequential/01_latches_and_ff/m2014_q4c.v)

## Exams/m2014 q4d

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: `D` 계산과 `out` 연결을 clocked `always` 안에 넣었을 때 왜 실패하는지 확인함.
- 몰랐던 부분: clocked `always` 안에 쓴 `D`, `Q`, `out`이 모두 클럭 엣지에서 갱신되는 저장소가 되고, non-blocking 할당은 같은 엣지에서 계산한 새 값이 아니라 이전 값을 읽는다는 점.
- 배운 것: `D = in ^ Q`와 `out = Q`는 조합 연결이고 `Q`만 플립플롭이어야 한다. 따라서 `D`와 `out`은 continuous assignment로 연결하고 `Q <= D`만 `posedge clk` 블록에 둔다.
- 코드: [`m2014_q4d.v`](../2_circuits/02_sequential/01_latches_and_ff/m2014_q4d.v)
- 당시 가설: "둘 다 always 안에 넣으면 안됬던 모양. 이러면 FF으로 올라갈때만 연결되는 듯."
- 실패 기록: 1차 시도에서 `D <= in ^ Q`, `Q <= D`, `out <= Q`를 모두 `posedge clk` 블록에 넣어 HDLBits FAIL.

## Mt2015 muxdff

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: MUX 출력과 플립플롭 입력 사이를 중간 `wire D`로 표현하는 방식이 직관적이지 않다고 느꼈다.
- 배운 것: MUX 출력은 조합 논리로 계산하고, 그 결과를 `posedge clk`에서 `Q`에 저장하는 구조다.
- 코드: [`mt2015_muxdff.v`](../2_circuits/02_sequential/01_latches_and_ff/mt2015_muxdff.v)

## Exams/2014 q4a

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 처음에는 플립플롭 출력 `Q`를 피드백 신호 `o`에 연결하는 것을 빠뜨렸다.
- 배운 것: `E == 0`일 때 현재 `Q`를 다시 선택해 값을 유지하려면 `o = Q` 피드백 연결이 필요하다.
- 코드: [`2014_q4a.v`](../2_circuits/02_sequential/01_latches_and_ff/2014_q4a.v)

## Exams/ece241 2014 q4

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 회로도에서 Q 위의 언더바를 보지 못했다.
- 배운 것: 별도 기록 없음
- 코드: [`ece241_2014_q4.v`](../2_circuits/02_sequential/01_latches_and_ff/ece241_2014_q4.v)
- 당시 가설: "모식도에서 Q위에 언더바 있는거 안보고 했다가 많이 헤맸다."
- 실패 기록: 1차 시도에서 `Da = x & outa`, `Do = x | outo`로 반전 없이 작성해 FAIL.

## Exams/ece241 2013 q7

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: `Qold`를 어떻게 처리할지 고민이 길었다.
- 배운 것: 별도 기록 없음
- 코드: [`ece241_2013_q7.v`](../2_circuits/02_sequential/01_latches_and_ff/ece241_2013_q7.v)
- 당시 가설: "Qold를 어케 처리해야할까 고민 꽤 했다. 마지막에 일부로 else 안놓고 유지시키려고 저렇게 짠 것."

## Edgedetect

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 힌트를 요청함. 이후 "이게 왜 답이지", "왜 `~save & in`이 `pedge`가 되는 게 답이냐"고 반복해서 물음.
- 몰랐던 부분: 상세한 설명 없이 파형만 주어져서 뭘 하라는 건지 파악이 어려웠다.
- 배운 것: 결국 비트별로 0에서 1로 올라가는 것만 `pedge`로 빼오라는 문제였다.
- 코드: [`edgedetect.v`](../2_circuits/02_sequential/01_latches_and_ff/edgedetect.v)
- 당시 가설: "이전값을 세이브해두고 체크해둬서 한번 더 안일어나게 하려 했는데"
- 실패 기록: 1차로 `save` 없이 `if (pedge == in)`으로 `pedge`를 직접 껐다 켜려 함. 2차로 `save`를 도입했으나 `if` 블록 안에서 조건부로 갱신함. 3차로 `if (~save & in)`으로 벡터를 조건 자리에 넣음.

## Edgedetect2

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 힌트를 요청함.
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`edgedetect2.v`](../2_circuits/02_sequential/01_latches_and_ff/edgedetect2.v)
- 당시 가설: "문제 목표는 올라가는거랑 내려가는거 둘 다 얼마나 했는지를 anyedge에다가 넣는거 같은데."
- 실패 기록: 1차 시도에서 `if (save > in)`으로 상승과 하강을 분기로 나눔.

## Edgecapture

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 힌트를 요청함. 파형이 왜 안 맞는지, 더해야 하는 것인지 물음.
- 몰랐던 부분: 하강 검출 결과를 대입하는 게 아니라 누적해야 한다는 것.
- 배운 것: 별도 기록 없음
- 코드: [`edgecapture.v`](../2_circuits/02_sequential/01_latches_and_ff/edgecapture.v)
- 당시 가설: "일단 하강 버전의 edge 디텍트를 하고 있으며 이를 리셋하기 전 까지는 유지해야한다."
- 실패 기록: 1차 시도에서 보조 신호 `saved`를 두고 `out <= save & ~in`으로 대입해 기존 포착 비트가 지워짐.
- 남은 것: `if` 조건에 벡터를 넣어 접히는 것은 알고 일부러 한 것이었다. 하강할 때만 체크하려는 의도였다.

## Dualedge

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: `always @(posedge clk)` 외에 D 플립플롭을 회로도로 표현하는 다른 방식이 있는지, `always`를 여러 개 병렬로 써도 되는지, 1비트 신호에 1을 더하면 0이 되는지 질문함.
- 몰랐던 부분: `always @(posedge clk or negedge clk)`가 안 된다는 것.
- 배운 것: 별도 기록 없음
- 코드: [`dualedge.v`](../2_circuits/02_sequential/01_latches_and_ff/dualedge.v)
- 당시 가설: "따로 posedge 랑 negedge 두고 둘 중 하나 작동하면 작동했다고 신호 싸주고 받으면 되는거 아니냐고"
- 실패 기록: `pon`, `non`을 플래그로 쓰고 조합 블록에서 0으로 되돌리려 했으나, 한 `always`에서 받은 신호를 다른 `always`에서 덮어쓸 수 없어 실패. `pon`과 `non`의 연관성이 보여서 해결.

# Counters

## Count15

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`count15.v`](../2_circuits/02_sequential/02_counters/count15.v)

## Count10

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 랩 조건이 왜 10이 아니라 9인지 질문함.
- 몰랐던 부분: 랩 조건을 최대값이 아니라 그 다음 값으로 잡았다.
- 배운 것: 별도 기록 없음
- 코드: [`count10.v`](../2_circuits/02_sequential/02_counters/count10.v)
- 실패 기록: 1차 시도에서 `q >= 10`으로 작성해 FAIL.

## Count1to10

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`count1to10.v`](../2_circuits/02_sequential/02_counters/count1to10.v)
- 남은 것: `else` 분기에 blocking(`=`)을 쓴 것은 실수다.

## Countslow

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`countslow.v`](../2_circuits/02_sequential/02_counters/countslow.v)
- 실패 기록: 우여곡절이 많았다. 뻘짓한 버전 그대로 파일을 만들었다.

## Exams/ece241 2014 q7a

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 제공된 `count4`의 `load` 입력이 무엇인지, 인스턴스화 구문에서 syntax error가 나는 이유가 무엇인지 질문함.
- 몰랐던 부분: `load`가 무엇인지 몰랐다. 인스턴스화를 `always` 블록 안에 넣어도 되는 줄 알았다. `c_d`가 그냥 1이면 되는데 뭘 더 하라는 건지 헷갈렸다.
- 배운 것: 별도 기록 없음
- 코드: [`ece241_2014_q7a.v`](../2_circuits/02_sequential/02_counters/ece241_2014_q7a.v)
- 실패 기록: 1차로 `count4` 인스턴스화를 `always` 블록 안에 넣어 컴파일 실패. 2차로 `c_load = reset`만 두어 12 이후로 계속 증가. 3차로 `c_load = reset | (Q >= 12)`로 고쳤으나 파형을 보고 `& enable`을 추가함.

## Exams/ece241 2014 q7b

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: BCD 카운터가 무엇인지 질문함. 문제 이해가 맞는지 검토를 요청함(힌트는 요청하지 않음). Verilog에 소수점이 없는지 확인함. 속도 조정 방향에 대해 힌트를 받음.
- 몰랐던 부분: 세 카운터의 속도가 이미 조정된 것인지 직접 만들어야 하는 것인지 헷갈렸다.
- 배운 것: 별도 기록 없음
- 코드: [`ece241_2014_q7b.v`](../2_circuits/02_sequential/02_counters/ece241_2014_q7b.v)
- 당시 가설: "OneHertz는 아마 c_enable이 999가 되었을때 1 올리고 리셋되는거려나"
- 실패 기록: 1차 시도에서 인스턴스 이름을 `counter1`로 두 번 써서 컴파일 실패. `c_enable`을 `always` 안에서 만들려 했던 것도 `assign`으로 수정함.

## Countbcd

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음. 바로 성공함.
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`countbcd.v`](../2_circuits/02_sequential/02_counters/countbcd.v)

## Count clock

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`count_clock.v`](../2_circuits/02_sequential/02_counters/count_clock.v)
- 실패 기록: 수많은 실패 끝에 통과. 많이 더럽지만 스스로 했다는 데 의의를 둔다.

# Shift Registers

## Shift4

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`shift4.v`](../2_circuits/02_sequential/03_shift_registers/shift4.v)

## Rotate100

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 힌트를 요청함. 될 줄 알았는데 왜 틀렸는지 몰라서 물음.
- 몰랐던 부분: 회전 대상이 `data`가 아니라 `q`라는 것.
- 배운 것: 별도 기록 없음
- 코드: [`rotate100.v`](../2_circuits/02_sequential/03_shift_registers/rotate100.v)
- 실패 기록: 1차 시도에서 `q <= data >> 1`과 `q[99] <= data[0]`으로 작성해 FAIL.

## Shift18

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 문제가 요구하는 바가 부호 비트를 고려한 시프트가 맞는지 확인함.
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`shift18.v`](../2_circuits/02_sequential/03_shift_registers/shift18.v)

## Lfsr5

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`lfsr5.v`](../2_circuits/02_sequential/03_shift_registers/lfsr5.v)
- 남은 것: 약간 복잡하게 짰다.

## Mt2015 lfsr

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`mt2015_lfsr.v`](../2_circuits/02_sequential/03_shift_registers/mt2015_lfsr.v)

## Lfsr32

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`lfsr32.v`](../2_circuits/02_sequential/03_shift_registers/lfsr32.v)

## Exams/m2014 q4k

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 이 회로를 왜 만들게 하는지 질문함.
- 몰랐던 부분: 없음. `resetn`이 active-low라는 것은 앞에서 한 번 당해봐서 바로 처리함.
- 배운 것: 별도 기록 없음
- 코드: [`m2014_q4k.v`](../2_circuits/02_sequential/03_shift_registers/m2014_q4k.v)

## Exams/2014 q4b

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`2014_q4b.v`](../2_circuits/02_sequential/03_shift_registers/2014_q4b.v)

## Exams/ece241 2013 q12

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 시프트 레지스터가 어떤 구조인지 질문함. `S`를 `Q[0]`에 넣고 거기서 `Q[7]`을 다시 뽑는 순환 구조인지, `Q`를 `wire`로 선언하는 것이 맞는지 확인함.
- 몰랐던 부분: 시프트 레지스터의 구조. 문제 설명의 그 부분이 이해가 잘 안 됐다.
- 배운 것: 별도 기록 없음
- 코드: [`ece241_2013_q12.v`](../2_circuits/02_sequential/03_shift_registers/ece241_2013_q12.v)

# More Circuits

## Rule90

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`rule90.v`](../2_circuits/02_sequential/04_more_circuits/rule90.v)

## Rule110

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 이웃의 방향. `i+1`과 `i-1`을 반대로 썼다.
- 배운 것: 별도 기록 없음
- 코드: [`rule110.v`](../2_circuits/02_sequential/04_more_circuits/rule110.v)
- 실패 기록: 논리 구조가 복잡해서 벡터 방식 대신 `for`로 작성함. 처음에 `i+1`과 `i-1`을 반대로 써서 고생 조금 함.

## Conwaylife

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 힌트를 요청함. 뭘 놓친 것인지 물음.
- 몰랐던 부분: 괄호 위치. `& 15`가 덧셈 전체에 걸렸다.
- 배운 것: 별도 기록 없음
- 코드: [`conwaylife.v`](../2_circuits/02_sequential/04_more_circuits/conwaylife.v)
- 실패 기록: 1차로 `wire [15:0] row [0:15]` unpacked 배열을 `+:`로 잘라 row별로 연산하려 했으나 잘 안 됨. 2차로 `pandan` 변수에 이웃 합을 담아 `case`에 넣으려 함. 위 두 방식 다 clk 돌아갈 때 정상 동작하는지 의심이 들어 인덱스를 직접 계산하는 형태로 바꿈. 3차 시도에서 괄호 위치를 틀려 FAIL.
- 메모: [손으로 정리한 설계 메모](images/conwaylife-memo.jpg)

# Finite State Machines

## Fsm1

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: `parameter`가 무엇인지 질문함.
- 몰랐던 부분: `parameter`의 존재와 용도.
- 배운 것: 별도 기록 없음
- 코드: [`fsm1.v`](../2_circuits/02_sequential/05_fsm/fsm1.v)

## Fsm1s

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 문제가 준 템플릿의 의도가 무엇인지 질문함.
- 몰랐던 부분: Verilog-1995 포트 선언 문법과 1-always 스타일 FSM의 존재.
- 배운 것: 별도 기록 없음
- 코드: [`fsm1s.v`](../2_circuits/02_sequential/05_fsm/fsm1s.v)

## Fsm2

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`fsm2.v`](../2_circuits/02_sequential/05_fsm/fsm2.v)

## Fsm2s

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`fsm2s.v`](../2_circuits/02_sequential/05_fsm/fsm2s.v)

## Fsm3comb

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 이번 문제는 `clk`이 없었다.
- 코드: [`fsm3comb.v`](../2_circuits/02_sequential/05_fsm/fsm3comb.v)

## Fsm3onehot

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 문제 지문 번역을 요청함.
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`fsm3onehot.v`](../2_circuits/02_sequential/05_fsm/fsm3onehot.v)

## Fsm3

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`fsm3.v`](../2_circuits/02_sequential/05_fsm/fsm3.v)

## Fsm3s

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`fsm3s.v`](../2_circuits/02_sequential/05_fsm/fsm3s.v)

## Exams/ece241 2013 q4

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 문제 지문 번역을 요청함. `dfr`이 무엇을 하는 것인지 질문함.
- 몰랐던 부분: 이해하는 게 어려웠다. 뭐 하라는 건지 헷갈려서 많이 헤맸다.
- 배운 것: 별도 기록 없음
- 코드: [`ece241_2013_q4.v`](../2_circuits/02_sequential/05_fsm/ece241_2013_q4.v)
- 당시 가설: "일단 상태는 수위가 되고 총 4개고 각각에 따라 S123을 입력받으면 한칸 위로 전이되고 유랑 압력은 하나씩 꺼지는 형태인데"
- 메모: [상태 모식도](images/ece241-2013-q4-memo.jpg)

## Lemmings1

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 딱히 어려울 건 없었다.
- 배운 것: 별도 기록 없음
- 코드: [`lemmings1.v`](../2_circuits/02_sequential/05_fsm/lemmings1.v)

## Lemmings2

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 떨어진 이후 떨어지기 전 방향이랑 똑같이 움직여야 된다를 어떻게 구현할지 고민했다.
- 배운 것: 별도 기록 없음
- 코드: [`lemmings2.v`](../2_circuits/02_sequential/05_fsm/lemmings2.v)
- 실패 기록: 처음에는 `original`이라는 reg를 만들어 떨어지기 전에 저장하고 불러오는 형태로 하려 했는데 래치가 생겨서 그냥 FALL 상태를 두 개로 나눔.

## Lemmings3

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 위에서 한 거랑 똑같이 그냥 DIG를 좌우로 나눠서 했다.
- 코드: [`lemmings3.v`](../2_circuits/02_sequential/05_fsm/lemmings3.v)

## Lemmings4

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 카운터 크기를 `[5:0]`으로 했다가 작아서 문제가 생겼다.
- 배운 것: 별도 기록 없음
- 코드: [`lemmings4.v`](../2_circuits/02_sequential/05_fsm/lemmings4.v)
- 실패 기록: counter까지는 했는데 크기가 작아서 문제가 생겼고 해결하는 데 꽤 걸림.

## Fsm onehot

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`fsm_onehot.v`](../2_circuits/02_sequential/05_fsm/fsm_onehot.v)
