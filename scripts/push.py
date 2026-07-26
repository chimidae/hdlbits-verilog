"""
변경된 파일을 커밋하고 원격에 반영한다.

사용법:
    python scripts/push.py                  # 커밋 메시지 자동 생성
    python scripts/push.py solve: Lfsr5     # 메시지 직접 지정
    python scripts/push.py --allow-delete   # .v 삭제를 의도한 경우

동작 순서:
    1. git add -A 로 변경사항을 스테이징한다
    2. .v 파일 삭제가 섞여 있으면 중단한다 (실수 방지)
    3. .v 파일 헤더의 Problem 필드를 읽어 커밋 메시지를 만든다
    4. origin/main 을 가져와 rebase 한다
    5. push 한다
"""

import re
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
REMOTE = "origin"
BRANCH = "main"
PROBLEM_HEADER = re.compile(r"^//\s*Problem\s*:\s*(.+?)\s*$", re.MULTILINE)

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def git(*args, capture=True):
    """git 명령을 레포 루트에서 실행하고 (종료코드, stdout, stderr)를 돌려준다."""
    proc = subprocess.run(
        ["git", *args],
        cwd=REPO_ROOT,
        text=True,
        encoding="utf-8",
        errors="replace",
        capture_output=capture,
    )
    return proc.returncode, (proc.stdout or "").strip(), (proc.stderr or "").strip()


def staged_changes():
    """스테이징된 변경을 (상태코드, 경로) 목록으로 반환한다."""
    _, out, _ = git("diff", "--cached", "--name-status")
    rows = []
    for line in out.splitlines():
        parts = line.split("\t")
        if len(parts) >= 2:
            rows.append((parts[0], parts[-1]))
    return rows


def is_solution(path):
    """문제 풀이 .v 파일인지 판별한다. testbench는 제외."""
    return path.endswith(".v") and not path.startswith("tb/")


def problem_name(rel_path):
    """.v 파일 헤더의 Problem 필드를 읽는다. 없으면 파일명에서 유추한다."""
    file_path = REPO_ROOT / rel_path
    if file_path.exists():
        match = PROBLEM_HEADER.search(file_path.read_text(encoding="utf-8", errors="replace"))
        if match:
            return match.group(1)
    stem = Path(rel_path).stem
    return stem[:1].upper() + stem[1:]


def build_message(changes):
    """변경 내역에서 커밋 메시지를 만든다."""
    added = [p for s, p in changes if s.startswith("A") and is_solution(p)]
    modified = [p for s, p in changes if s.startswith("M") and is_solution(p)]
    new_tb = [p for s, p in changes if s.startswith("A") and p.startswith("tb/")]

    if added:
        return "solve: " + ", ".join(problem_name(p) for p in added)
    if modified:
        return "refactor: " + ", ".join(problem_name(p) for p in modified)
    if new_tb:
        return "test: " + ", ".join(Path(p).stem for p in new_tb) + " 추가"
    if changes and all(p.endswith(".md") for _, p in changes):
        return "docs: 학습 기록 갱신"
    return "chore: 작업 내용 반영"


def main():
    if not (REPO_ROOT / ".git").exists():
        sys.exit("[error] .git 이 없다. git clone 으로 받은 폴더가 아니면 push 할 수 없다.")

    code, _, err = git("rev-parse", "--verify", "HEAD")
    if code:
        sys.exit(f"[error] 커밋 이력이 없다. {err}")

    print("[1/5] 스테이징")
    code, _, err = git("add", "-A")
    if code:
        sys.exit(f"[error] {err}")

    changes = staged_changes()
    for status, path in changes:
        print(f"       {status}  {path}")
    if not changes:
        print("       변경사항 없음")

    allow_delete = "--allow-delete" in sys.argv
    deleted = [p for s, p in changes if s.startswith("D") and p.endswith(".v")]
    if deleted and not allow_delete:
        git("reset")
        print("[error] .v 파일 삭제가 감지돼 중단했다. 원격 기록이 지워질 수 있다.")
        for path in deleted:
            print(f"        D  {path}")
        print("        되돌리려면   : git restore .")
        print("        의도한 삭제면 : commit.bat --allow-delete")
        sys.exit(1)

    args = [a for a in sys.argv[1:] if a != "--allow-delete"]
    message = " ".join(args).strip() or build_message(changes)

    if changes:
        print(f"[2/5] 커밋: {message}")
        code, out, err = git("commit", "-m", message)
        if code:
            sys.exit(f"[error] {out or err}")
    else:
        print("[2/5] 커밋 생략")

    print("[3/5] fetch")
    code, _, err = git("fetch", REMOTE, BRANCH)
    if code:
        sys.exit(f"[error] {err}")

    print("[4/5] rebase")
    code, out, err = git("rebase", f"{REMOTE}/{BRANCH}")
    if code:
        git("rebase", "--abort")
        print(f"[error] 충돌로 rebase를 되돌렸다.\n{out or err}")
        sys.exit(1)

    print("[5/5] push")
    code, _, _ = git("push", REMOTE, BRANCH, capture=False)
    if code:
        sys.exit("[error] push 실패. 인증 상태나 원격 권한을 확인해라.")

    _, head, _ = git("log", "-1", "--pretty=%h %s")
    print(f"\n[ok] {head}")
    print("https://github.com/chimidae/hdlbits-verilog")


if __name__ == "__main__":
    main()
