# GPG 암호화를 사용한 민감한 파일 관리 가이드

## 개요

이 프로젝트는 `.env`, `google-services.json`, `GoogleService-Info.plist`, `AuthKey.p8` 같은 민감한 파일들을 GPG를 사용하여 암호화하고 GitHub에 안전하게 저장합니다.

## 암호화 방법

### 1. 민감한 파일 준비

다음 파일들이 있어야 합니다:
- `.env` (루트 디렉토리)
- `android/app/src/dev/res/google-services.json`
- `android/app/src/prod/res/google-services.json`
- `ios/Runner/GoogleService-Info-dev.plist`
- `ios/Runner/GoogleService-Info-prod.plist`
- `ios/AuthKey.p8` (App Store Connect API Key)

### 2. 암호화 스크립트 실행

```bash
.github/scripts/encrypt-secrets.sh
```

스크립트가 암호화 비밀번호를 요청합니다. **이 비밀번호를 안전한 곳에 저장하세요!**

### 3. 암호화된 파일 확인

`.github/secrets/` 디렉토리에 다음 파일들이 생성됩니다:
- `env.gpg`
- `google-services-android-dev.json.gpg`
- `google-services-android-prod.json.gpg`
- `GoogleService-Info-dev.plist.gpg`
- `GoogleService-Info-prod.plist.gpg`
- `AuthKey.p8.gpg`

### 4. Git에 커밋

```bash
git add .github/secrets/*.gpg
git commit -m "Add encrypted secrets"
git push
```

## GitHub Secrets 설정

Repository > Settings > Secrets and variables > Actions

다음 Secret을 추가:
```
CERT_ENCRYPT_PASSPHRASE=<암호화 시 사용한 비밀번호>
```

## GitHub Actions 동작 방식

### 복호화 프로세스

1. **Checkout**: 코드 체크아웃
2. **Decrypt secrets**: `.github/scripts/decrypt-secrets.sh` 실행
   - CERT_ENCRYPT_PASSPHRASE를 사용하여 암호화된 파일들을 복호화
   - `.env` → 루트 디렉토리
   - `google-services.json` (dev/prod) → `android/app/src/{flavor}/res/`
   - `GoogleService-Info.plist` (dev/prod) → `ios/Runner/`
   - `AuthKey.p8` → `ios/`
3. **Build**: 복호화된 파일들을 사용하여 빌드

### 워크플로우 예시

```yaml
- uses: actions/checkout@v4

- name: Decrypt secrets
  env:
    CERT_ENCRYPT_PASSPHRASE: ${{ secrets.CERT_ENCRYPT_PASSPHRASE }}
  run: |
    chmod +x .github/scripts/decrypt-secrets.sh
    .github/scripts/decrypt-secrets.sh

- name: Build
  # 빌드 로직...
```

## 수동 복호화 (로컬 테스트)

```bash
# 환경 변수 설정
export CERT_ENCRYPT_PASSPHRASE="your_passphrase"

# 복호화 스크립트 실행
.github/scripts/decrypt-secrets.sh
```

## 파일 업데이트 방법

민감한 파일을 수정한 후:

1. 암호화 스크립트 재실행:
   ```bash
   .github/scripts/encrypt-secrets.sh
   ```

2. 변경사항 커밋:
   ```bash
   git add .github/secrets/*.gpg
   git commit -m "Update encrypted secrets"
   git push
   ```

## 보안 주의사항

### ✅ 해야 할 것
- GPG 비밀번호를 안전한 곳에 저장 (1Password, LastPass 등)
- 암호화된 파일(.gpg)만 Git에 커밋
- GitHub Secrets로만 비밀번호 관리

### ❌ 하지 말아야 할 것
- 원본 파일(.env, google-services.json, AuthKey.p8 등)을 Git에 커밋하지 말 것
- GPG 비밀번호를 코드나 문서에 포함하지 말 것
- 암호화되지 않은 파일을 공개 저장소에 올리지 말 것
- App Store Connect API 키(.p8)를 GitHub Secrets에 직접 저장하지 말 것 (GPG 암호화 사용)

## 트러블슈팅

### 복호화 실패
```bash
ERROR: CERT_ENCRYPT_PASSPHRASE 환경 변수가 설정되지 않았습니다.
```
**해결**: GitHub Secrets에 `CERT_ENCRYPT_PASSPHRASE`가 올바르게 설정되었는지 확인

### 파일을 찾을 수 없음
```bash
⚠ .github/secrets/env.gpg 파일을 찾을 수 없습니다.
```
**해결**: 암호화 스크립트를 실행하고 암호화된 파일을 Git에 커밋했는지 확인

### 잘못된 비밀번호
```bash
gpg: decryption failed: Bad session key
```
**해결**: GitHub Secrets의 `CERT_ENCRYPT_PASSPHRASE`가 암호화 시 사용한 비밀번호와 일치하는지 확인

## 참고 자료

- [GPG 공식 문서](https://gnupg.org/documentation/)
- [GitHub Encrypted Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [참고한 블로그](https://ios-development.tistory.com/789)
