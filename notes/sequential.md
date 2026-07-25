# Sequential Logic

HDLBits Sequential 문제를 풀면서 확인한 상태와 학습 포인트를 문제별로 짧게 기록한다. 문제 코드와 풀이 방식은 각 `.v` 파일에 둔다.

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
- 몰랐던 부분: 별도 기록 없음
- 배운 것: active-high 비동기 reset은 sensitivity list의 `posedge areset`과 `if (areset)`의 극성을 맞춰 작성한다.
- 코드: [`dff8ar.v`](../2_circuits/02_sequential/01_latches_and_ff/dff8ar.v)

## Dff8p

- 상태: HDLBits FAIL
- Local sim: NOT RUN
- AI에게 물은 것: 없음
- 몰랐던 부분: 실패 원인은 별도 기록 없음
- 배운 것: 별도 기록 없음
- 코드: [`dff8p.v`](../2_circuits/02_sequential/01_latches_and_ff/dff8p.v)
- 실패 기록: 2026-07-24 1차 시도에서 `negedge clk`를 사용하고 reset 분기에서 `d`, 그 외 분기에서 `8'h34`를 할당했으나 HDLBits FAIL.
