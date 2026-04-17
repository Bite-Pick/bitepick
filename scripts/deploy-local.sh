#!/usr/bin/env bash
#
# deploy-local.sh — 로컬 머신에서 직접 Shorebird + Fastlane 실행
# (GitHub Actions 크레딧 아끼고 싶을 때 쓴다)
#
# 이 스크립트는 `./scripts/release.sh` 로 pubspec/CHANGELOG/태그가 이미 갱신된 뒤,
# **태그를 push 하지 않고** 로컬에서 빌드&배포할 때 쓰는 경로다.
# Shorebird 패치(네이티브 변경 없는 Dart-only 핫픽스)도 같은 스크립트로 가능.
#
# 사용법:
#   ./scripts/deploy-local.sh release                     # Android + iOS 정식 릴리즈
#   ./scripts/deploy-local.sh release-android             # Android만
#   ./scripts/deploy-local.sh release-ios                 # iOS만
#   ./scripts/deploy-local.sh patch                       # Android + iOS Shorebird 패치
#   ./scripts/deploy-local.sh patch-android               # Android 패치만
#   ./scripts/deploy-local.sh patch-ios                   # iOS 패치만
#
# 옵션:
#   --flavor prod|dev      (기본 prod)
#   --no-store-upload      Fastlane의 스토어 업로드 lane을 스킵 (Shorebird release만 수행)
#   --build-number N       명시적으로 빌드번호 지정 (기본은 build_numbers.json 최댓값 +1)
#
# 선행 조건:
#   - shorebird CLI 로그인됨 (shorebird login)
#   - android/ 와 ios/ 에 bundle install 완료
#   - .env / 키스토어 / match 등 로컬 시크릿 준비됨

set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

# ---------- 인자 파싱 ----------
TARGET=""
FLAVOR="prod"
SKIP_STORE_UPLOAD=false
OVERRIDE_BUILD=""

print_usage() {
  sed -n '3,30p' "$0" | sed 's/^# \{0,1\}//'
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    release|release-android|release-ios|patch|patch-android|patch-ios)
      TARGET="$1"; shift ;;
    --flavor) FLAVOR="$2"; shift 2 ;;
    --flavor=*) FLAVOR="${1#*=}"; shift ;;
    --no-store-upload) SKIP_STORE_UPLOAD=true; shift ;;
    --build-number) OVERRIDE_BUILD="$2"; shift 2 ;;
    --build-number=*) OVERRIDE_BUILD="${1#*=}"; shift ;;
    -h|--help) print_usage; exit 0 ;;
    *) echo "알 수 없는 인자: $1"; print_usage; exit 1 ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  print_usage
  exit 1
fi

if [[ "$FLAVOR" != "prod" && "$FLAVOR" != "dev" ]]; then
  echo "❌ --flavor 는 prod 또는 dev 만 허용"; exit 1
fi

IS_PATCH="false"
[[ "$TARGET" == patch* ]] && IS_PATCH="true"

# ---------- 버전 / 빌드번호 ----------
VERSION_FULL="$(grep -E '^version:' pubspec.yaml | head -1 | sed -E 's/^version:[[:space:]]*//')"
VERSION="${VERSION_FULL%%+*}"
EXISTING_BUILD=""
[[ "$VERSION_FULL" == *+* ]] && EXISTING_BUILD="${VERSION_FULL#*+}"

if [[ -n "$OVERRIDE_BUILD" ]]; then
  BUILD_NUMBER="$OVERRIDE_BUILD"
elif [[ "$IS_PATCH" == "true" ]] && [[ -f build_numbers.json ]]; then
  # 패치는 원본 릴리즈의 빌드번호를 재사용한다
  BUILD_NUMBER="$(python3 -c "
import json, sys
d = json.load(open('build_numbers.json'))
v = '$VERSION'
print(d.get(v, d.get(max(d, key=lambda k: d[k]), 0)))
")"
  if [[ -z "$BUILD_NUMBER" || "$BUILD_NUMBER" == "0" ]]; then
    echo "❌ 패치의 원본 빌드번호를 찾지 못했습니다. --build-number 로 직접 지정하세요."
    exit 1
  fi
