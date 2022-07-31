import 'dart:io';

import '../../domain/domain.dart';

class ErrorMapperFactory {
  static AppError map(Object error) {
    switch (error) {
      case SocketException:
        return AppError(
          appExceptionType: AppExceptionType.noInternet,
          message: 'no internet',
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
