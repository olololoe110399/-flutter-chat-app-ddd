import 'dart:io';

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
    required Name name,
    required bool isSubmitting,
    required File? fileImage,
    required Option<AuthEntity> authEntity,
    required Option<Option<AuthEntity>> authenticated,
  }) = _AuthState;

  factory AuthState.initial() => AuthState(
        emailAddress: EmailAddress(''),
        password: Password(''),
        name: Name(''),
        isSubmitting: false,
        fileImage: null,
        authEntity: optionOf(null),
        authenticated: optionOf(null),
      );
}
