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

# Counters

## Count15

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 4비트 신호는 `15 + 1`이 자동으로 `0`이 되므로 별도 wrap 처리가 필요 없다. 동기 reset을 `if`로 먼저 두고 `else`에서 증가시키는 구조는 Edgecapture에서 쓴 기본값 덮어쓰기와 같은 구조이며 순서만 반대다.
- 코드: [`count15.v`](../2_circuits/02_sequential/02_counters/count15.v)

## Count10

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 랩 조건이 왜 10이 아니라 9인지 질문함.
- 몰랐던 부분: 1차 시도에서 `q >= 10`으로 랩 조건을 걸어 주기가 11이 됐다.
- 배운 것: 조건은 지금 값으로 검사하고 결과는 다음 값에 반영된다. `q <= 0`은 지금 `q`를 0으로 만드는 것이 아니라 다음 사이클의 `q`를 0으로 만드므로, `q`가 10이 되는 순간은 존재하지 않는다. mod-N 카운터의 랩 조건은 항상 `N-1`을 검사한다. Count15는 4비트 오버플로가 이걸 대신해줬을 뿐이고 원리는 같다.
- 코드: [`count10.v`](../2_circuits/02_sequential/02_counters/count10.v)
- 실패 기록: 2026-07-27 1차 시도에서 `q >= 10`으로 작성해 FAIL.

## Count1to10

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 별도 기록 없음
- 배운 것: 시작값이 0이 아니라 1이므로 reset과 랩 모두 `4'b0001`로 밀면 된다. 랩 조건은 Count10과 같은 원리로 최대값인 10을 그대로 검사한다.
- 코드: [`count1to10.v`](../2_circuits/02_sequential/02_counters/count1to10.v)
- 남은 것: `else` 분기에 blocking(`=`)을 쓰고 `if` 분기에는 non-blocking(`<=`)을 썼다. 분기가 배타적이라 결과가 같아 통과했지만, 순차 회로는 `<=`로 통일하는 것이 원칙이다. 섞어 쓰면 시뮬레이션과 합성 결과가 갈리는 경우가 생긴다.

## Countslow

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 통과 후 구조에 대한 피드백을 받음.
- 몰랐던 부분: `slowena`를 바깥 분기로 두는 바람에 `reset` 처리가 양쪽 가지에 모두 필요해져 같은 코드를 두 번 썼다.
- 배운 것: `if-else` 사슬은 위에서부터 우선순위이므로, 조건이 여러 개면 우선순위 순서대로 위에서 아래로 나열하면 중첩과 중복이 사라진다. `reset`을 맨 위로 올리고 `else if (slowena)`로 둘째 줄을 두면 된다. `slowena`가 0일 때 아무것도 할당하지 않는 것이 그대로 유지 동작이며, Exams/ece241 2013 q7의 `Qold` 처리와 같은 원리다.
- 코드: [`countslow.v`](../2_circuits/02_sequential/02_counters/countslow.v)

## Exams/ece241 2014 q7a

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 제공된 count4의 `load` 입력이 무엇인지, 인스턴스화 구문에서 syntax error가 나는 이유가 무엇인지 질문함.
- 몰랐던 부분: 모듈 인스턴스화를 `always` 블록 안에 넣어 syntax error가 났다. 또 카운트를 top_module이 직접 하려 했다. 실제로는 count4가 카운트하고 top_module은 제어 신호만 만든다.
- 배운 것: 모듈 인스턴스화는 문장이 아니라 배선이므로 `assign`과 같은 층위에 놓이고 `always` 밖에만 올 수 있다. count4는 스스로 랩하지 못하므로 12에서 1로 되돌리는 유일한 수단이 `load`다. `load`가 `enable`보다 우선순위가 높기 때문에, 랩 조건에 `enable`을 함께 물리지 않으면 카운터가 멈춰 있는 상태에서도 12에서 로드가 걸려 정지가 깨진다.
- 코드: [`ece241_2014_q7a.v`](../2_circuits/02_sequential/02_counters/ece241_2014_q7a.v)
- 실패 기록: 2026-07-28 1차 시도에서 `count4` 인스턴스화를 `always` 블록 안에 넣어 컴파일 실패. 2차 시도에서 `c_load = reset`만 두어 12 이후로 계속 증가함. 3차 시도에서 `c_load = reset | (Q >= 12)`로 수정했으나 파형을 보고 `enable`이 0일 때도 로드가 걸리는 것을 발견해 `& enable`을 추가함.
- 남은 것: `Q >= 12 & enable`은 연산자 우선순위가 우연히 맞았다. `(Q >= 12) & enable`처럼 괄호로 명시하는 편이 안전하다.

