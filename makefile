lint: 
	make format && make analyze && make dart_code_metrics

sync:
	make pub_get && make force_build_runner

pub_get:
	flutter pub get

format:
	find ./lib -name "*.dart" ! -name "*.g.dart" ! -name "*.freezed.dart" ! -name "*.gr.dart" ! -name "*.config.dart" ! -name "*.mocks.dart" ! -path '*/generated/*' ! -path '.dart_tool/**' | tr '\n' ' ' | xargs flutter format --set-exit-if-changed -l 100

analyze: 
	flutter analyze --no-pub --suppress-analytics lib

metrics:
	flutter pub run dart_code_metrics:metrics analyze lib

dart_code_metrics:
	sh ./tools/dart_code_metrics.sh

build_runner:
	flutter packages pub run build_runner build

watch:
	flutter packages pub run build_runner watch

force_build_runner:
	flutter packages pub run build_runner build --delete-conflicting-outputs

unit_test: 
	flutter test

test_coverage:
	flutter test --coverage && lcov --remove coverage/lcov.info '*/.freezed.dart' '*/.g.dart' '*/.graphql.dart' '*/.part.dart' '*/.config.dart' '*/_event.dart' '*/_state.dart' '*/generated/' '*/routes/' '*/l10n/' '*/config/' '*/di/' -o coverage/lcov.info && genhtml coverage/lcov.info --output=coverage && open coverage/index.html
