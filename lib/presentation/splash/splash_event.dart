import 'package:freezed_annotation/freezed_annotation.dart';

import '../../application/core/core.dart';

part 'splash_event.freezed.dart';

@freezed
class SplashEvent extends BaseBlocEvent with _$SplashEvent {
  const factory SplashEvent.initial() = Initital;
}
