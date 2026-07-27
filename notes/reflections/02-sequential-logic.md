# HDLBits 학습 회고: Sequential Logic

## Latches and Flip-Flops

여기부터는 Github에다가 기록을 시작했다. 초반 flip flop 부분은 그냥 posedge clk를 always @( )안에 쓰면 clk가 증가한 순간에 안에 있는 코드를 실행하는 구나 정도 알면 됬다. 이후 reset이 들어왔는데 그냥 always안에 if문으로 reset 신호가 들어오면 out 신호에 0 또는 특정 값으로 싹 밀면 됬다.

reset도 두종류가 존재하는데 synchronous랑 asynchronous 이렇게 두개인데 전자는 앞에서 설명 했고 asynchronous는 posedge clk or posedge areset으로 둔다. 이러면 기존 싱크로 버전에서는 reset이 1일때 clk가 올라가야만 리셋이 되는데 리셋이 1이 된 순간에 바로 밀 수 있다는 기능이 있다.

다음으로 byte enable기능인데 일부 바이트만 적용시키고 나머지는 그냥 냅두면 posedge clk라서 래치 안생겼다. 이거 모르고 마음대로 0으로 리셋시켜서 고생했음.

이후에는 순조로웠음. 뭐 래치 만들기, 결과값 Q 가져오는 FF 라던가, 헤매도 위에 언더바 못보고 멍청한 실수만 하는 정도.

그러다가 엣지 디텍트 부분 들어갔는데 여기부터 진짜 힘들었다. 이미 해결하고 난 뒤 지금은 답이 보이기는 하는데 상세한 설명 없이 냅다 파형 주고 뭐하라는 건지도 모르겠어서 고생 좀 했다. 올라가는 값 out으로, 올라가는거랑 내려가는거 둘다 out시키기, 내려가는 값만 떼와서 더한다음 유지시키고 reset 들어오면 리셋시키기 까지 요렇게 세문제에서 각각 고생 조금 했다.

마지막 문제로 clk가 올라가는거랑 내려가는거 둘 다 캐치하는 거였다. 문제에서 원래 생각한 posedge clk or negedge clk 가 안된다길래 신기하기도 했고 always 하나에서 입력받은 전선은 또 다른 always에 덮어씌우기가 안되서 조금 고생하다가 pon이랑 non간의 연관성이 갑자기 보여서 해결함.

슬슬 난이도 높아지긴 하는듯.
