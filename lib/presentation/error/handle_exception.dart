import 'package:flutter/material.dart';

import '../../../domain/domain.dart';
import '../core/core.dart';
import 'error.dart';

class HandleException {
  Future<void> handleException(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
    ErrorListener errorListener,
  ) async {
    switch (appExceptionWrapper.appError.appExceptionType) {
      case AppExceptionType.noInternet:
        return errorListener.onNoInternet(appExceptionWrapper, context);
      case AppExceptionType.uncaugth:
        return errorListener.onUncaugth(appExceptionWrapper, context);
      case AppExceptionType.firebaseAuth:
        return errorListener.onFirebaseAuthException(appExceptionWrapper, context);
      case AppExceptionType.firebaseFunctions:
        return errorListener.onFirebaseFunctionsException(appExceptionWrapper, context);
      default:
        return errorListener.onUncaugth(appExceptionWrapper, context);
    }
  }
}
