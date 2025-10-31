# GitHub Actions에서 .gitignore 파일 처리 가이드

## 개요

`.env`, `google-services.json`, `GoogleService-Info.plist` 등 보안상 .gitignore에 추가된 파일들을 GitHub Actions에서 사용하는 방법입니다.

## 방법 1: 파일 내용을 Base64로 인코딩하여 Secrets에 저장 (권장)

### 장점
- 파일 형식 그대로 보존
- 멀티라인, 특수문자 문제 없음
- 바이너리 파일도 가능

### 단계

#### 1. 로컬에서 파일을 Base64로 인코딩

```bash
# .env 파일
cat .env | base64 > .env.base64

# Android google-services.json
cat android/app/google-services.json | base64 > google-services-android.base64

# iOS GoogleService-Info.plist
cat ios/Runner/GoogleService-Info.plist | base64 > GoogleService-Info.base64

# Firebase App Distribution JSON (있는 경우)
cat firebase-app-distribution-key.json | base64 > firebase-key.base64
```

**macOS 사용자 주의:**
macOS의 base64는 자동 줄바꿈이 추가됩니다. 제거하려면:
```bash
cat .env | base64 | tr -d '\n' > .env.base64
```

#### 2. GitHub Secrets에 등록

Repository > Settings > Secrets and variables > Actions > New repository secret

```
Name: ENV_FILE_BASE64
Secret: <.env.base64 파일 내용>

Name: GOOGLE_SERVICES_ANDROID_BASE64
Secret: <google-services-android.base64 파일 내용>

Name: GOOGLE_SERVICES_IOS_BASE64
Secret: <GoogleService-Info.base64 파일 내용>
```

#### 3. GitHub Actions Workflow에서 디코딩

```yaml
- name: Create .env file
  run: |
    echo "${{ secrets.ENV_FILE_BASE64 }}" | base64 --decode > .env
    cat .env  # 확인용 (민감한 정보 제외하고 출력)

- name: Create google-services.json (Android)
  run: |
    echo "${{ secrets.GOOGLE_SERVICES_ANDROID_BASE64 }}" | base64 --decode > android/app/google-services.json

- name: Create GoogleService-Info.plist (iOS)
  run: |
    echo "${{ secrets.GOOGLE_SERVICES_IOS_BASE64 }}" | base64 --decode > ios/Runner/GoogleService-Info.plist
```

## 방법 2: 환경 변수로 직접 주입 (.env의 경우)

### 장점
- 파일 생성 불필요
- 환경별 분기 쉬움

### 단계

#### 1. GitHub Secrets에 각 변수 등록

```
DEV_API_URL=https://dev.mgbell-server.run
API_URL=https://www.mgbell-server.run
X_NCP_APIGW_API_KEY_ID=sasocp6pb7
...등등
```

#### 2. Workflow에서 .env 파일 생성

```yaml
- name: Create .env file from secrets
  run: |
    cat << EOF > .env
    DEV_API_URL=${{ secrets.DEV_API_URL }}
    API_URL=${{ secrets.API_URL }}
    API_PREFIX=/api/v1

    NAVER_OAUTH=${{ secrets.NAVER_OAUTH }}
    KAKAO_OAUTH=${{ secrets.KAKAO_OAUTH }}
    GOOGLE_OAUTH=${{ secrets.GOOGLE_OAUTH }}

    GEOCODING_API_URL=${{ secrets.GEOCODING_API_URL }}
    REVERSE_GEOCODING_API_URL=${{ secrets.REVERSE_GEOCODING_API_URL }}

    X_NCP_APIGW_API_KEY_ID=${{ secrets.X_NCP_APIGW_API_KEY_ID }}
    X_NCP_APIGW_API_KEY=${{ secrets.X_NCP_APIGW_API_KEY }}

    NAVER_CLIENT_ID=${{ secrets.NAVER_CLIENT_ID }}
    NAVER_CONSUMER_ID=${{ secrets.NAVER_CONSUMER_ID }}
    NAVER_CONSUMER_SECRET=${{ secrets.NAVER_CONSUMER_SECRET }}
    NAVER_APP_NAME=${{ secrets.NAVER_APP_NAME }}
    SERVICE_URL_SCHEME=${{ secrets.SERVICE_URL_SCHEME }}

    PORTONE_STORE_ID=${{ secrets.PORTONE_STORE_ID }}
    PORTONE_TEST_CHANNEL_KEY=${{ secrets.PORTONE_TEST_CHANNEL_KEY }}
    PORTONE_CHANNEL_KEY=${{ secrets.PORTONE_CHANNEL_KEY }}
    EOF
```

## 방법 3: Flavor별 파일 분리 (권장 - 복잡한 프로젝트)

### 구조

```
.env.dev        # Dev용 환경 변수
.env.prod       # Prod용 환경 변수
android/app/src/dev/google-services.json
android/app/src/prod/google-services.json
ios/Runner/dev/GoogleService-Info.plist
ios/Runner/prod/GoogleService-Info.plist
```

### GitHub Secrets

