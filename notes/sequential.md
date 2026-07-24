# Sequential Logic

HDLBits sequential 구간을 풀면서 실제로 막혔던 지점만 기록한다. 교과서 요약은 쓰지 않는다.

---

## 1. Blocking vs Non-blocking

**언제 문제가 되는가**

<!-- 여기에 직접 겪은 케이스를 쓴다. 예: shift register에서 = 를 썼더니 한 클럭에 전부 밀려버린 상황 -->

**정리**

| 상황 | 연산자 | 이유 |
|---|:---:|---|
| `always @(posedge clk)` 안의 순차 로직 | `<=` | 같은 클럭 엣지에서 모든 플립플롭이 이전 값을 읽어야 한다 |
| `always @(*)` 안의 조합 로직 | `=` | 문장 순서대로 즉시 반영돼야 한다 |

**왜 섞으면 안 되는가**

<!-- 시뮬레이션은 통과하는데 합성 결과가 달라지는 이유를 직접 설명해본다 -->

---

## 2. Reset: synchronous vs asynchronous

```verilog
// 동기 리셋: reset이 sensitivity list에 없다
always @(posedge clk) begin
    if (reset) q <= 1'b0;
    else       q <= d;
end

// 비동기 리셋: negedge/posedge reset이 sensitivity list에 있다
always @(posedge clk or negedge areset) begin
    if (!areset) q <= 1'b0;
    else         q <= d;
end
```

**직접 겪은 것**

<!-- Dff8ar 계열에서 무엇을 틀렸는지 -->

**트레이드오프**

- 동기 리셋: 리셋 신호도 타이밍 분석 대상, 글리치에 강함, 클럭이 살아있어야 리셋됨
- 비동기 리셋: 클럭 없이도 즉시 리셋, 대신 release 타이밍(recovery/removal)이 문제됨

---

## 3. Latch 추론 (unintended latch)

**언제 생기는가**

조합 always 블록에서 모든 경로에 대해 출력을 할당하지 않으면 이전 값을 유지해야 하므로 래치가 생긴다.

<!-- 실제로 래치가 추론된 케이스와, 그걸 어떻게 알아챘는지 -->

**막는 법**

- always 블록 맨 위에서 기본값 할당
- if에 대응하는 else, case에 default를 항상 둔다

---

## 4. FSM

**Moore vs Mealy**

<!-- 실제 문제에서 어떤 걸 골랐고 왜인지 -->

**상태 인코딩**

| 방식 | 특징 |
|---|---|
| Binary | 상태 레지스터 개수 최소, 디코딩 로직 큼 |
| One-hot | 레지스터 많이 쓰지만 next-state 로직이 단순, FPGA에서 유리 |
| Gray | 인접 상태 전이 시 한 비트만 변함 |

**출력 로직을 어디에 두는가**

<!-- 조합 출력 vs 등록된 출력, 어느 문제에서 이게 문제됐는지 -->

**3-block vs 1-block 스타일**

<!-- 어떤 스타일로 정착했고 왜인지 -->

---

## 5. 그 외 막혔던 것

<!-- 위 분류에 안 들어가는 개별 이슈 -->

---

# 실패 로그

통과하지 못한 시도를 시간순으로 남긴다. 원인은 해결한 뒤에 직접 채운다.

## Dff8p — 1차 시도 (2026-07-24)

```verilog
module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    always @(negedge clk) begin
        if (reset) begin 
            q <= d;
        end
        else begin
            q <= 8'h34;
        end
    end
endmodule
```

결과: 실패

원인:

<!-- 해결하고 나서 채운다 -->
