# iOS 배포 환경 변수 설정 가이드

## 필수 환경 변수

### App Store Connect API
```bash
# API Key ID (예: ABC123DEFG)
APP_STORE_CONNECT_API_KEY_ID=your_key_id

# Issuer ID (예: 12345678-1234-1234-1234-123456789012)
APP_STORE_CONNECT_API_KEY_ISSUER_ID=your_issuer_id

# API Key 파일 내용 (.p8 파일의 전체 내용)
APP_STORE_CONNECT_API_KEY_CONTENT=-----BEGIN PRIVATE KEY-----
MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQg...
-----END PRIVATE KEY-----
```

### Match (코드 서명)
```bash
# Match 저장소 암호화 비밀번호
MATCH_PASSWORD=your_secure_password

# GitHub Personal Access Token (repo 권한)
MATCH_GIT_BASIC_AUTHORIZATION=ghp_xxxxxxxxxxxxxxxxxxxx

# 또는 Git URL (선택사항)
# MATCH_GIT_URL=https://token@github.com/org/ios-certificates
```

### Build 설정
```bash
# 빌드 모드 (dev 또는 prod)
MODE=dev

# Flutter 버전
FLUTTER_VERSION=3.29.0

# 앱 버전
VERSION=v1.0.3-dev

# 빌드 번호
BUILD_NUMBER=5

# 패치 빌드 번호 (patch용)
PATCH_BUILD_NUMBER=1
```

## 선택 환경 변수

### Firebase App Distribution
```bash
# Firebase 앱 ID - Android Dev
FIREBASE_APP_ID_ANDROID_DEV=1:123456789:android:dev123456

# Firebase 앱 ID - Android Prod
FIREBASE_APP_ID_ANDROID=1:123456789:android:prod123456

# Firebase 앱 ID - iOS Dev
FIREBASE_APP_ID_IOS_DEV=1:123456789:ios:dev123456

# Firebase 앱 ID - iOS Prod
FIREBASE_APP_ID_IOS=1:123456789:ios:prod123456

# Service Account JSON (전체 내용)
GOOGLE_APPLICATION_CREDENTIALS={
  "type": "service_account",
  "project_id": "your-project",
  ...
}
```

**Flavor별 Firebase App ID 매핑:**
- Dev 모드 (MODE=dev)
  - Android: `FIREBASE_APP_ID_ANDROID_DEV`
  - iOS: `FIREBASE_APP_ID_IOS_DEV`
- Prod 모드 (MODE=prod)
  - Android: `FIREBASE_APP_ID_ANDROID`
  - iOS: `FIREBASE_APP_ID_IOS`

### TestFlight (선택사항)
```bash
# Apple ID (앱의 Apple ID, 숫자)
APPLE_ID=1234567890
```

### Slack 알림 (선택사항)
```bash
# Slack Webhook URL
SLACK_URL=https://hooks.slack.com/services/xxx/yyy/zzz
```

## GitHub Secrets 설정 방법

1. GitHub Repository 페이지 이동
2. **Settings** > **Secrets and variables** > **Actions**
3. **New repository secret** 클릭
4. Name과 Secret 입력
5. **Add secret** 클릭

## 주의사항

⚠️ **절대 코드에 직접 입력하지 마세요!**
- API 키, 토큰, 비밀번호는 반드시 GitHub Secrets 사용
- .env 파일은 .gitignore에 추가
- 실수로 커밋한 경우 즉시 키 재발급

⚠️ **키 보안**
- Personal Access Token: 정기적으로 갱신
- Match Password: 안전한 곳에 백업
- API Key: 필요한 최소 권한만 부여

⚠️ **백업**
- Match 저장소는 private으로 유지
- Match 암호 분실 시 인증서 재생성 필요
- API Key .p8 파일은 한 번만 다운로드 가능
