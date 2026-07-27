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
- 몰랐던 부분: AND와 OR 게이트로 돌아가는 피드백 선이 `Q`가 아니라 반전 출력에서 나온다는 것을 회로도에서 보지 못했다.
- 배운 것: 회로도를 그대로 옮기는 문제는 게이트 종류보다 각 입력이 `Q`인지 `~Q`인지를 먼저 확인해야 한다. 세 플립플롭은 초기값이 0으로 주어져 별도 reset 입력이 필요 없다.
- 코드: [`ece241_2014_q4.v`](../2_circuits/02_sequential/01_latches_and_ff/ece241_2014_q4.v)
- 당시 가설: "모식도에서 Q위에 언더바 있는거 안보고 했다가 많이 헤맸다."
- 실패 기록: 2026-07-27 1차 시도에서 `Da = x & outa`, `Do = x | outo`로 반전 없이 작성해 HDLBits FAIL.

## Exams/ece241 2013 q7

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: `J=K=0`일 때 `Qold`를 유지하는 동작을 코드로 어떻게 표현할지 고민했다.
- 배운 것: clocked `always` 블록에서 특정 조건에 `Q`를 할당하지 않으면 플립플롭이 이전 값을 유지한다. Dff16e의 `byteena`와 같은 원리이며, 마지막 `else`를 두지 않는 것이 곧 유지 동작이 된다. JK를 D로 옮기는 특성 방정식은 `D = j & ~Q | ~k & Q`이고, 위 조건 분기는 이 식과 같은 회로로 합성된다.
- 코드: [`ece241_2013_q7.v`](../2_circuits/02_sequential/01_latches_and_ff/ece241_2013_q7.v)
- 당시 가설: "Qold를 어케 처리해야할까 고민 꽤 했다. 마지막에 일부로 else 안놓고 유지시키려고 저렇게 짠 것."

## Edgedetect

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 힌트를 요청함. 8비트를 한 줄에 처리하는 것이 리덕션 연산자인지, `~save & in`이 왜 `pedge`가 되는지, 8비트 신호인데 결과가 1이라는 설명이 무슨 뜻인지 질문함.
- 몰랐던 부분: `pedge`를 켰다 꺼야 하는 상태로 보고 `if`로 억제 로직을 만들려 했다. 리덕션과 비트와이즈를 구분하지 못했고, `if`의 조건 자리에 벡터를 넣으면 리덕션 OR로 접힌다는 것을 몰랐다.
- 배운 것: `save <= in`으로 직전 입력을 들고 있으면 `~save & in`이 상승 시점에만 참이 된다. `save`가 한 클럭 뒤에 따라잡으면서 식이 저절로 0이 되므로 별도 억제 로직이 필요 없다. `if (벡터)`는 `if (|벡터)`로 접혀 8비트가 한 판단으로 뭉개지므로, 비트별 독립을 유지하려면 비트와이즈 연산만 써야 한다. `현재 & ~직전`은 상승 검출, `~현재 & 직전`은 하강 검출이다.
- 코드: [`edgedetect.v`](../2_circuits/02_sequential/01_latches_and_ff/edgedetect.v)
- 당시 가설: "이전값을 세이브해두고 체크해둬서 한번 더 안일어나게 하려 했는데"
- 실패 기록: 2026-07-27 1차 시도에서 `save` 없이 `if (pedge == in)`으로 `pedge`를 직접 껐다 켜려 해 FAIL. 파형에서 `in`이 1로 유지되는 동안 `pedge`가 반복 진동하는 것을 확인함. 2차 시도에서 `save`를 도입했으나 `if` 블록 안에서 조건부로 갱신해 직전 입력 보장이 깨져 FAIL. 3차 시도에서 `if (~save & in)`으로 벡터를 조건 자리에 넣어 비트별 독립이 깨져 FAIL.

## Edgedetect2

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 힌트를 요청함. 문제 목표가 상승과 하강을 모두 `anyedge`에 넣는 것이 맞는지 확인함.
- 몰랐던 부분: 1차 시도에서 `if (save > in)`으로 상승과 하강을 분기로 나누려 했다. Edgedetect와 같은 함정으로, 벡터 크기 비교라 8비트가 한 판단으로 접힌다.
- 배운 것: XOR은 "두 값이 다르다"를 비트별로 판정하므로 상승과 하강을 한 번에 잡는다. 상승 검출 `~save & in`과 하강 검출 `save & ~in`을 OR한 식이 `save ^ in`과 같다. 분기로 나누면 한 사이클에 상승 비트와 하강 비트가 동시에 있을 때 한쪽만 잡힌다.
- 코드: [`edgedetect2.v`](../2_circuits/02_sequential/01_latches_and_ff/edgedetect2.v)
- 당시 가설: "문제 목표는 올라가는거랑 내려가는거 둘 다 얼마나 했는지를 anyedge에다가 넣는거 같은데."
- 실패 기록: 2026-07-27 1차 시도에서 `if (save > in)` 분기로 상승과 하강을 나누어 작성함.