```
ENV_FILE_DEV_BASE64
ENV_FILE_PROD_BASE64
GOOGLE_SERVICES_ANDROID_DEV_BASE64
GOOGLE_SERVICES_ANDROID_PROD_BASE64
GOOGLE_SERVICES_IOS_DEV_BASE64
GOOGLE_SERVICES_IOS_PROD_BASE64
```

### Workflow

```yaml
- name: Setup environment files
  run: |
    if [ "${{ env.MODE }}" == "dev" ]; then
      echo "${{ secrets.ENV_FILE_DEV_BASE64 }}" | base64 --decode > .env
      echo "${{ secrets.GOOGLE_SERVICES_ANDROID_DEV_BASE64 }}" | base64 --decode > android/app/src/dev/google-services.json
      echo "${{ secrets.GOOGLE_SERVICES_IOS_DEV_BASE64 }}" | base64 --decode > ios/Runner/dev/GoogleService-Info.plist
    else
      echo "${{ secrets.ENV_FILE_PROD_BASE64 }}" | base64 --decode > .env
      echo "${{ secrets.GOOGLE_SERVICES_ANDROID_PROD_BASE64 }}" | base64 --decode > android/app/src/prod/google-services.json
      echo "${{ secrets.GOOGLE_SERVICES_IOS_PROD_BASE64 }}" | base64 --decode > ios/Runner/prod/GoogleService-Info.plist
    fi
```

## 완전한 Workflow 예시

```yaml
name: Deploy

on:
  workflow_dispatch:
    inputs:
      mode:
        type: choice
        options:
          - dev
          - prod

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.29.0'

      - name: Create environment files
        env:
          MODE: ${{ github.event.inputs.mode }}
        run: |
          # .env 파일 생성
          echo "${{ secrets.ENV_FILE_BASE64 }}" | base64 --decode > .env

          # Android google-services.json
          if [ "$MODE" == "dev" ]; then
            echo "${{ secrets.GOOGLE_SERVICES_ANDROID_DEV_BASE64 }}" | base64 --decode > android/app/google-services.json
          else
            echo "${{ secrets.GOOGLE_SERVICES_ANDROID_BASE64 }}" | base64 --decode > android/app/google-services.json
          fi

          # iOS GoogleService-Info.plist
          if [ "$MODE" == "dev" ]; then
            echo "${{ secrets.GOOGLE_SERVICES_IOS_DEV_BASE64 }}" | base64 --decode > ios/Runner/GoogleService-Info.plist
          else
            echo "${{ secrets.GOOGLE_SERVICES_IOS_BASE64 }}" | base64 --decode > ios/Runner/GoogleService-Info.plist
          fi

          # 파일 존재 확인
          ls -la .env android/app/google-services.json ios/Runner/GoogleService-Info.plist

      - name: Flutter pub get
        run: flutter pub get

      - name: Build
        run: flutter build apk --release --flavor=${{ github.event.inputs.mode }}
```

## 보안 체크리스트

### ✅ 해야 할 것
- [ ] 민감한 파일을 .gitignore에 추가
- [ ] Base64 인코딩된 파일은 GitHub Secrets에만 저장
- [ ] Workflow 로그에서 민감한 정보 출력 방지
- [ ] 정기적으로 API 키 로테이션

### ❌ 하지 말아야 할 것
- [ ] 민감한 파일을 절대 Git에 커밋하지 말 것
- [ ] Workflow에서 `cat .env` 등으로 전체 내용 출력하지 말 것
- [ ] Public repository에 Secrets 노출하지 말 것

## .gitignore 예시

```gitignore
# Environment files
.env
.env.local
.env.dev
.env.prod
*.env

# Firebase
google-services.json
GoogleService-Info.plist
firebase-app-distribution-key.json
firebase-adminsdk-*.json

# iOS Signing
*.p8
*.p12
*.mobileprovision
*.certSigningRequest

# Base64 encoded files (로컬 테스트용)
*.base64
```

## 문제 해결

### Base64 디코딩 실패
```bash
# macOS에서 줄바꿈 제거
cat file | base64 | tr -d '\n'

# Linux에서 줄바꿈 없이 인코딩
cat file | base64 -w 0
```

### 파일 생성 후 권한 문제
```yaml
- name: Fix permissions
  run: |
    chmod 644 .env
    chmod 644 android/app/google-services.json
    chmod 644 ios/Runner/GoogleService-Info.plist
```

### Workflow에서 파일 확인
```yaml
- name: Verify files
  run: |
    echo "Checking .env..."
    [ -f .env ] && echo "✓ .env exists" || echo "✗ .env missing"

    echo "Checking google-services.json..."
    [ -f android/app/google-services.json ] && echo "✓ google-services.json exists" || echo "✗ google-services.json missing"

    echo "Checking GoogleService-Info.plist..."
    [ -f ios/Runner/GoogleService-Info.plist ] && echo "✓ GoogleService-Info.plist exists" || echo "✓ GoogleService-Info.plist missing"
```

## 참고 자료

- [GitHub Encrypted Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Flutter Environment Variables](https://flutter.dev/docs/development/ui/env-variables)
- [Base64 Encoding/Decoding](https://linux.die.net/man/1/base64)
