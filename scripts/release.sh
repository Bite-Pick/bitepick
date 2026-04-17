#!/usr/bin/env bash
#
# release.sh — BitePick 릴리즈 자동화
#
# 하는 일:
#   1) pubspec.yaml의 version 필드를 올린다 (빌드번호는 CI가 채우므로 유지)
#   2) CHANGELOG.md의 [Unreleased] 섹션을 [X.Y.Z] - YYYY-MM-DD 로 승격
#   3) 새 [Unreleased] 빈 섹션을 상단에 다시 만든다
#   4) CHANGELOG 하단의 비교 링크 갱신
#   5) release_notes/{version}.ko.txt 스토어 공지 스켈레톤 생성 (이미 있으면 skip)
#   6) `chore: release v{version}` 커밋 생성 (위 파일들 포함)
#   7) `v{version}` 태그 생성 (annotated tag)
#
# 사용법:
#   ./scripts/release.sh patch        # 1.20.2 -> 1.20.3
#   ./scripts/release.sh minor        # 1.20.2 -> 1.21.0
#   ./scripts/release.sh major        # 1.20.2 -> 2.0.0
#   ./scripts/release.sh 1.21.5       # 특정 버전 직접 지정
#
# 푸시는 수동:
#   git push origin main
#   git push origin v{version}              # 전체 배포
#   git push origin v{version}-prod         # prod만
#   git push origin v{version}-dev-android  # dev × Android만
#
# Shorebird patch(네이티브 변경 없는 Dart-only 핫픽스)는 버전을 올리지 않는다.
# 직접 태그만 생성:   git tag v{현재버전}-prod-patch1

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

