# Firebase App Distribution 설정 가이드

## 개요

이 프로젝트는 Dev와 Prod flavor를 위해 별도의 Firebase 앱을 사용합니다. 각 플랫폼(Android/iOS)과 환경(Dev/Prod)마다 총 4개의 Firebase App ID가 필요합니다.

## Firebase 앱 생성

### 1. Firebase Console 접속
```
https://console.firebase.google.com
```

### 2. 프로젝트 선택 또는 생성
- 기존 프로젝트 사용 또는 새 프로젝트 생성

### 3. Android 앱 추가

#### Dev 환경
1. **앱 추가** > **Android** 선택
2. **Android 패키지 이름** 입력
   - Bundle ID 확인: `android/app/build.gradle`에서 `applicationId` 확인
   - 예: `com.trendflow.bread` (dev flavor)
3. **앱 등록** 클릭
4. **Firebase App ID** 복사
   - 형식: `1:123456789:android:abc123def456`
   - 이것이 `FIREBASE_APP_ID_ANDROID_DEV`

#### Prod 환경
1. **앱 추가** > **Android** 선택
2. **Android 패키지 이름** 입력
   - 예: `com.trendflow.magambell` (prod flavor)
3. **앱 등록** 클릭
4. **Firebase App ID** 복사
   - 이것이 `FIREBASE_APP_ID_ANDROID`

### 4. iOS 앱 추가

#### Dev 환경
1. **앱 추가** > **iOS** 선택
2. **iOS 번들 ID** 입력
   - Bundle ID 확인: `ios/Runner.xcodeproj/project.pbxproj`에서 `PRODUCT_BUNDLE_IDENTIFIER` 확인
   - 예: `com.trendflow.bread` (dev flavor)
3. **앱 등록** 클릭
4. **Firebase App ID** 복사
   - 형식: `1:123456789:ios:abc123def456`
   - 이것이 `FIREBASE_APP_ID_IOS_DEV`

#### Prod 환경
1. **앱 추가** > **iOS** 선택
2. **iOS 번들 ID** 입력
   - 예: `com.trendflow.magambell` (prod flavor)
3. **앱 등록** 클릭
4. **Firebase App ID** 복사
   - 이것이 `FIREBASE_APP_ID_IOS`

## Service Account 키 생성

Firebase App Distribution API를 사용하려면 Service Account 키가 필요합니다.

### 단계:
1. **프로젝트 설정** (톱니바퀴 아이콘) 클릭
2. **Service Accounts** 탭 선택
3. **Generate new private key** 클릭
4. JSON 파일 다운로드
5. 파일 내용을 `GOOGLE_APPLICATION_CREDENTIALS` 환경 변수로 설정

## 테스터 그룹 생성

### 1. App Distribution 페이지 이동
```
Firebase Console > Release & Monitor > App Distribution
```

### 2. 테스터 그룹 생성
1. **Testers & Groups** 탭 클릭
2. **Add group** 클릭
3. 그룹 이름: `qa-testers` (iOS Fastfile에서 사용)
4. 테스터 이메일 추가
5. **Save** 클릭

## GitHub Secrets 설정

Repository > Settings > Secrets and variables > Actions

### 필수 Secrets:
```bash
# Android Dev
FIREBASE_APP_ID_ANDROID_DEV=1:123456789:android:dev123456

# Android Prod
FIREBASE_APP_ID_ANDROID=1:123456789:android:prod123456

# iOS Dev
FIREBASE_APP_ID_IOS_DEV=1:123456789:ios:dev123456

# iOS Prod
FIREBASE_APP_ID_IOS=1:123456789:ios:prod123456

# Service Account
GOOGLE_APPLICATION_CREDENTIALS=<JSON 파일 전체 내용>
```

## Firebase App ID 찾는 방법

Firebase Console에서 각 앱의 App ID를 찾으려면:

1. **프로젝트 설정** 클릭
2. **일반** 탭에서 아래로 스크롤
3. **내 앱** 섹션에서 해당 앱 선택
4. **앱 ID** 필드 확인

