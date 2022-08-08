import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/domain.dart';
import '../core/core.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState extends BaseBlocState with _$AuthState {
  const factory AuthState({
    required EmailAddress emailAddress,
    required Password password,
    required bool isSubmitting,
    required Option<AuthEntity> authEntity,
    required Option<Option<AuthEntity>> authenticated,
  }) = _AuthState;

  factory AuthState.initial() => AuthState(
        emailAddress: EmailAddress(''),
        password: Password(''),
        isSubmitting: false,
        authEntity: optionOf(null),
        authenticated: optionOf(null),
      );
}
