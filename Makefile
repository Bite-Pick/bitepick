.PHONY: gen clean help

help:
	@echo "Available commands:"
	@echo "  make gen    - Generate assets"
	@echo "  make clean  - Clean generated files"

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
	@shorebird release ios -t lib/src/main_prod.dart --flavor prod
	
GPG_PASSPHRASE:=your_secure_passphrase_here
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

decrypt:
	@if [ -z "$(input)" ]; then \
		echo "❌ input 파일(.gpg)을 지정해야 합니다. 예: make decrypt input=.github/secrets/Dev.xcconfig.gpg"; \
		exit 1; \
	fi

	@if [ ! -f "$(input)" ]; then \
		echo "❌ 입력한 파일이 존재하지 않습니다: $(input)"; \
		exit 1; \
	fi

	@output_file=$$(basename "$(input)" .gpg); \
	echo "🔓 복호화 중..."; \
	gpg --decrypt --batch --yes \
		--passphrase "$(GPG_PASSPHRASE)" \
		--output "$$output_file" \
		"$(input)"; \
	echo "✅ 복호화 완료 → $$output_file"
