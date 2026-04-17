#!/usr/bin/env bash
#
# changelog.sh — 마지막 릴리즈 이후의 커밋을 읽어 CHANGELOG.md [Unreleased] 섹션에 자동 반영
#
# 기준:
#   - 마지막 `chore: release v*` 커밋부터 HEAD 까지의 커밋을 스캔
#   - feat:  → Added
#   - fix:   → Fixed
#   - perf:  → Changed
#   - BREAKING CHANGE: 포함 → Changed 섹션에 ⚠️ 표시
#   - 그 외(chore/docs/test/refactor/style) → 무시
#
# 사용법:
#   ./scripts/changelog.sh              # dry-run: 생성될 내용만 출력
#   ./scripts/changelog.sh --write      # CHANGELOG.md [Unreleased] 섹션 업데이트
#
# 주의:
#   이미 CHANGELOG.md [Unreleased] 섹션에 수기로 정리한 내용이 있다면
#   --write 는 **덮어쓰지 않고** 기존 항목 아래에 누락분만 추가한다.

set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

MODE="dry"
SINCE_SHA=""
for arg in "$@"; do
  if [[ "$arg" == "--write" ]]; then MODE="write"
  elif [[ "$arg" == --since=* ]]; then SINCE_SHA="${arg#--since=}"
  fi
done

# 마지막 릴리즈 커밋 찾기
if [[ -n "$SINCE_SHA" ]]; then
  LAST_RELEASE_SHA="$SINCE_SHA"
  echo "ℹ️  기준 커밋 (--since): $LAST_RELEASE_SHA"
else
  LAST_RELEASE_SHA="$(git log --grep='^chore: release v' -n 1 --format='%H' || true)"
fi

if [[ -z "$LAST_RELEASE_SHA" ]]; then
  echo "❌ 기준 커밋을 찾을 수 없습니다."
  echo "   --since=<SHA> 옵션으로 기준 커밋을 직접 지정하거나,"
  echo "   'chore: release v*' 형식의 릴리즈 커밋이 히스토리에 있어야 합니다."
  exit 1
fi

RANGE_ARG="${LAST_RELEASE_SHA}..HEAD"
echo "ℹ️  기준 커밋: $LAST_RELEASE_SHA"

# 커밋 메시지 수집
COMMITS="$(git log ${RANGE_ARG} --format='%H%x09%s%x09%b%x1e' --no-merges || true)"

if [[ -z "$COMMITS" ]]; then
  echo "📭 수집할 커밋이 없습니다."
  exit 0
fi

python3 - "$MODE" <<PY
import re, sys, pathlib, subprocess, os

mode = sys.argv[1]

raw = subprocess.check_output(
    ["git", "log", *(["${RANGE_ARG}"] if "${RANGE_ARG}" else []),
     "--format=%H%x09%s%x09%b%x1e", "--no-merges"],
    text=True,
)
entries = [e for e in raw.split("\x1e") if e.strip()]

added, changed, fixed = [], [], []
breaking = []

for e in entries:
    parts = e.strip().split("\t", 2)
    if len(parts) < 2:
        continue
    sha, subject = parts[0], parts[1]
    body = parts[2] if len(parts) > 2 else ""
    short = sha[:7]

    is_breaking = "BREAKING CHANGE" in body or re.match(r'^\w+(\([^)]*\))?!:', subject)

    m = re.match(r'^(feat|fix|perf|refactor|chore|docs|test|style)(\([^)]*\))?!?:\s*(.+)$', subject)
    if not m:
        continue
    kind, scope, desc = m.group(1), m.group(2) or "", m.group(3).strip()
    line = f"- {desc}" + (f" _{scope}_" if scope else "") + f" ({short})"
    if is_breaking:
        breaking.append("- ⚠️ " + desc + f" ({short})")
        continue
    if kind == "feat":
        added.append(line)
    elif kind == "fix":
        fixed.append(line)
    elif kind == "perf":
        changed.append(line)

def render(section_title, items):
    if not items:
        return ""
    return f"### {section_title}\n" + "\n".join(items) + "\n\n"

generated = (
    render("Added", added)
    + render("Changed", breaking + changed)
    + render("Fixed", fixed)
)

if not generated.strip():
    print("📭 CHANGELOG 에 반영할 feat/fix/perf 커밋이 없습니다.")
    sys.exit(0)

print("\n── 생성될 내용 ──\n")
print(generated)

if mode != "write":
    print("\n(dry-run: 적용하려면 --write 옵션 사용)")
    sys.exit(0)

# CHANGELOG.md 의 [Unreleased] 섹션을 찾아 비어있는 부분에 덧붙인다
clog_path = pathlib.Path("CHANGELOG.md")
text = clog_path.read_text()

# [Unreleased] 섹션 범위 찾기
m = re.search(r'^(##\s*\[Unreleased\]\s*$)', text, re.MULTILINE)
if not m:
    sys.exit("❌ CHANGELOG.md 에서 [Unreleased] 섹션을 찾지 못했습니다.")
start = m.end()
nxt = re.search(r'^##\s*\[', text[start:], re.MULTILINE)
end = start + (nxt.start() if nxt else len(text) - start)
original_block = text[start:end]

# 기존 블록에서 '- ' 빈 아이템('-' 만 있는 줄)은 지우고, 실제 항목은 유지
def merge_section(name, new_items):
    # 기존 ### name 블록 뽑기
    pat = re.compile(
        rf'(###\s+{name}\s*\n)(.*?)(?=(\n###\s+|\n---|\Z))',
        re.DOTALL,
    )
    mm = pat.search(original_block)
    existing = ""
    if mm:
        existing_body = mm.group(2)
        kept = [ln for ln in existing_body.splitlines()
                if ln.strip() and ln.strip() != '-']
        existing = "\n".join(kept)
    parts = []
    if existing:
        parts.append(existing)
    if new_items:
        # 중복 회피 (같은 설명이 이미 있으면 제외)
        for item in new_items:
            if item not in existing:
                parts.append(item)
    body = "\n".join(parts).strip()
    if not body:
        return ""
    return f"### {name}\n{body}\n\n"

new_block = (
    "\n"
    + merge_section("Added", added)
    + merge_section("Changed", breaking + changed)
    + merge_section("Fixed", fixed)
)

new_text = text[:start] + "\n" + new_block.lstrip("\n") + text[end:]
clog_path.write_text(new_text)
print("✅ CHANGELOG.md [Unreleased] 섹션 업데이트 완료")
PY
