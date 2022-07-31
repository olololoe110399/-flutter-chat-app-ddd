import 'package:freezed_annotation/freezed_annotation.dart';

import '../../application/core/core.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState extends BaseBlocState with _$SplashState {
  const factory SplashState() = _SplashState;

  factory SplashState.initial() => const SplashState();
}