## Edgecapture

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 힌트를 요청함. 파형이 왜 안 맞는지, 하강했으면 1이 되는 것이 아니라 더해야 하는 것인지 질문함.
- 몰랐던 부분: `out`에 하강 검출 결과를 그대로 대입해서 이미 잡아둔 비트가 지워졌다. 파형에서 정답이 `2, 3, 7`로 누적되는데 자신의 출력은 `2, 1, 6`으로 갈아끼워지는 것을 보고 누적이 필요함을 알았다.
- 배운 것: capture는 누적이므로 `out`이 자기 자신을 재료로 써야 한다. `out | (save & ~in)`은 한 번 1이 된 비트가 0으로 돌아갈 경로가 없어 유지가 저절로 되고, 지우는 것은 reset뿐이다. 아무 비트도 하강하지 않으면 `save & ~in`이 0이므로 `out | 0 = out`이 돼 유지 게이트가 필요 없다. 같은 `always` 블록에서 같은 신호에 두 번 할당하면 마지막 것이 이기므로, 기본값을 먼저 쓰고 reset을 아래에서 덮어쓰는 패턴으로 reset 우선순위를 만든다.
- 코드: [`edgecapture.v`](../2_circuits/02_sequential/01_latches_and_ff/edgecapture.v)
- 당시 가설: "일단 하강 버전의 edge 디텍트를 하고 있으며 이를 리셋하기 전 까지는 유지해야한다."
- 실패 기록: 2026-07-27 1차 시도에서 보조 신호 `saved`를 두고 `out <= save & ~in`으로 대입해 기존 포착 비트가 지워져 FAIL. `if (save & ~in)`으로 벡터를 조건 자리에 넣은 것도 함께 수정함.

## Dualedge

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 힌트는 요청하지 않고 문법만 확인함. `always @(posedge clk)` 외에 D 플립플롭을 표현하는 다른 방식이 있는지, `always` 블록을 여러 개 병렬로 써도 되는지, 1비트 신호에 1을 더하면 0이 되는지 질문함.
- 몰랐던 부분: `always @(posedge clk or negedge clk)`로 양쪽 엣지를 한 블록에 묶으려 했다. 또 posedge와 negedge 블록 중 "한쪽만 동작한다"고 생각해 동작 여부를 플래그로 기록하려 했으나, 실제로는 매 클럭 두 블록이 번갈아 모두 동작하므로 플래그가 계속 1로 남는다.
- 배운 것: 하나의 `always`는 한쪽 엣지에만 반응하지만, 서로 다른 감지 리스트를 가진 블록을 병렬로 두면 된다. 단 한 신호는 하나의 블록에서만 할당해야 드라이버 충돌이 없다. 어느 엣지가 마지막이었는지는 플래그를 세우고 지우는 방식이 아니라, 각 블록에서 1비트를 토글시키고 둘을 XOR해서 판별한다. 조합 블록은 입력이 바뀔 때마다 다시 계산되므로 자기 출력을 자기 입력으로 읽으면 발진한다.
- 코드: [`dualedge.v`](../2_circuits/02_sequential/01_latches_and_ff/dualedge.v)
- 당시 가설: "따로 posedge 랑 negedge 두고 둘 중 하나 작동하면 작동했다고 신호 싸주고 받으면 되는거 아니냐고"
- 실패 기록: 2026-07-27 1차 시도에서 `always @(posedge clk or negedge clk)`를 쓰려다 불가능함을 확인. 2차 시도에서 `pon`, `non`을 플래그로 쓰고 조합 블록에서 0으로 되돌리려 했으나, 두 블록이 같은 신호를 할당해 드라이버 충돌이 발생함.
- 남은 것: `pon`과 `non`에 초기값이 없어 시뮬레이션 초반에 x가 나올 수 있다. HDLBits는 통과했지만 local sim에서는 확인이 필요하다.
