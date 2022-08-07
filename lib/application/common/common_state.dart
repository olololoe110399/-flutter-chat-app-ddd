import 'package:freezed_annotation/freezed_annotation.dart';

import '../../presentation/presentation.dart';
import '../../shared/shared.dart';
import '../core/core.dart';

part 'common_state.freezed.dart';

@freezed
class CommonState extends BaseBlocState with _$CommonState {
  const factory CommonState({
    @Default(LanguageCode.en) LanguageCode languageCode,
    @Default(false) bool isLoading,
    @Default(true) bool isDarkTheme,
    AppExceptionWrapper? appExceptionWrapper,
  }) = _CommonState;
}