## Exams/ece241 2014 q7b

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: BCD 카운터가 무엇인지 질문함. 문제 이해가 맞는지 검토를 요청함(힌트는 요청하지 않음). Verilog에 소수점이 없는지 확인함. 속도 조정 방향에 대해 힌트를 받음.
- 몰랐던 부분: 세 카운터의 속도가 이미 조정된 것인지 직접 만들어야 하는 것인지 헷갈렸다. `c_enable`을 자릿수 이름으로 이해했으나 실제로는 각 카운터의 enable 입력으로 들어가는 신호다.
- 배운 것: 세 카운터가 모두 같은 1000 Hz `clk`을 직접 받고, 클럭을 나누는 것이 아니라 enable로 속도 차를 만든다. 윗자리 enable은 아랫자리가 한 바퀴 돌았다는 조건을 누적해서 만든다. 출력을 `always`에 넣으면 한 클럭 늦으므로 999가 아니라 998을 검사해야 한다. 조합으로 빼면 999를 그대로 검사하며 파형은 같다.
- 코드: [`ece241_2014_q7b.v`](../2_circuits/02_sequential/02_counters/ece241_2014_q7b.v)
- 당시 가설: "OneHertz는 아마 c_enable이 999가 되었을때 1 올리고 리셋되는거려나"
- 실패 기록: 2026-07-28 1차 시도에서 인스턴스 이름을 `counter1`로 두 번 써서 컴파일 실패. `c_enable`을 `always` 안에서 만들려 했던 것도 `assign`으로 수정함.

## Countbcd

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음. 한 번에 통과함.
- 몰랐던 부분: 없음
- 배운 것: Exams/ece241 2014 q7b의 구조를 그대로 옮겼다. 한 자리짜리 `decade_counter`를 직접 정의해 네 개 인스턴스화하고, 윗자리 enable은 아랫자리 조건을 누적해서 만든다. `ena[3]`이 세 자리 조건을 모두 확인하는 것이 캐리 전파와 같은 구조다.
- 코드: [`countbcd.v`](../2_circuits/02_sequential/02_counters/countbcd.v)

## Count clock

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음. 수많은 실패 끝에 스스로 해결함.
- 몰랐던 부분: 시 자리가 01-12라 0이 아니라 1에서 시작하고 12에서 1로 돌아가야 해서 처리가 까다로웠다. 별도 모듈로 분리해 해결함.
- 배운 것: 초와 분은 `max`를 파라미터로 받는 카운터 하나로 일반화해 네 자리에 재사용할 수 있다. 자리별 enable을 아랫자리 조건을 누적해 만드는 구조는 Countbcd와 같으며, 여기서는 모든 조건에 `ena`가 함께 들어가야 한다.
- 코드: [`count_clock.v`](../2_circuits/02_sequential/02_counters/count_clock.v)
- 남은 것: 통과했지만 잠복 버그가 둘 있다. (1) `pm` 토글 조건에 `ena`가 빠져 있어, 11:59:59에 머무는 동안 `ena`가 0인 클럭마다 `pm`이 뒤집힌다. (2) `pm` 블록의 두 번째 `if`가 `else if`가 아니라서, 11:59:59에 `reset`이 들어오면 아래쪽이 이겨 `pm`이 0이 되는 대신 토글된다. `else if`로 묶고 `& ena`를 추가하면 둘 다 해결된다. `decade_counter2` 맨 위의 `if (r == 0 & q == 0)`도 `reset` 체인 밖에 있어 구조상 불안정하다.

