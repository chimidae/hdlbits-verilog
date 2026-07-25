# HDLBits 학습 회고: Sequential Logic

## Latches and Flip-Flops

여기부터는 Github에다가 기록을 시작했다. 초반 flip flop 부분은 그냥 posedge clk를 always @( )안에 쓰면 clk가 증가한 순간에 안에 있는 코드를 실행하는 구나 정도 알면 됬다. 이후 reset이 들어왔는데 그냥 always안에 if문으로 reset 신호가 들어오면 out 신호에 0 또는 특정 값으로 싹 밀면 됬다.

reset도 두종류가 존재하는데 synchronous랑 asynchronous 이렇게 두개인데 전자는 앞에서 설명 했고 asynchronous는 posedge clk or posedge areset으로 둔다. 이러면 기존 싱크로 버전에서는 reset이 1일때 clk가 올라가야만 리셋이 되는데 리셋이 1이 된 순간에 바로 밀 수 있다는 기능이 있다.

다음으로 byte enable기능인데
