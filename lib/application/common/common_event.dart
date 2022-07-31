import 'package:freezed_annotation/freezed_annotation.dart';

import '../../presentation/presentation.dart';
import '../../shared/shared.dart';
import '../core/core.dart';

part 'common_event.freezed.dart';

@freezed
class CommonEvent extends BaseBlocEvent with _$CommonEvent {
  const factory CommonEvent.loadingVisibity(bool isLoading) = LoadingChanged;
  const factory CommonEvent.appThemeChanged(bool isDarkTheme) = AppThemeChanged;
  const factory CommonEvent.appLanguageChanged(LanguageCode languageCode) = AppLanguageChanged;
  const factory CommonEvent.exceptionEmitted(AppExceptionWrapper appExceptionWrapper) =
      ExceptionEmitted;
}