# ---------- 인자 파싱 ----------
if [[ $# -ne 1 ]]; then
  echo "사용법: $0 {patch|minor|major|X.Y.Z}"
  exit 1
fi
BUMP="$1"

# ---------- 사전 체크 ----------
if ! git diff --quiet || ! git diff --staged --quiet; then
  echo "❌ 작업 트리에 커밋되지 않은 변경이 있습니다. 먼저 커밋/스태시 하세요."
  git status --short
  exit 1
fi

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$BRANCH" != "main" ]]; then
  echo "⚠️  현재 브랜치가 '$BRANCH' 입니다. main에서만 릴리즈하는 것을 권장합니다."
  read -r -p "그래도 진행할까요? [y/N] " ans
  [[ "$ans" == "y" || "$ans" == "Y" ]] || exit 1
fi

PUBSPEC="pubspec.yaml"
CHANGELOG="CHANGELOG.md"

if [[ ! -f "$PUBSPEC" ]]; then echo "❌ $PUBSPEC 가 없습니다."; exit 1; fi
if [[ ! -f "$CHANGELOG" ]]; then echo "❌ $CHANGELOG 가 없습니다."; exit 1; fi

# ---------- 현재 버전 읽기 ----------
# pubspec.yaml 의 'version: X.Y.Z+B' 에서 X.Y.Z 만 추출
CURRENT_LINE="$(grep -E '^version:' "$PUBSPEC" | head -n1)"
CURRENT_FULL="$(echo "$CURRENT_LINE" | sed -E 's/^version:[[:space:]]*//')"
CURRENT_VERSION="${CURRENT_FULL%%+*}"
CURRENT_BUILD=""
if [[ "$CURRENT_FULL" == *+* ]]; then
  CURRENT_BUILD="+${CURRENT_FULL#*+}"
fi

if ! [[ "$CURRENT_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "❌ 현재 버전을 파싱할 수 없습니다: '$CURRENT_FULL'"
  exit 1
fi

IFS='.' read -r MAJ MIN PAT <<< "$CURRENT_VERSION"

# ---------- 새 버전 계산 ----------
case "$BUMP" in
  patch) NEW_VERSION="${MAJ}.${MIN}.$((PAT+1))" ;;
  minor) NEW_VERSION="${MAJ}.$((MIN+1)).0" ;;
  major) NEW_VERSION="$((MAJ+1)).0.0" ;;
  *)
    if [[ "$BUMP" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
      NEW_VERSION="$BUMP"
    else
      echo "❌ 알 수 없는 인자: $BUMP (patch|minor|major|X.Y.Z)"
      exit 1
    fi
    ;;
esac

if [[ "$NEW_VERSION" == "$CURRENT_VERSION" ]]; then
  echo "❌ 새 버전이 현재 버전과 같습니다: $NEW_VERSION"
  exit 1
fi

TAG="v${NEW_VERSION}"
TODAY="$(date +%Y-%m-%d)"

if git rev-parse "$TAG" >/dev/null 2>&1; then
  echo "❌ 태그 $TAG 가 이미 존재합니다."
  exit 1
fi

CURRENT_BUILD_NUM="${CURRENT_BUILD#+}"
NEW_BUILD_NUM="$((CURRENT_BUILD_NUM + 1))"

echo "──────────────────────────────────────────────"
echo " 현재 버전 : $CURRENT_VERSION+${CURRENT_BUILD_NUM}"
echo " 새 버전   : $NEW_VERSION+${NEW_BUILD_NUM}"
echo " 태그      : $TAG"
echo " 날짜      : $TODAY"
echo "──────────────────────────────────────────────"
read -r -p "진행할까요? [y/N] " ans
[[ "$ans" == "y" || "$ans" == "Y" ]] || { echo "취소됨."; exit 1; }

# ---------- pubspec.yaml 업데이트 ----------
# 빌드번호(+N) 부분은 그대로 유지 (CI가 관리)
# macOS/BSD sed 호환을 위해 임시 파일 이용
python3 - "$PUBSPEC" "$CURRENT_VERSION" "$NEW_VERSION" <<'PY'
import sys, re, pathlib
path, cur, new = sys.argv[1], sys.argv[2], sys.argv[3]
p = pathlib.Path(path)
text = p.read_text()
# 'version: X.Y.Z' 또는 'version: X.Y.Z+B' 모두 커버. 버전 올리고 빌드번호도 +1.
def bump(m):
    build = int(m.group(2)[1:]) + 1 if m.group(2) else 1
    return f"{m.group(1)}{new}+{build}"
text2 = re.sub(
    r'^(version:\s*)' + re.escape(cur) + r'(\+\d+)?\s*$',
    bump,
    text,
    count=1,
    flags=re.MULTILINE,
)
if text2 == text:
    sys.exit("❌ pubspec.yaml 에서 version 라인을 찾지 못했습니다.")
p.write_text(text2)
PY

echo "✅ pubspec.yaml 업데이트 완료"

# ---------- CHANGELOG.md 업데이트 ----------
python3 - "$CHANGELOG" "$NEW_VERSION" "$TODAY" "$CURRENT_VERSION" <<'PY'
import sys, re, pathlib, datetime

path, new_ver, today, prev_ver = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
p = pathlib.Path(path)
text = p.read_text()

# 1) [Unreleased] 섹션을 [X.Y.Z] - YYYY-MM-DD 로 승격
pattern = re.compile(r'^##\s*\[Unreleased\]\s*$', re.MULTILINE)
if not pattern.search(text):
    sys.exit("❌ CHANGELOG.md 에서 [Unreleased] 섹션을 찾지 못했습니다.")

# 섹션 본문 추출 (다음 '## [' 까지)
idx = pattern.search(text).end()
next_section = re.search(r'^##\s*\[', text[idx:], re.MULTILINE)
if next_section:
    body_end = idx + next_section.start()
else:
    # 비교 링크 시작 전까지
    link_match = re.search(r'^\[Unreleased\]:', text[idx:], re.MULTILINE)
    body_end = idx + link_match.start() if link_match else len(text)

body = text[idx:body_end].strip('\n')

# 빈 섹션 감지: 내용이 Added/Changed/Fixed 헤더 + 빈 '-' 뿐이면 placeholder로 대체
def _strip_empty_subsections(b: str) -> str:
    # 각 '### X' 블록을 뽑아서, 내용이 '-' 또는 공백만이면 제거
    blocks = re.split(r'(?m)^(###\s+\S+.*)$', b)
    out, i = [], 0
    # blocks 구조: [prefix, header, body, header, body, ...]
    if blocks and blocks[0].strip():
        out.append(blocks[0])
    for h, bd in zip(blocks[1::2], blocks[2::2]):
        items = [ln for ln in bd.splitlines()
                 if ln.strip() and ln.strip() != '-']
        if items:
            out.append(h)
            out.append(bd)
    return '\n'.join(out).strip()

cleaned_body = _strip_empty_subsections(body)
if not cleaned_body:
    cleaned_body = "- 세부 변경 사항은 커밋 히스토리를 참고하세요."

# 2) 새 [Unreleased] 템플릿
unreleased_template = """## [Unreleased]

### Added
-

### Changed
-

### Fixed
-
"""

released_section = f"## [{new_ver}] - {today}\n\n{cleaned_body}\n"

# 기존 [Unreleased] + 본문을 대체
new_text = text[:pattern.search(text).start()] \
         + unreleased_template + "\n---\n\n" \
         + released_section + "\n---\n" \
         + text[body_end:]

# 링크 섹션 업데이트
# [Unreleased]: ...compare/vX.Y.Z...HEAD  →  새 버전으로 교체
new_text = re.sub(
    r'\[Unreleased\]:\s*(\S+?/compare/)v\S+\.\.\.HEAD',
    lambda m: f"[Unreleased]: {m.group(1)}v{new_ver}...HEAD",
    new_text,
)

# 새 버전 비교 링크 추가 (없으면)
if f"[{new_ver}]:" not in new_text:
    # compare URL base 추출
    m = re.search(r'\[Unreleased\]:\s*(\S+?)/compare/', new_text)
    if m:
        base = m.group(1)
        new_link = f"[{new_ver}]: {base}/compare/v{prev_ver}...v{new_ver}"
        # 기존 [Unreleased]: 라인 바로 아래에 삽입
        new_text = re.sub(
            r'(\[Unreleased\]:[^\n]+\n)',
            r'\1' + new_link + '\n',
            new_text,
            count=1,
        )

p.write_text(new_text)
PY

echo "✅ CHANGELOG.md 업데이트 완료"

# ---------- 스토어용 릴리즈 노트 스켈레톤 생성 ----------
# release_notes/{version}.ko.txt 를 CHANGELOG 항목 기반으로 뽑아준다.
# 사람이 "~해요" 체로 다듬는 건 수동. 이 파일도 같은 커밋에 포함된다.
STORE_NOTE_DIR="release_notes"
STORE_NOTE_FILE="${STORE_NOTE_DIR}/${NEW_VERSION}.ko.txt"

if [[ -f "$STORE_NOTE_FILE" ]]; then
  echo "ℹ️  ${STORE_NOTE_FILE} 가 이미 있어 스켈레톤을 덮어쓰지 않습니다."
else
  mkdir -p "$STORE_NOTE_DIR"
  python3 - "$CHANGELOG" "$NEW_VERSION" "$STORE_NOTE_FILE" <<'PY'
import sys, re, pathlib
clog, ver, out = sys.argv[1], sys.argv[2], sys.argv[3]
text = pathlib.Path(clog).read_text()
# 방금 승격된 [X.Y.Z] 섹션 추출
m = re.search(
    rf'^##\s*\[{re.escape(ver)}\][^\n]*\n(.*?)(?=^##\s*\[|\Z)',
    text, re.DOTALL | re.MULTILINE,
)
body = m.group(1) if m else ""

def pick(name):
    mm = re.search(
        rf'###\s+{name}\s*\n(.*?)(?=\n###\s+|\n---|\Z)',
        body, re.DOTALL,
    )
    if not mm:
        return []
    items = []
    for ln in mm.group(1).splitlines():
        s = ln.strip()
        if not s or s == '-' or s.startswith('_'):
            continue
        if s.startswith('- '):
            s = s[2:]
        items.append(s)
    return items

added   = pick("Added")
changed = pick("Changed")
fixed   = pick("Fixed")

def as_user_facing(line):
    # 기술적 표기 최소 정리. 다듬기는 사람이.
    return f"- {line}"

out_lines = []
if added:
    out_lines.append("[신규 기능]")
    out_lines.extend(as_user_facing(x) for x in added)
    out_lines.append("")
if fixed:
    out_lines.append("[버그 수정]")
    out_lines.extend(as_user_facing(x) for x in fixed)
    out_lines.append("")
if changed:
    out_lines.append("[기타]")
    out_lines.extend(as_user_facing(x) for x in changed)
    out_lines.append("")

header = (
    "# TODO: 아래 내용을 스토어 톤(~해요 체)으로 다듬은 뒤 이 주석 줄은 지우세요.\n"
    "# 500자 이내 (Play Store 제한). 내부 용어 제거. 사장님/손님 구분 필요 시 명시.\n\n"
)
pathlib.Path(out).write_text(header + "\n".join(out_lines).rstrip() + "\n")
print(f"✅ 스토어 릴리즈 노트 스켈레톤 생성: {out}")
PY
fi

# ---------- 커밋 & 태그 ----------
git add "$PUBSPEC" "$CHANGELOG"
# 스토어 노트 파일이 생성됐다면 같이 스테이징
if [[ -f "$STORE_NOTE_FILE" ]]; then
  git add "$STORE_NOTE_FILE"
fi
git commit -m "chore: release v${NEW_VERSION}"
git tag -a "$TAG" -m "Release v${NEW_VERSION}"

echo ""
echo "🎉 릴리즈 커밋과 태그 생성 완료"
echo ""
echo "다음 단계:"
echo "  git push origin main"
echo "  git push origin ${TAG}                  # 전체 (both flavor × both platform)"
echo "  git push origin ${TAG}-prod             # prod만"
echo "  git push origin ${TAG}-prod-android     # prod × Android만"
echo ""
echo "Shorebird 패치는 태그만 수동으로:"
echo "  git tag ${TAG}-prod-patch1 && git push origin ${TAG}-prod-patch1"