# Shift Registers

## Shift4

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 없음
- 배운 것: 비동기 리셋은 감지 리스트에 `posedge areset`을 추가해 만들고, 그 뒤로 load, ena 순서로 `else if`를 쌓으면 문제가 요구한 우선순위가 그대로 만들어진다. 우측 시프트는 `q >> 1`로 끝나며, 빈 자리에 0이 채워지고 `q[0]`은 버려진다.
- 코드: [`shift4.v`](../2_circuits/02_sequential/03_shift_registers/shift4.v)

## Rotate100

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 힌트를 요청함. 왜 틀렸는지 모르겠다고 질문함.
- 몰랐던 부분: 회전 대상을 `data`로 잡았다. `data`는 로드할 때만 쓰는 입력이고 회전시켜야 할 대상은 레지스터 자신인 `q`다. 또 `q`에 두 줄에 걸쳐 중복 할당했다.
- 배운 것: 회전은 "떼어낸 비트를 반대쪽 끝에 붙이는 것"이므로 concatenation 한 줄로 그대로 옮길 수 있다. 우회전은 `{q[0], q[99:1]}`, 좌회전은 `{q[98:0], q[99]}`. 시프트와 달리 밀려난 비트를 버리지 않고 반대쪽으로 재입력한다.
- 코드: [`rotate100.v`](../2_circuits/02_sequential/03_shift_registers/rotate100.v)
- 실패 기록: 2026-07-28 1차 시도에서 `q <= data >> 1`과 `q[99] <= data[0]`으로 작성해 FAIL.
- 남은 것: `reg save;`는 쓰지 않는 신호라 삭제 가능하다.

## Shift18

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 문제가 요구하는 바가 부호 비트를 고려한 시프트가 맞는지 확인함.
- 몰랐던 부분: 없음
- 배운 것: 산술 우측 시프트는 빈 자리에 0이 아니라 부호 비트 `q[63]`을 채워야 음수가 음수로 남는다. 좌측 시프트는 산술과 논리가 같아 아래에 0을 채우면 된다. 반복 연결 `{n{신호}}`은 부호 확장과 벡터 채우기에 계속 쓰이는 패턴이다. `>>>` 연산자도 있으나 피연산자가 `signed`여야 산술 시프트로 동작한다.
- 코드: [`shift18.v`](../2_circuits/02_sequential/03_shift_registers/shift18.v)

## Lfsr5

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 없음
- 배운 것: Galois LFSR은 탭이 있는 위치만 출력 비트와 XOR하고 나머지는 그대로 시프트한다. reset이 `5'h1`이라 `q[0]`만 1이고 나머지는 0이므로, 리셋값이 다른 플립플롭 모듈을 둘로 나누어 인스턴스화했다. 이 방식은 회로도와 1:1로 대응된다는 장점이 있다.
- 코드: [`lfsr5.v`](../2_circuits/02_sequential/03_shift_registers/lfsr5.v)
- 남은 것: `always` 블록 하나로 압축할 수 있다. `if (reset) q <= 5'h1; else q <= {q[0], q[4], q[3]^q[0], q[2], q[1]};` 다음 상태 전체를 한 줄로 기술하는 형태가 LFSR에서는 더 흔하다.

## Mt2015 lfsr

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음. Lfsr5 직후에 배운 압축 형태를 바로 적용해 통과함.
- 몰랐던 부분: 없음
- 배운 것: 다음 상태 전체를 concatenation 한 줄로 기술하면 `{}` 안의 삼항 연산자가 회로도의 MUX와 1:1로 대응한다. `reg [2:0]`은 플립플롭 세 개이며, `<=`로 한 줄에 할당하는 것은 세 개가 동시에 자기 D를 샘플링하는 것과 같다.
- 코드: [`mt2015_lfsr.v`](../2_circuits/02_sequential/03_shift_registers/mt2015_lfsr.v)
- 남은 것: `L`이 세 MUX에 공통으로 들어가므로 밖으로 빼낼 수 있다. `LEDR <= KEY[1] ? SW : {LEDR[1]^LEDR[2], LEDR[0], LEDR[2]};`

