import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/domain.dart';

class ErrorMapperFactory {
  static AppError map(Object error) {
    switch (error.runtimeType) {
      case SocketException:
        return AppError(
          appExceptionType: AppExceptionType.noInternet,
          message: 'no internet',
          error: error,
        );
      case FirebaseAuthException:
        return AppError(
          appExceptionType: AppExceptionType.firebaseAuth,
          message: (error as FirebaseAuthException).message ?? 'Auth error',
          error: error,
        );
      case FirebaseFunctionsException:
        return AppError(
          appExceptionType: AppExceptionType.firebaseFunctions,
          message: 'Error retrieving Stream Chat token',
          error: error,
        );
      default:
        return AppError(
          appExceptionType: AppExceptionType.uncaugth,
          message: error.toString(),
          error: error,
        );
    }
  }
}
