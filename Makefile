.PHONY: gen clean help encrypt decrypt
FLUTTER := $(shell which flutter)

help:
	@echo "Available commands:"
	@echo "  make gen                              - Generate assets"
	@echo "  make clean                            - Clean generated files"
	@echo "  make encrypt input=path/to/file       - Encrypt file with GPG"
	@echo "  make decrypt input=file.gpg [output=] - Decrypt GPG file"

gen:
	@echo "Generating assets..."
	@fgen --no-watch
	@echo "Done!"

clean:
	@flutter clean
	@find . -name "*.g.dart" -delete
	@find . -name "*.freezed.dart" -delete

build_runner:
	@dart run build_runner build --delete-conflicting-outputs


sh_patch_android:
	@shorebird release android -t lib/src/main_prod.dart --flavor prod
sh_patch_ios:
	@shorebird patch ios -t lib/src/main_prod.dart --flavor prod
sh_patch_ios_dev:
	@shorebird patch ios -t lib/src/main_dev.dart --flavor dev
# GPG_PASSPHRASE=key_here
SECRETS_DIR=.github/secrets

#make encrypt input=경로 와 같이 사용
encrypt:
	@if [ -z "$(input)" ]; then \
		echo "❌ input 파일을 지정해야 합니다. 예: make encrypt input=path/to/file"; \
		exit 1; \
	fi
	@mkdir -p $(SECRETS_DIR)
	gpg --symmetric --cipher-algo AES256 --batch --yes \
		--passphrase "$(GPG_PASSPHRASE)" \
		--output $(SECRETS_DIR)/$$(basename $(input)).gpg \
		$(input)

	@echo "✅ 암호화 완료 → $(SECRETS_DIR)/$$(basename $(input)).gpg"

# make decrypt input=.github/secrets/file.gpg output=path/to/output
# output을 지정하지 않으면 .gpg 확장자를 제거한 파일명으로 현재 디렉토리에 저장
decrypt:
	@if [ -z "$(input)" ]; then \
		echo "❌ input 파일을 지정해야 합니다. 예: make decrypt input=.github/secrets/file.gpg"; \
		exit 1; \
	fi
	@if [ ! -f "$(input)" ]; then \
		echo "❌ 파일을 찾을 수 없습니다: $(input)"; \
		exit 1; \
	fi
	@if [ -z "$(output)" ]; then \
		OUTPUT_FILE=$$(basename $(input) .gpg); \
	else \
		OUTPUT_FILE="$(output)"; \
		mkdir -p $$(dirname $(output)); \
	fi; \
	gpg --decrypt --cipher-algo AES256 --batch --yes \
		--passphrase "$(GPG_PASSPHRASE)" \
		--output $$OUTPUT_FILE \
		$(input); \
	echo "✅ 복호화 완료 → $$OUTPUT_FILE"


iosCacheClean:
	@echo "╠ Cleaning caches of the app"
	@rm -rf build && rm -rf ios/Pods && rm -rf ios/Podfile.lock && pod cache clean --all && ${FLUTTER} clean && ${FLUTTER} pub get && cd ios && pod repo update && pod install