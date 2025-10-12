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
