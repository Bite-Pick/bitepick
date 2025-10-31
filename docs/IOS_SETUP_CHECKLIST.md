# iOS 배포 설정 체크리스트

## Phase 1: Apple Developer 설정

### 1.1 Apple Developer Program 가입
- [ ] Apple Developer Program 가입 완료 ($99/년)
- [ ] 결제 및 약관 동의 완료

### 1.2 App Store Connect API Key 생성
- [ ] [App Store Connect](https://appstoreconnect.apple.com) 로그인
- [ ] Users and Access > Keys > App Store Connect API
- [ ] "+" 버튼으로 새 API Key 생성
  - Name: `GitHub Actions iOS Deploy`
  - Access: `Developer` 선택
- [ ] API Key 다운로드 (.p8 파일) ⚠️ 한 번만 다운로드 가능!
- [ ] Key ID 복사 저장
- [ ] Issuer ID 복사 저장

## Phase 2: Match 저장소 설정

### 2.1 Private Git 저장소 생성
- [ ] GitHub에 private repository 생성
  - 이름: `ios-certificates` (또는 원하는 이름)
  - Private 설정 확인
- [ ] 저장소 URL 복사

### 2.2 Match 초기화 (로컬)
```bash
cd ios
bundle exec fastlane match init
# Git URL 입력: https://github.com/your-org/ios-certificates
```
- [ ] `ios/Matchfile` 생성 확인
- [ ] Matchfile에 git_url 설정 확인

### 2.3 인증서 생성
```bash
# Development 인증서 (선택사항)
bundle exec fastlane match development

# App Store 인증서 (필수)
bundle exec fastlane match appstore
```
- [ ] Apple ID 로그인
- [ ] Match 암호 설정 및 안전한 곳에 저장
- [ ] 인증서 생성 완료 메시지 확인
- [ ] Git 저장소에 파일 푸시 확인

## Phase 3: GitHub Secrets 설정

### 3.1 GitHub Personal Access Token 생성
- [ ] GitHub Settings > Developer settings > Personal access tokens
- [ ] Generate new token (classic)
- [ ] Scopes: `repo` 전체 체크
- [ ] 토큰 복사 저장 ⚠️ 다시 볼 수 없음!

### 3.2 GitHub Repository Secrets 추가
Repository > Settings > Secrets and variables > Actions

**App Store Connect API:**
- [ ] `APP_STORE_CONNECT_API_KEY_ID`
- [ ] `APP_STORE_CONNECT_API_KEY_ISSUER_ID`
- [ ] `APP_STORE_CONNECT_API_KEY_CONTENT` (.p8 파일 내용 전체)

**Match:**
- [ ] `MATCH_PASSWORD` (2.3에서 설정한 암호)
- [ ] `MATCH_GIT_BASIC_AUTHORIZATION` (3.1에서 생성한 토큰)

## Phase 4: Firebase 설정 (선택사항)

### 4.1 Firebase 프로젝트 설정
- [ ] [Firebase Console](https://console.firebase.google.com) 접속
- [ ] 프로젝트 생성 또는 선택
- [ ] iOS 앱 추가
  - Bundle ID: `com.trendflow.magambell` 입력
- [ ] Firebase App ID 복사

### 4.2 Service Account Key 생성
- [ ] Project Settings > Service Accounts
- [ ] "Generate new private key" 클릭
- [ ] JSON 파일 다운로드

### 4.3 GitHub Secrets 추가
- [ ] `FIREBASE_APP_ID_IOS`
- [ ] `GOOGLE_APPLICATION_CREDENTIALS` (JSON 파일 내용 전체)

## Phase 5: 테스트

### 5.1 로컬 테스트
```bash
cd ios

# 환경 변수 설정
export MODE=dev
export VERSION=v1.0.0-test
export BUILD_NUMBER=1
export FLUTTER_VERSION=3.29.0
export APP_STORE_CONNECT_API_KEY_ID=your_key_id
export APP_STORE_CONNECT_API_KEY_ISSUER_ID=your_issuer_id
export APP_STORE_CONNECT_API_KEY_CONTENT="$(cat path/to/AuthKey.p8)"
export MATCH_PASSWORD=your_match_password
export MATCH_GIT_BASIC_AUTHORIZATION=your_github_token

# 빌드 테스트
bundle exec fastlane ios release
```
- [ ] 빌드 성공 확인
- [ ] TestFlight에 업로드 확인 (선택사항)

### 5.2 GitHub Actions 테스트
- [ ] `.github/workflows/ios-deploy.yml` 생성
- [ ] 워크플로우 수동 실행 (workflow_dispatch)
- [ ] Actions 탭에서 실행 로그 확인
- [ ] 성공 확인

## Phase 6: 문서화

- [ ] 팀원에게 설정 방법 공유
- [ ] Match 암호 안전한 곳에 백업 (1Password, LastPass 등)
- [ ] API Key .p8 파일 백업
- [ ] 긴급 연락처 및 복구 절차 문서화

## 트러블슈팅

### 인증서 에러 발생 시
```bash
# Match 인증서 확인
bundle exec fastlane match development --readonly
bundle exec fastlane match appstore --readonly

# 인증서 재생성 (주의!)
bundle exec fastlane match nuke development
bundle exec fastlane match nuke distribution
```

### 빌드 실패 시
1. Flutter 빌드 단독 실행 확인
   ```bash
   flutter build ipa --release --flavor=dev --target=lib/src/main_dev.dart
   ```
2. Xcode에서 직접 빌드 확인
   ```bash
   open ios/Runner.xcworkspace
   ```
3. 로그 확인
   ```bash
   ~/Library/Logs/gym
   ~/Library/Application Support/shorebird/logs
   ```

## 참고 자료

- [Fastlane Match 공식 문서](https://docs.fastlane.tools/actions/match/)
- [App Store Connect API 가이드](https://developer.apple.com/documentation/appstoreconnectapi)
- [Shorebird 공식 문서](https://docs.shorebird.dev)
- [환경 변수 가이드](./ENVIRONMENT_VARIABLES.md)
