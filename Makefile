.PHONY: gen gen-watch clean help

help:
	@echo "Available commands:"
	@echo "  make gen        - Generate assets and code"
	@echo "  make gen-watch  - Watch and generate on changes"
	@echo "  make clean      - Clean generated files"

gen:
	@echo "Generating assets..."
	@dart run build_runner build --delete-conflicting-outputs
	@echo "Done!"

gen-watch:
	@echo "Watching for changes..."
	@dart run build_runner watch --delete-conflicting-outputs

clean:
	@flutter clean
	@find . -name "*.g.dart" -delete
	@find . -name "*.freezed.dart" -delete
