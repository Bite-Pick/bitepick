#!/bin/bash

# GPG를 사용하여 민감한 파일들을 암호화하는 스크립트
# 사용법: ./encrypt-secrets.sh

set -e

echo "🔐 민감한 파일 암호화 스크립트"
echo "================================"
echo ""

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SECRETS_DIR=".github/secrets"

# secrets 디렉토리 생성
mkdir -p "$SECRETS_DIR"

echo "암호화 비밀번호를 입력하세요 (모든 파일에 동일한 비밀번호 사용):"
read -s PASSPHRASE
echo ""

# 암호화 함수
encrypt_file() {
    local source="$1"
    local target="$2"

    if [ -f "$source" ]; then
        echo -e "${GREEN}✓ $source 암호화 중...${NC}"
        gpg --batch --yes --passphrase "$PASSPHRASE" \
            --symmetric --cipher-algo AES256 \
            --output "$target" "$source"
        echo -e "${GREEN}  → $target 생성 완료${NC}"
    else
        echo -e "${YELLOW}⚠ $source 파일을 찾을 수 없습니다. 건너뜁니다.${NC}"
    fi
}

# 각 파일 암호화
encrypt_file ".env" "$SECRETS_DIR/env.gpg"
encrypt_file "android/app/src/dev/res/google-services.json" "$SECRETS_DIR/google-services-android-dev.json.gpg"
encrypt_file "android/app/src/prod/res/google-services.json" "$SECRETS_DIR/google-services-android-prod.json.gpg"
encrypt_file "ios/Runner/GoogleService-Info-dev.plist" "$SECRETS_DIR/GoogleService-Info-dev.plist.gpg"
encrypt_file "ios/Runner/GoogleService-Info-prod.plist" "$SECRETS_DIR/GoogleService-Info-prod.plist.gpg"

echo ""
echo -e "${GREEN}✅ 암호화 완료!${NC}"
echo ""
echo "GitHub Secrets에 다음 환경 변수를 추가하세요:"
echo "  CERT_ENCRYPT_PASSPHRASE=<방금 입력한 비밀번호>"
echo ""
echo "암호화된 파일들을 Git에 커밋하세요:"
echo "  git add .github/secrets/*.gpg"
echo "  git commit -m \"Add encrypted secrets\""