elif [[ -f build_numbers.json ]]; then
  # 정식 릴리즈: 기존 최댓값 +1
  BUILD_NUMBER="$(python3 -c "
import json
d = json.load(open('build_numbers.json'))
print(max(d.values()) + 1 if d else 1)
")"
else
  BUILD_NUMBER=$((${EXISTING_BUILD:-0} + 1))
fi

echo "──────────────────────────────────────────────"
echo " Target         : $TARGET"
echo " Flavor         : $FLAVOR"
echo " Version        : $VERSION"
echo " Build number   : $BUILD_NUMBER"
echo " Patch          : $IS_PATCH"
echo " Skip store up. : $SKIP_STORE_UPLOAD"
echo "──────────────────────────────────────────────"
read -r -p "진행할까요? [y/N] " ans
[[ "$ans" =~ ^[yY]$ ]] || { echo "취소됨."; exit 1; }

# ---------- 환경변수 ----------
# Fastlane lane들이 기대하는 이름으로 export (GH Actions deploy.yml 과 동일)
export VERSION_NUMBER="$VERSION"
export BUILD_NUMBER="$BUILD_NUMBER"
export PATCH_BUILD_NUMBER="$BUILD_NUMBER"
export MODE="$FLAVOR"
export FLAVOR="$FLAVOR"

# 사전 체크
if ! command -v shorebird >/dev/null 2>&1; then
  echo "❌ shorebird CLI 가 설치되어 있지 않습니다. https://shorebird.dev"; exit 1
fi

# ---------- lane 실행 ----------
run_lane() {
  local platform="$1" lane="$2"
  echo ""
  echo "─── $platform : fastlane $lane ($FLAVOR) ───"
  (cd "$platform" && bundle exec fastlane "$lane")
}

# 패치/릴리즈 선택
if [[ "$IS_PATCH" == "true" ]]; then
  LANE="patch"
else
  LANE="release"
fi

case "$TARGET" in
  release|patch)
    run_lane android "$LANE"
    run_lane ios "$LANE"
    ;;
  release-android|patch-android)
    run_lane android "$LANE"
    ;;
  release-ios|patch-ios)
    run_lane ios "$LANE"
    ;;
esac

# 스토어 업로드 (Android만 별도 lane으로 분리되어 있음 — internal)
if [[ "$IS_PATCH" == "false" && "$SKIP_STORE_UPLOAD" == "false" ]]; then
  if [[ "$TARGET" == "release" || "$TARGET" == "release-android" ]] && [[ "$FLAVOR" == "prod" ]]; then
    echo ""
    echo "─── android : fastlane internal (Play Store 업로드) ───"
    (cd android && bundle exec fastlane internal) || {
      echo "⚠️  Play Store 업로드 lane이 정의되어 있지 않거나 실패했습니다. 수동으로 올려주세요."
    }
  fi
fi

# ---------- build_numbers.json 갱신 (정식 릴리즈 때만) ----------
if [[ "$IS_PATCH" == "false" ]]; then
  python3 <<PY
import json, pathlib
p = pathlib.Path("build_numbers.json")
d = json.loads(p.read_text()) if p.exists() else {}
d["$VERSION"] = int("$BUILD_NUMBER")
p.write_text(json.dumps(d, indent=2, ensure_ascii=False) + "\n")
PY
  if ! git diff --quiet build_numbers.json; then
    git add build_numbers.json
    git commit -m "chore: update build number for $VERSION [local] [skip ci]" >/dev/null
    echo "✅ build_numbers.json 갱신 및 커밋"
  fi
fi

echo ""
echo "🎉 로컬 배포 완료"
echo ""
echo "다음 단계:"
if [[ "$IS_PATCH" == "false" ]]; then
  echo "  - Play Console / App Store Connect 검수 상태 확인"
  echo "  - release_notes/${VERSION}.ko.txt 의 내용을 스토어 한국어 공지로 복붙"
  echo "  - git push origin main  (커밋 반영)"
else
  echo "  - Shorebird 콘솔에서 패치 rollout 상태 확인"
  echo "  - git push origin main  (코드 변경분 반영)"
fi
