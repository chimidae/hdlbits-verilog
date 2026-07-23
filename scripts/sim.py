"""
문제 이름 하나로 iverilog 컴파일 + vvp 실행 + GTKWave 열기까지 처리한다.

사용법:
    python scripts/sim.py dff8ar
    python scripts/sim.py dff8ar --wave

동작 순서:
    1. 레포 전체에서 <name>.v 를 찾는다
    2. tb/tb_<name>.v 를 찾는다
    3. iverilog로 두 파일을 합쳐 build/<name>.vvp 생성
    4. vvp 실행 (testbench가 $dumpfile로 build/<name>.vcd를 남기도록 작성돼 있어야 함)
    5. --wave 옵션이면 gtkwave로 VCD를 연다
"""

import argparse
import shutil
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
TB_DIR = REPO_ROOT / "tb"
BUILD_DIR = REPO_ROOT / "build"


def find_source(name):
    """레포 안에서 <name>.v 솔루션 파일을 찾는다."""
    candidates = [
        p for p in REPO_ROOT.rglob(f"{name}.v")
        if "tb" not in p.parts and "build" not in p.parts
    ]
    if not candidates:
        sys.exit(f"[error] {name}.v 를 찾을 수 없다.")
    if len(candidates) > 1:
        print(f"[warn] {name}.v 가 여러 개다. 첫 번째를 사용한다:")
        for c in candidates:
            print(f"        {c.relative_to(REPO_ROOT)}")
    return candidates[0]


def find_testbench(name):
    tb_path = TB_DIR / f"tb_{name}.v"
    if not tb_path.exists():
        sys.exit(f"[error] {tb_path.relative_to(REPO_ROOT)} 가 없다. testbench를 먼저 작성해라.")
    return tb_path


def check_tool(tool):
    if shutil.which(tool) is None:
        sys.exit(f"[error] {tool} 를 PATH에서 찾을 수 없다.")


def run(cmd, cwd=None):
    print(f"$ {' '.join(str(c) for c in cmd)}")
    result = subprocess.run(cmd, cwd=cwd)
    if result.returncode != 0:
        sys.exit(f"[error] 종료 코드 {result.returncode}")


def main():
    parser = argparse.ArgumentParser(description="HDLBits 솔루션 로컬 시뮬레이션")
    parser.add_argument("name", help="문제 이름 (확장자 없이, 예: dff8ar)")
    parser.add_argument("--wave", action="store_true", help="시뮬레이션 후 GTKWave 실행")
    args = parser.parse_args()

    check_tool("iverilog")
    check_tool("vvp")

    source = find_source(args.name)
    testbench = find_testbench(args.name)
    BUILD_DIR.mkdir(exist_ok=True)

    vvp_path = BUILD_DIR / f"{args.name}.vvp"
    vcd_path = BUILD_DIR / f"{args.name}.vcd"

    print(f"[src] {source.relative_to(REPO_ROOT)}")
    print(f"[tb ] {testbench.relative_to(REPO_ROOT)}")

    run(["iverilog", "-g2012", "-o", str(vvp_path), str(testbench), str(source)])
    run(["vvp", str(vvp_path)], cwd=BUILD_DIR)

    if args.wave:
        check_tool("gtkwave")
        if not vcd_path.exists():
            sys.exit("[error] VCD가 생성되지 않았다. testbench의 $dumpfile 경로를 확인해라.")
        subprocess.Popen(["gtkwave", str(vcd_path)])


if __name__ == "__main__":
    main()
