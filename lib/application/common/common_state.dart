import 'package:freezed_annotation/freezed_annotation.dart';

import '../../shared/enum.dart';
import '../core/core.dart';

part 'common_state.freezed.dart';

@freezed
class CommonState extends BaseBlocState with _$CommonState {
  const factory CommonState({
    @Default(LanguageCode.en) LanguageCode languageCode,
    @Default(false) bool isLoading,
    @Default(false) bool isDarkTheme,
  }) = _CommonState;
}