## Lfsr32

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 없음
- 배운 것: Lfsr5의 압축 형태를 32비트로 그대로 확장했다. 탭 번호는 1부터, 비트 인덱스는 0부터라 한 칸씩 밀린다. 탭 32, 22, 2, 1은 `q[31]`, `q[21]`, `q[1]`, `q[0]`이며, Galois 구조에서 XOR은 해당 탭 위치로 들어오는 자리에 붙는다. `{}` 안의 폭 합이 32가 되는지 확인해야 하며, 어긋나면 컴파일은 통과하고 동작만 틀려서 찾기 어렵다.
- 코드: [`lfsr32.v`](../2_circuits/02_sequential/03_shift_registers/lfsr32.v)

## Exams/m2014 q4k

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 이 회로를 왜 만들게 하는지 물음.
- 몰랐던 부분: 없음. `resetn`이 active-low라는 것은 앞서 한 번 겪어본 패턴이라 바로 처리함.
- 배운 것: 4단 시프트 레지스터는 그 자체로 지연선(delay line)이며, `in`이 4클럭 뒤에 `out`으로 나온다. 시프트 레지스터의 가장 기본 용도가 이것이다. 파이프라인 정렬(연산 결과와 원본 데이터의 타이밍 맞추기), CDC용 2-FF synchronizer, 엣지 검출의 직전값 보관에 계속 쓰인다. Edgedetect의 `save`가 1단 지연선이었다.
- 코드: [`m2014_q4k.v`](../2_circuits/02_sequential/03_shift_registers/m2014_q4k.v)

## Exams/2014 q4b

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 없음
- 배운 것: Exams/2014 q4a에서 만든 MUXDFF를 네 개 인스턴스화해 체인으로 잇는다. `u0`의 `w`만 외부 입력이고 나머지는 앞단의 `Q`를 받는다. 삼항 중첩에서 `L`이 `E`보다 바깥에 있어야 로드가 우선이 되며, 둘 다 0이면 `Q`를 그대로 넣어 유지한다.
- 코드: [`2014_q4b.v`](../2_circuits/02_sequential/03_shift_registers/2014_q4b.v)

## Exams/ece241 2013 q12

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 시프트 레지스터의 구조가 어떤 것인지 물음. `Q[0]`에 넣고 거기서 `Q[7]`을 다시 뽑아 순환하는 구조인지, `Q`를 `wire`로 선언하는 것이 맞는지 확인함.
- 몰랐던 부분: "MSB가 먼저 시프트되어 들어간다"는 설명을 배선 구조에 대한 설명으로 오해해 순환 구조로 생각했다.
- 배운 것: 시프트 레지스터는 `S -> Q[0] -> Q[1] -> ... -> Q[7]`로 이어진 단방향 체인이며 되돌아오는 경로가 없다. 순서 설명은 처음 넣은 비트가 결국 `Q[7]`까지 밀린다는 뜻이다. 8:1 MUX는 `Q[{A,B,C}]`로 가변 인덱싱하면 합성기가 MUX로 만들어준다. 이 회로가 3입력 LUT이며, FPGA의 기본 구성 요소다.
- 코드: [`ece241_2013_q12.v`](../2_circuits/02_sequential/03_shift_registers/ece241_2013_q12.v)

# More Circuits

