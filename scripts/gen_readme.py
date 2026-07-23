"""
HDLBits 솔루션 파일의 헤더를 파싱해서 README.md의 진행 현황 테이블을 갱신한다.

사용법:
    python scripts/gen_readme.py

두 가지 헤더 형식을 지원한다.

1. 개별 파일 (sequential 이후, 문제당 파일 하나)
   파일 상단 블록 주석에서 Problem / Section / URL / Tier / Solved 를 읽는다.

       //==============================================================
       // Problem : Dff8ar
       // Section : Circuits / Sequential / Latches and Flip-Flops
       // URL     : https://hdlbits.01xz.net/wiki/Dff8ar
       // Tier    : 2
       // Solved  : 2026-07-23
       //==============================================================

2. 묶음 파일 (basics, vectors 등 개별 커밋 가치가 없는 구간)
   파일 상단 블록에 Section 만 두고, 각 모듈 위에 한 줄 헤더를 단다.

       //-- Wire | https://hdlbits.01xz.net/wiki/Wire

   묶음 항목은 Tier를 'batch'로 취급하고 개별 링크 대신 개수로만 집계한다.
"""

import re
import sys
from pathlib import Path
from collections import defaultdict

REPO_ROOT = Path(__file__).resolve().parent.parent
README_PATH = REPO_ROOT / "README.md"

START_MARKER = "<!-- PROGRESS:START -->"
END_MARKER = "<!-- PROGRESS:END -->"

SOLUTION_DIRS = ["1_verilog_language", "2_circuits", "3_verification"]

BLOCK_FIELD = re.compile(r"^\s*//\s*(Problem|Section|URL|Tier|Solved)\s*:\s*(.+?)\s*$")
INLINE_ENTRY = re.compile(r"^\s*//--\s*(.+?)\s*\|\s*(\S+)\s*$")

TIER_LABEL = {
    "1": "1",
    "2": "**2**",
    "3": "**3**",
}


def parse_block_header(lines):
    """파일 상단 연속된 주석 블록에서 메타 필드를 읽는다."""
    meta = {}
    for line in lines:
        stripped = line.strip()
        if stripped and not stripped.startswith("//"):
            break
        match = BLOCK_FIELD.match(line)
        if match:
            meta[match.group(1)] = match.group(2)
    return meta


def parse_inline_entries(lines):
    """파일 전체에서 '//-- 문제명 | URL' 형태의 한 줄 헤더를 모은다."""
    entries = []
    for line in lines:
        match = INLINE_ENTRY.match(line)
        if match:
            entries.append({"Problem": match.group(1), "URL": match.group(2)})
    return entries


def collect_solutions():
    """레포 전체를 훑어 개별 솔루션과 묶음 항목을 분리해 수집한다."""
    solo = []
    batched = []
    skipped = []

    for top in SOLUTION_DIRS:
        top_path = REPO_ROOT / top
        if not top_path.exists():
            continue

        for verilog_file in sorted(top_path.rglob("*.v")):
            lines = verilog_file.read_text(encoding="utf-8").splitlines()
            rel_path = verilog_file.relative_to(REPO_ROOT).as_posix()

            header = parse_block_header(lines)
            inline = parse_inline_entries(lines)

            if inline:
                # 묶음 파일
                section = header.get("Section", top)
                for entry in inline:
                    entry["Section"] = section
                    entry["path"] = rel_path
                    batched.append(entry)
                continue

            if "Problem" in header and "URL" in header:
                header["path"] = rel_path
                header.setdefault("Section", top)
                header.setdefault("Tier", "2")
                header.setdefault("Solved", "")
                solo.append(header)
                continue

            skipped.append(rel_path)

    return solo, batched, skipped


def build_table(solo, batched):
    """개별 솔루션은 테이블로, 묶음 항목은 요약 줄로 렌더링한다."""
    total = len(solo) + len(batched)
    if total == 0:
        return "_No solutions committed yet._"

    tier_count = defaultdict(int)
    for entry in solo:
        tier_count[entry["Tier"]] += 1

    lines = [
        f"**{total}** problems solved. "
        f"{len(solo)} committed individually "
        f"(tier 2: {tier_count['2']}, tier 3: {tier_count['3']}), "
        f"{len(batched)} kept in batch files.",
        "",
    ]

    # 묶음 파일 요약
    if batched:
        by_file = defaultdict(list)
        for entry in batched:
            by_file[entry["path"]].append(entry)

        lines.append("### Batched")
        lines.append("")
        lines.append("Trivial problems, grouped one file per category.")
        lines.append("")
        lines.append("| File | Section | Count |")
        lines.append("|---|---|:---:|")
        for path in sorted(by_file):
            section = by_file[path][0]["Section"]
            lines.append(f"| [`{Path(path).name}`]({path}) | {section} | {len(by_file[path])} |")
        lines.append("")

    # 개별 솔루션
    if solo:
        by_section = defaultdict(list)
        for entry in solo:
            by_section[entry["Section"]].append(entry)

        for section in sorted(by_section):
            lines.append(f"### {section}")
            lines.append("")
            lines.append("| Problem | Tier | Solved | Source |")
            lines.append("|---|:---:|:---:|---|")
            for entry in sorted(by_section[section], key=lambda e: e["Problem"].lower()):
                tier = TIER_LABEL.get(entry["Tier"], entry["Tier"])
                lines.append(
                    f"| [{entry['Problem']}]({entry['URL']}) "
                    f"| {tier} | {entry['Solved']} "
                    f"| [`{Path(entry['path']).name}`]({entry['path']}) |"
                )
            lines.append("")

    return "\n".join(lines)


def update_readme(table_text):
    content = README_PATH.read_text(encoding="utf-8")

    if START_MARKER not in content or END_MARKER not in content:
        print(f"[error] README에 {START_MARKER} / {END_MARKER} 마커가 없다.")
        return False

    before = content.split(START_MARKER)[0]
    after = content.split(END_MARKER)[1]

    README_PATH.write_text(
        f"{before}{START_MARKER}\n\n{table_text}\n\n{END_MARKER}{after}",
        encoding="utf-8",
    )
    return True


def main():
    solo, batched, skipped = collect_solutions()

    for path in skipped:
        print(f"[skip] 인식 가능한 헤더 없음: {path}")

    if update_readme(build_table(solo, batched)):
        print(f"[ok] 개별 {len(solo)}개 + 묶음 {len(batched)}개로 README 갱신 완료")
    else:
        sys.exit(1)


if __name__ == "__main__":
    main()