또는 앱 설정 JSON에서:
```json
{
  "mobilesdk_app_id": "1:123456789:android:abc123def456"
}
```

## 환경별 분기 로직

### Android (android/fastlane/Fastfile:61-65)
```ruby
firebase_app_id = if flavor == "dev"
  ENV["FIREBASE_APP_ID_ANDROID_DEV"]
else
  ENV["FIREBASE_APP_ID_ANDROID"]
end
```

### iOS (ios/fastlane/Fastfile:93-97)
```ruby
firebase_app_id = if flavor == "dev"
  ENV["FIREBASE_APP_ID_IOS_DEV"]
else
  ENV["FIREBASE_APP_ID_IOS"]
end
```

## 패키지명/번들 ID 확인

### Android
```bash
# android/app/build.gradle
grep applicationId android/app/build.gradle
```

출력 예시:
```groovy
applicationId "com.trendflow.bread"  // dev flavor
applicationId "com.trendflow.magambell"  // prod flavor
```

### iOS
```bash
# ios/Runner.xcodeproj/project.pbxproj
grep PRODUCT_BUNDLE_IDENTIFIER ios/Runner.xcodeproj/project.pbxproj | head -5
```

출력 예시:
```
PRODUCT_BUNDLE_IDENTIFIER = com.trendflow.bread;  // dev
PRODUCT_BUNDLE_IDENTIFIER = com.trendflow.magambell;  // prod
```

## 테스트

### 로컬 테스트
```bash
# Android Dev
cd android
MODE=dev \
BUILD_NUMBER=1 \
VERSION=v1.0.0-test \
FIREBASE_APP_ID_ANDROID_DEV=1:xxx:android:dev \
GOOGLE_APPLICATION_CREDENTIALS='{"type":"service_account",...}' \
bundle exec fastlane android distribute

# iOS Dev
cd ios
MODE=dev \
BUILD_NUMBER=1 \
VERSION=v1.0.0-test \
FIREBASE_APP_ID_IOS_DEV=1:xxx:ios:dev \
GOOGLE_APPLICATION_CREDENTIALS='{"type":"service_account",...}' \
bundle exec fastlane ios distribute
```

### GitHub Actions에서 확인
워크플로우 실행 시 로그에서 다음을 확인:
```
🔍 Firebase App Distribution 설정 확인:
  - App ID: 1:123456789:android:dev123456
  - Flavor: dev
  - APK Path: /path/to/app-dev-release.apk
```

## 주의사항

1. **Package Name/Bundle ID 일치**
   - Firebase 앱의 Package Name이 빌드 시 사용하는 것과 정확히 일치해야 함
   - 대소문자 구분

2. **Service Account 권한**
   - Firebase Admin SDK 권한 필요
   - Project > IAM & Admin에서 확인

3. **테스터 초대**
   - 테스터는 초대 이메일 수락 필요
   - 앱 다운로드 전 Firebase 계정으로 로그인

4. **보안**
   - Service Account JSON은 절대 코드에 커밋하지 말 것
   - GitHub Secrets로만 관리

## 문제 해결

### "App not found" 에러
- Firebase App ID가 올바른지 확인
- 해당 flavor에 맞는 환경 변수를 사용하는지 확인

### "Permission denied" 에러
- Service Account 권한 확인
- GOOGLE_APPLICATION_CREDENTIALS가 올바른 JSON인지 확인

### 테스터가 앱을 받지 못함
- 테스터 그룹에 추가되었는지 확인 (iOS의 경우 "qa-testers")
- 테스터가 초대 이메일을 수락했는지 확인

## 참고 링크

- [Firebase App Distribution 공식 문서](https://firebase.google.com/docs/app-distribution)
- [Fastlane Firebase Plugin](https://firebase.google.com/docs/app-distribution/android/distribute-fastlane)
- [Service Accounts 관리](https://console.cloud.google.com/iam-admin/serviceaccounts)
