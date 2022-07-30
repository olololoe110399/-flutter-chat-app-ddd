lint: 
	make format && make analyze && make metrics

sync:
	make pub_get && make force_build_runner

pub_get:
	flutter pub get

format:
	flutter format ./ --set-exit-if-changed -l 100

analyze: 
	flutter analyze --no-pub --suppress-analytics

metrics:
	flutter pub run dart_code_metrics:metrics analyze lib

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
