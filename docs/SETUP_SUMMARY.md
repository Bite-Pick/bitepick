# 배포 설정 완료 요약

## 완료된 작업

### 1. ✅ iOS 코드 서명 설정 (Match + App Store Connect)

**생성/수정된 파일:**
- `ios/Matchfile` - Match 설정
- `ios/Gemfile.lock` - Ruby 의존성
- `ios/fastlane/Fastfile` - iOS 빌드 자동화

**필요한 GitHub Secrets:**
```
APP_STORE_CONNECT_API_KEY_ID=<App Store Connect에서 발급>
APP_STORE_CONNECT_API_KEY_ISSUER_ID=<App Store Connect에서 발급>
MATCH_PASSWORD=<Match 암호>
MATCH_GIT_BASIC_AUTHORIZATION=<GitHub Personal Access Token>
```

**참고:** App Store Connect API 키(.p8 파일)는 GPG로 암호화되어 `.github/secrets/AuthKey.p8.gpg`에 저장됩니다.

**Match 저장소:**
- https://github.com/magambell/app-ios-certificates
- 인증서 및 프로비저닝 프로파일 암호화 저장

### 2. ✅ GPG 암호화로 민감한 파일 관리

**암호화된 파일들 (.github/secrets/):**
- `env.gpg` - 환경 변수
- `google-services-android-dev.json.gpg` - Firebase Android Dev
- `google-services-android-prod.json.gpg` - Firebase Android Prod
- `GoogleService-Info-dev.plist.gpg` - Firebase iOS Dev
- `GoogleService-Info-prod.plist.gpg` - Firebase iOS Prod
- `AuthKey.p8.gpg` - App Store Connect API Key

**스크립트:**
- `.github/scripts/encrypt-secrets.sh` - 로컬에서 암호화
- `.github/scripts/decrypt-secrets.sh` - GitHub Actions에서 복호화

**필요한 GitHub Secret:**
```
CERT_ENCRYPT_PASSPHRASE=<GPG 암호화 시 사용한 비밀번호>
```

### 3. ✅ GitHub Actions Workflow 업데이트

**변경사항:**
- Android/iOS 빌드에 secrets 복호화 단계 추가
- iOS 빌드에 App Store Connect + Match 환경 변수 추가
- Fastfile에서 중복 `flutter pub get` 제거

### 4. ✅ Firebase App Distribution flavor별 분리

**환경 변수:**
```
FIREBASE_APP_ID_ANDROID_DEV=<Firebase Console에서 확인>
FIREBASE_APP_ID_ANDROID=<Firebase Console에서 확인>
FIREBASE_APP_ID_IOS_DEV=<Firebase Console에서 확인>
FIREBASE_APP_ID_IOS=<Firebase Console에서 확인>
GOOGLE_APPLICATION_CREDENTIALS=<Service Account JSON>
```

### 5. ✅ 문서화

**생성된 문서:**
- `docs/IOS_SETUP_CHECKLIST.md` - iOS 설정 체크리스트
- `docs/ENVIRONMENT_VARIABLES.md` - 환경 변수 가이드
- `docs/FIREBASE_SETUP.md` - Firebase 설정 가이드
- `docs/GPG_ENCRYPTION_GUIDE.md` - GPG 암호화 가이드
- `docs/GITHUB_SECRETS_FILES.md` - GitHub Secrets 파일 관리
- `docs/SETUP_SUMMARY.md` - 이 파일

## 다음 단계

### 1. GitHub Secrets 설정

Repository > Settings > Secrets and variables > Actions

**필수:**
```bash
# GPG
CERT_ENCRYPT_PASSPHRASE=<GPG 암호화 시 사용한 비밀번호>

# Match
MATCH_PASSWORD=<Keychain에서 확인: security find-generic-password -s match -w>
MATCH_GIT_BASIC_AUTHORIZATION=<이미 설정됨>

# Firebase
FIREBASE_APP_ID_ANDROID_DEV=<Firebase Console>
FIREBASE_APP_ID_ANDROID=<Firebase Console>
FIREBASE_APP_ID_IOS_DEV=<Firebase Console>
FIREBASE_APP_ID_IOS=<Firebase Console>
GOOGLE_APPLICATION_CREDENTIALS=<Service Account JSON>

# Shorebird (이미 있을 것)
SHOREBIRD_TOKEN=<이미 설정됨>
```

**iOS 배포용 (이미 설정됨):**
```bash
APP_STORE_CONNECT_API_KEY_ID=<App Store Connect에서 확인>
APP_STORE_CONNECT_API_KEY_ISSUER_ID=<App Store Connect에서 확인>
# AuthKey.p8 파일은 .github/secrets/AuthKey.p8.gpg로 암호화되어 있음
```

### 2. 커밋 및 푸시

```bash
git add .
git commit -m "feat: Add iOS code signing and GPG encryption for sensitive files

- Setup Match for iOS code signing
- Add GPG encryption for .env and Firebase config files
- Update GitHub Actions workflow with decryption step
- Add iOS App Store Connect API integration
- Separate Firebase App IDs by flavor (dev/prod)
- Remove duplicate flutter pub get from Fastfiles
- Add comprehensive documentation"
git push
```

### 3. 테스트

1. **GitHub Actions 실행**
   - Actions 탭에서 `Build And Deploy` workflow 수동 실행
   - Flavor: `dev` 선택
   - 로그에서 복호화 및 빌드 성공 확인

2. **로컬 테스트**
   ```bash
   # 복호화 테스트
   export CERT_ENCRYPT_PASSPHRASE="<your_passphrase>"
   .github/scripts/decrypt-secrets.sh

   # iOS 빌드 테스트 (선택사항)
   cd ios
   bundle exec fastlane match appstore --readonly
   ```

## 트러블슈팅

### Match 암호를 모를 때

```bash
# Keychain에서 확인
security find-generic-password -s match -w

# 또는 Git 저장소 확인
cd /tmp
git clone https://github.com/magambell/app-ios-certificates
```

### App Store Connect API 키 발급

1. [App Store Connect](https://appstoreconnect.apple.com)
2. Users and Access > Keys
3. "+" 버튼으로 새 API Key 생성
4. Developer 권한 선택
5. .p8 파일 다운로드 (한 번만 가능!)
6. Key ID와 Issuer ID 복사

### GPG 복호화 실패

```bash
# 수동 복호화 테스트
gpg -d .github/secrets/env.gpg
```

## 참고 자료

- [Fastlane Match](https://docs.fastlane.tools/actions/match/)
- [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi)
- [Firebase App Distribution](https://firebase.google.com/docs/app-distribution)
- [GitHub Encrypted Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