## Rule90

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 없음
- 배운 것: 규칙은 "다음 상태 = 좌우 이웃의 XOR" 한 줄로 압축된다. 진리표를 그대로 옮길 필요가 없다. 경계 `q[-1]`과 `q[512]`는 0이므로 양 끝만 따로 처리한다.
- 코드: [`rule90.v`](../2_circuits/02_sequential/04_more_circuits/rule90.v)
- 남은 것: `for` 루프 없이 concatenation 하나로 접을 수 있다. `q <= load ? data : ({1'b0, q[511:1]} ^ {q[510:0], 1'b0});` 앞쪽이 왼쪽 이웃 전체, 뒷쪽이 오른쪽 이웃 전체이며 경계에 0을 붙이는 것이 경계 조건을 대신한다. 512칸짜리 `for`는 눈으로 검산이 안 되므로 벡터 연산으로 접을 수 있으면 접는 편이 실수가 적다.

## Rule110

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 이웃의 방향을 반대로 잡아 `i+1`과 `i-1`을 바꿔 썼다.
- 배운 것: Rule90은 XOR이라 좌우 대칭이어서 방향이 틀려도 통과했지만, Rule110은 비대칭이라 방향이 결과를 바꾼다. `q[511]`이 가장 왼쪽 셀이므로 인덱스가 클수록 왼쪽이며, `q[i+1]`이 왼쪽 이웃 `L`, `q[i-1]`이 오른쪽 이웃 `R`이다. 진리표를 정리하면 `next = (C ^ R) | (~L & C)`가 된다.
- 코드: [`rule110.v`](../2_circuits/02_sequential/04_more_circuits/rule110.v)
- 남은 것: 벡터로 접으면 한 줄이 된다. `q <= load ? data : ((q ^ {q[510:0], 1'b0}) | (~{1'b0, q[511:1]} & q));` Rule90과 같은 "시프트로 이웃을 정렬하고 비트와이즈로 묶기" 패턴이고 식만 바뀌었다.

## Conwaylife

- 상태: HDLBits PASS
- Local sim: NOT RUN
- AI에게 물은 것: 힌트를 요청함. 뭐를 놓친 것인지 질문함.
- 몰랐던 부분: 연산자 우선순위. `(j/16)*16 + (j%16 - 1) & 15`로 써서 `&`가 `+`보다 우선순위가 낮아 덧셈 전체에 `& 15`가 걸렸다.
- 배운 것: 256비트를 16x16 격자로 보면 `j`번 셀의 행은 `j/16`, 열은 `j%16`이다. 토로이드 경계는 조건 분기 없이 `& 15` 마스킹으로 접힐 수 있다. 단 랩어라운드시킬 항만 괄호로 묶어야 하며, 이 문제는 논리보다 인덱스 계산이 전부다.
- 코드: [`conwaylife.v`](../2_circuits/02_sequential/04_more_circuits/conwaylife.v)
- 실패 기록: 2026-07-28 1차로 `wire [15:0] row [0:15]` unpacked 배열을 `+:`로 잘라 row별 연산을 시도함. 2차로 `pandan` 변수에 이웃 합을 담아 `case`에 넣는 방식을 시도함. 둘 다 클럭 동작이 정상인지 확신이 서지 않아 포기하고 인덱스를 직접 계산하는 형태로 선회함. 3차 시도에서 괄호 위치를 틀려 `& 15`가 덧셈 전체에 걸려 FAIL.
- 남은 것: 포기한 두 방식 모두 실제로는 동작한다. unpacked 배열은 `q`를 다르게 잘라 보는 배선일 뿐이라 레지스터가 아니고 클럭과 무관하다. `pandan` 방식은 대입 연산자가 관건이다. `always` 블록 안에서 계산 중간값으로 쓰는 임시 변수는 blocking(`=`)으로 써야 아래 `case`가 새 값을 본다. non-blocking(`<=`)으로 쓰면 블록이 끝나야 반영되어 `case`가 직전 값을 읽는다. "순차 회로는 무조건 `<=`"가 아니라 플립플롭이 될 신호만 `<=`다.
- 메모: [손으로 정리한 설계 메모](images/conwaylife-memo.jpg)
