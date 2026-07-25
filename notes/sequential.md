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
