#!/bin/bash

# GPG를 사용하여 암호화된 파일들을 복호화하는 스크립트
# GitHub Actions에서 사용됨

set -e

if [ -z "$CERT_ENCRYPT_PASSPHRASE" ]; then
    echo "❌ ERROR: CERT_ENCRYPT_PASSPHRASE 환경 변수가 설정되지 않았습니다."
    exit 1
fi

SECRETS_DIR=".github/secrets"

echo "🔓 민감한 파일 복호화 중..."

# 복호화 함수
decrypt_file() {
    local encrypted="$1"
    local decrypted="$2"

    if [ -f "$encrypted" ]; then
        echo "✓ $encrypted → $decrypted"

        # 출력 디렉토리 생성
        mkdir -p "$(dirname "$decrypted")"

        # 복호화
        gpg --quiet --batch --yes \
            --decrypt --passphrase "$CERT_ENCRYPT_PASSPHRASE" \
            --output "$decrypted" "$encrypted"

        echo "  ✓ 복호화 완료"
    else
        echo "⚠ $encrypted 파일을 찾을 수 없습니다. 건너뜁니다."
    fi
}

# 각 파일 복호화
decrypt_file "$SECRETS_DIR/env.gpg" ".env"
decrypt_file "$SECRETS_DIR/google-services-android-dev.json.gpg" "android/app/src/dev/google-services.json"
decrypt_file "$SECRETS_DIR/google-services-android-prod.json.gpg" "android/app/src/prod/google-services.json"
decrypt_file "$SECRETS_DIR/GoogleService-Info-dev.plist.gpg" "ios/Runner/GoogleService-Info-dev.plist"
decrypt_file "$SECRETS_DIR/GoogleService-Info-prod.plist.gpg" "ios/Runner/GoogleService-Info-prod.plist"
decrypt_file "$SECRETS_DIR/AuthKey.p8.gpg" "ios/AuthKey.p8"
decrypt_file "$SECRETS_DIR/Secret.xcconfig.gpg" "ios/Flutter/Secret.xcconfig"
decrypt_file "$SECRETS_DIR/strings.xml.gpg" "android/app/src/main/res/values/strings.xml"

echo ""
echo "✅ 모든 파일 복호화 완료!"
