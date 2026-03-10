# BitePick

사장님과 고객을 연결하는 Flutter 기반 모바일 앱.

---

## 목차

1. [프로젝트 개요](#프로젝트-개요)
2. [개발 환경 설정](#개발-환경-설정)
3. [프로젝트 구조](#프로젝트-구조)
4. [환경 분리 (dev / prod)](#환경-분리-dev--prod)
5. [로컬 실행](#로컬-실행)
6. [배포 방법](#배포-방법)
7. [시크릿 관리](#시크릿-관리)
8. [자주 쓰는 명령어](#자주-쓰는-명령어)

---

## 프로젝트 개요

| 항목 | 내용 |
|---|---|
| 패키지명 | `com.trendflow.bitepick` (prod), `com.trendflow.bitepick.dev` (dev) |
| Flutter 버전 | 3.35.5 |
| 빌드 도구 | Shorebird + Fastlane + GitHub Actions |
| 주요 외부 서비스 | Firebase, Kakao, Naver Cloud Platform |

---

## 개발 환경 설정

### 1. 필수 도구 설치

```bash
# Flutter 설치 (FVM 권장)
# https://flutter.dev/docs/get-started/install

# Shorebird 설치
curl --proto '=https' --tlsv1.2 https://raw.githubusercontent.com/shorebirdtech/install/main/install.sh -sSf | bash

# Ruby & Bundler (Fastlane용)
gem install bundler

# iOS 의존성 설치
cd ios && bundle install && pod install
cd android && bundle install
```

### 2. 환경 변수 파일 세팅

`.env` 파일은 git에서 제외되어 있음. GPG로 암호화된 `.github/secrets/env.gpg`를 복호화해서 사용:

```bash
# 팀에서 GPG 패스프레이즈를 받아 아래 명령 실행
GPG_PASSPHRASE=받은_패스프레이즈 make decrypt input=.github/secrets/env.gpg output=.env
```

또는 기존 개발자에게 `.env` 파일을 직접 받을 것.

### 3. iOS 추가 설정 (Mac 전용)

```bash
# Xcode 및 CocoaPods 필요
cd ios && bundle install && pod install
```

---

## 프로젝트 구조

```
lib/src/
├── main_dev.dart        # dev 진입점
├── main_prod.dart       # prod 진입점
├── main_app.dart        # 공통 앱 초기화
├── core/
│   ├── config/
│   │   ├── environment.dart   # dev/prod 환경 분기 처리
│   │   └── constants.dart     # API URL, 키 등 상수
│   ├── network/               # API 클라이언트
│   ├── router/                # 라우팅
│   └── providers/             # 전역 상태
└── features/                  # 기능별 모듈
    ├── auth/                  # 인증 (로그인/회원가입)
    ├── owner/                 # 사장님 관련
    ├── store/                 # 가게 관련
    ├── order/                 # 주문
    ├── home/                  # 홈
    └── ...
```

---

## 환경 분리 (dev / prod)

`lib/src/core/config/environment.dart`에서 dev/prod 환경을 분기 처리함.

| 항목 | dev | prod |
|---|---|---|
| 앱 이름 | MagamBell Dev | MagamBell |
| API URL | DEV_API_URL | API_URL |
| 패키지명 | `...bitepick.dev` | `...bitepick` |
| Shorebird app_id | `eedb6ddf-...` | `baa0ba5b-...` |
| 진입점 | `main_dev.dart` | `main_prod.dart` |

---

## 로컬 실행

```bash
# 의존성 설치
flutter pub get

# dev 환경으로 실행 (시뮬레이터/에뮬레이터)
flutter run -t lib/src/main_dev.dart --flavor dev

# prod 환경으로 실행
flutter run -t lib/src/main_prod.dart --flavor prod

# 코드 생성 (모델, 라우터 등 변경 시)
make build_runner
```

---

## 배포 방법

### 배포 흐름

```
코드 수정 → commit & push → git tag 생성 → tag push → GitHub Actions 자동 실행 → 스토어 업로드
```

GitHub Actions가 태그 이름을 분석해 플랫폼, flavor, 배포 방식을 자동으로 결정함.

---

### 태그 이름 규칙

```
v{버전}-{flavor}-{플랫폼}
v{버전}-{flavor}-{플랫폼}-patch{번호}   ← Shorebird patch
```

| 태그 예시 | 결과 |
|---|---|
| `v1.19.3-prod` | iOS + Android prod 동시 full release |
| `v1.19.3-prod-ios` | iOS prod만 full release |
| `v1.19.3-prod-android` | Android prod만 full release |
| `v1.19.3-dev` | iOS + Android dev 배포 (Firebase 배포 포함) |
| `v1.19.3-prod-ios-patch1` | iOS prod Shorebird patch |
| `v1.19.3-prod-android-patch1` | Android prod Shorebird patch |

---

### Full Release (앱스토어/플레이스토어 정식 배포)

코드가 변경된 경우 또는 첫 배포 시 사용. 앱스토어 심사 필요 (iOS 기준 1~3일 소요).

```bash
# 1. 코드 수정 후 커밋
git add .
git commit -m "feat: 기능 설명"
git push origin main

# 2. 태그 생성 및 push (버전은 이전 태그보다 높게)
git tag v1.19.3-prod
git push origin v1.19.3-prod
```

완료 후:
- **iOS**: TestFlight에 자동 업로드 → App Store Connect에서 심사 제출
- **Android**: Play Store 내부 트랙에 자동 업로드

---

### Shorebird Patch (긴급 버그 수정 — 앱스토어 심사 없음)

Dart 코드만 변경된 경우 사용. 기존 설치 사용자에게 앱 재시작 시 자동 적용됨 (수 분 내 반영).

> 네이티브 코드(Swift/Kotlin), asset 파일 변경은 patch 불가 → Full Release 필요

```bash
# patch 번호는 같은 버전 내에서 순차적으로 증가
git tag v1.19.2-prod-ios-patch1
git push origin v1.19.2-prod-ios-patch1
```

---

### 현재 버전 확인

```bash
grep "^version:" pubspec.yaml

# 최근 태그 확인
git tag --sort=-version:refname | head -10
```

> 새 태그를 만들 때 항상 기존 최신 태그보다 높은 버전을 사용할 것.

---

### GitHub Actions 모니터링

배포 진행 상황은 GitHub 저장소 → **Actions 탭**에서 확인 가능.
각 job별로 로그가 artifact로 저장됨 (30일 보관).

---

## 로컬 직접 배포 (Actions 없이)

Actions 비용 한계 초과 또는 긴급 배포 시 사용.

### 사전 준비

```bash
# Shorebird 로그인
shorebird login

# Ruby 의존성 설치
cd ios && bundle install
cd android && bundle install

# 시크릿 파일 복호화 (GPG 패스프레이즈 필요)
GPG_PASSPHRASE=패스프레이즈 .github/scripts/decrypt-secrets.sh
```

필요한 파일들이 제자리에 있는지 확인:
- `android/app/bitepick-release.keystore`
- `android/key.properties`
- `android/app/src/prod/google-services.json`
- `ios/Runner/GoogleService-Info-prod.plist`
- `ios/AuthKey.p8`

---

### 버전 올리기

`pubspec.yaml`에서 버전 수정:

```
version: 1.19.12+148
```

- `+` 앞: 스토어에 표시되는 버전명
- `+` 뒤: 빌드번호 (이전 빌드번호보다 반드시 높아야 함, `build_numbers.json` 참고)

---

### Android 로컬 배포

**Full Release (Play Store):**

```bash
# 1. AAB 빌드 (서명 포함)
make androidBuild

# 2. Play Store 내부 트랙 업로드
cd android
export MODE=prod
export PACKAGE_NAME=com.trendflow.bitepick
export SUPPLY_JSON_KEY_DATA=$(cat fastlane/google-play-service-account.json)
bundle exec fastlane internal
```

**Shorebird Release (처음 또는 네이티브 변경 시):**

```bash
shorebird release android -t lib/src/main_prod.dart --flavor prod
```

**Shorebird Patch (Dart 코드만 변경 시):**

```bash
shorebird patch android -t lib/src/main_prod.dart --flavor prod
```

---

### iOS 로컬 배포

**Shorebird Release (처음 또는 네이티브 변경 시):**

```bash
shorebird release ios -t lib/src/main_prod.dart --flavor prod
```

완료되면 Transporter 앱으로 생성된 IPA를 TestFlight에 업로드.

**Shorebird Patch (Dart 코드만 변경 시):**

```bash
shorebird patch ios -t lib/src/main_prod.dart --flavor prod
```

---

### Shorebird 계정 관련

Shorebird는 `shorebird.yaml`의 `app_id`로 앱과 연결됨.
계정을 변경하려면:

```bash
# 1. 새 계정 로그인
shorebird login

# 2. 새 앱 생성 및 shorebird.yaml 업데이트
shorebird init

# 3. 새 release 배포 (patch 전 반드시 필요)
shorebird release ios -t lib/src/main_prod.dart --flavor prod
shorebird release android -t lib/src/main_prod.dart --flavor prod
```

> 계정 변경 시 기존 patch 히스토리는 이전되지 않음.

---

## 시크릿 관리

민감한 파일들은 GPG로 암호화되어 `.github/secrets/`에 저장되어 있음.

| 암호화 파일 | 복호화 위치 | 용도 |
|---|---|---|
| `env.gpg` | `.env` | API URL, 각종 키 |
| `google-services-android-dev.json.gpg` | `android/app/src/dev/google-services.json` | Firebase (Android dev) |
| `google-services-android-prod.json.gpg` | `android/app/src/prod/google-services.json` | Firebase (Android prod) |
| `GoogleService-Info-dev.plist.gpg` | `ios/Runner/GoogleService-Info-dev.plist` | Firebase (iOS dev) |
| `GoogleService-Info-prod.plist.gpg` | `ios/Runner/GoogleService-Info-prod.plist` | Firebase (iOS prod) |
| `AuthKey.p8.gpg` | `ios/AuthKey.p8` | App Store Connect API 키 |
| `Dev.xcconfig.gpg` | `ios/Flutter/Dev.xcconfig` | iOS dev 설정 |
| `Prod.xcconfig.gpg` | `ios/Flutter/Prod.xcconfig` | iOS prod 설정 |
| `strings_dev.xml.gpg` | `android/app/src/dev/res/values/strings.xml` | Android dev 문자열 리소스 |
| `strings_prod.xml.gpg` | `android/app/src/prod/res/values/strings.xml` | Android prod 문자열 리소스 |

### 파일 암호화/복호화

```bash
# 암호화 (파일을 .github/secrets/ 에 저장)
GPG_PASSPHRASE=패스프레이즈 make encrypt input=path/to/file

# 복호화
GPG_PASSPHRASE=패스프레이즈 make decrypt input=.github/secrets/file.gpg output=path/to/output
```

GitHub Actions에서는 `CERT_ENCRYPT_PASSPHRASE` secret으로 자동 복호화됨.

---

## 자주 쓰는 명령어

```bash
# 의존성 설치
flutter pub get

# 코드 생성 (freezed, riverpod 등)
make build_runner

# dev 실행
flutter run -t lib/src/main_dev.dart --flavor dev

# iOS 캐시 전체 초기화
make iosCacheClean

# Android prod AAB 로컬 빌드
make androidBuild

# 파일 암호화
GPG_PASSPHRASE=키 make encrypt input=경로

# 파일 복호화
GPG_PASSPHRASE=키 make decrypt input=.github/secrets/file.gpg output=경로
```
