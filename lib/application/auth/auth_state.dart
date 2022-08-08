import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/domain.dart';
import '../core/core.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState extends BaseBlocState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.authenticated({
    required AuthEntity authEntity,
  }) = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;
}
