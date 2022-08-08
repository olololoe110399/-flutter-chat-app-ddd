import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';
import '../../presentation/presentation.dart';
import '../core/core.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@Injectable()
class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc(this._auth) : super(AuthState.initial()) {
    on<AuthCheckRequested>(onAuthCheckRequested);
    on<SignedOut>(onSignedOut);
    on<EmailChanged>(onEmailChanged);
    on<PasswordChanged>(onPasswordChanged);
    on<RegisterWithEmailAndPasswordPressed>(onRegisterWithEmailAndPasswordPressed);
    on<SignInWithEmailAndPasswordPressed>(onSignInWithEmailAndPasswordPressed);
  }

  final IAuth _auth;

  Future<void> onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    await runBlocCatching<Option<AuthEntity>>(
      _auth.getSignedInUser(),
      doOnSuccess: (auth) {
        emit(
          state.copyWith(
            authenticated: optionOf(auth),
          ),
        );
      },
      doOnError: (_) => emit(
        state.copyWith(
          authenticated: optionOf(null),
        ),
      ),
      isHandleLoading: false,
    );
  }

  Future<void> onSignedOut(
    SignedOut event,
    Emitter<AuthState> emit,
  ) async {
    await runBlocCatching(
      _auth.signOnut(),
      doOnSuccess: (auth) async {
        emit(AuthState.initial());
        await navigator.pop();
        await navigator.replace(const SplashRoute());
      },
      isHandleLoading: false,
    );
  }

  Future<void> onEmailChanged(
    EmailChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        emailAddress: EmailAddress(event.emailStr),
      ),
    );
  }

  Future<void> onPasswordChanged(
    PasswordChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        password: Password(event.passwordStr),
      ),
    );
  }

  Future<void> onRegisterWithEmailAndPasswordPressed(
    RegisterWithEmailAndPasswordPressed event,
    Emitter<AuthState> emit,
  ) async {
    final isPasswordValid = state.password.isValid();
    final isEmailValid = state.emailAddress.isValid();
    if (isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: true,
        ),
      );
      await runBlocCatching<Option<AuthEntity>>(
        _auth.registerWithEmailAndPassword(
          emailAddress: state.emailAddress,
          password: state.password,
        ),
        doOnSuccess: (auth) {
          emit(
            state.copyWith(
              authEntity: auth,
            ),
          );
        },
        doOnError: (_) {
          emit(
            state.copyWith(
              isSubmitting: false,
            ),
          );
        },
        isHandleLoading: false,
      );
    }
  }

  Future<void> onSignInWithEmailAndPasswordPressed(
    SignInWithEmailAndPasswordPressed event,
    Emitter<AuthState> emit,
  ) async {
    final isPasswordValid = state.password.isValid();
    final isEmailValid = state.emailAddress.isValid();
    if (isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: true,
        ),
      );
      await runBlocCatching<Option<AuthEntity>>(
        _auth.signInWithEmailAndPassword(
          emailAddress: state.emailAddress,
          password: state.password,
        ),
        doOnSuccess: (auth) {
          emit(
            state.copyWith(
              authEntity: auth,
            ),
          );
        },
        doOnError: (_) {
          emit(
            state.copyWith(
              isSubmitting: false,
            ),
          );
        },
        isHandleLoading: false,
      );
    }
  }
}
