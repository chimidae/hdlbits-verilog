# HDLBits 학습 회고: Sequential Logic

## Latches and Flip-Flops

여기부터는 Github에다가 기록을 시작했다. 초반 flip flop 부분은 그냥 posedge clk를 always @( )안에 쓰면 clk가 증가한 순간에 안에 있는 코드를 실행하는 구나 정도 알면 됬다. 이후 reset이 들어왔는데 그냥 always안에 if문으로 reset 신호가 들어오면 out 신호에 0 또는 특정 값으로 싹 밀면 됬다.

reset도 두종류가 존재하는데 synchronous랑 asynchronous 이렇게 두개인데 전자는 앞에서 설명 했고 asynchronous는 posedge clk or posedge areset으로 둔다. 이러면 기존 싱크로 버전에서는 reset이 1일때 clk가 올라가야만 리셋이 되는데 리셋이 1이 된 순간에 바로 밀 수 있다는 기능이 있다.

다음으로 byte enable기능인데

실패에서 통과까지 간 방법. 파형 봤음. 처음 코드를 적고 Synchronous active-low reset 파형이 정확하게 반대로 되어있었음. 그래서 if resetn 에 있는 두개를 바꿨음. 그랬더니 DFF with byte enables 파형에서 q가 일부분이 0으로 되어있어서 mismatch 되어있는걸 봤음. 그래서 else 부분을 없앴음.
근데 왜 이게 답인지는 잘 모르겠음. 문제 보면 아마 byteena가 윗쪽 바이트만 control 한다고 하니 0일 경우 0으로 초기화할 의무는 없었을 것. 또한 resetn이라서 reset 반대로 하는게 아니었을까 싶었다. 마지막으로 else 0을 넣은 이유는 래치 생길까봐인데 상관 없었을까?
