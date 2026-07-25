# HDLBits Verilog 학습 기록

HDLBits를 처음부터 공부하며 작성한 Verilog 풀이와 학습 기록을 보존한다. Sequential Logic 이후 문제는 문제별 `.v` 파일로 관리한다.

## 기록 구조

- `2_circuits/02_sequential/`: 문제별 HDLBits 코드와 실제 풀이 방식을 `.v` 파일 상단 주석에 기록한다. HDLBits 통과와 local simulation 결과는 별개로 관리한다.
- [`notes/sequential.md`](notes/sequential.md): 문제별 상태, local simulation 여부, AI에게 물은 내용, 몰랐던 부분, 배운 내용을 짧게 기록한다.
- [`notes/reflections/`](notes/reflections/): 사용자가 직접 작성한 장문 학습 회고를 원문 표현과 흐름을 유지해 보존한다.

## Local simulation

문제 파일과 `tb/tb_<문제 이름>.v`가 준비된 경우 다음 명령을 사용한다.

```bash
python scripts/sim.py dff8ar
python scripts/sim.py dff8ar --wave
```
