import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';
import '../core/core.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@Injectable()
class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc(this._auth) : super(const AuthState.initial()) {
    on<AuthCheckRequested>(onAuthCheckRequested);
    on<SignedOut>(onSignedOut);
  }

  final IAuth _auth;

  Future<void> onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    await runBlocCatching<Option<AuthEntity>>(
      _auth.getSignedInUser(),
      doOnSuccess: (auth) {
        auth.fold(
          () => emit(const AuthState.unauthenticated()),
          (value) => emit(
            AuthState.authenticated(authEntity: value),
          ),
        );
      },
      doOnError: (_) => emit(
        const AuthState.unauthenticated(),
      ),
    );
  }

  Future<void> onSignedOut(
    SignedOut event,
    Emitter<AuthState> emit,
  ) async {}
}
