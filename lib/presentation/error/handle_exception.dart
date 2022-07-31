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
      case AppExceptionType.remote:
        return errorListener.onRemote(appExceptionWrapper, context);
      case AppExceptionType.local:
        return errorListener.onLocal(appExceptionWrapper, context);
      case AppExceptionType.noInternet:
        return errorListener.onNoInternet(appExceptionWrapper, context);
      case AppExceptionType.uncaugth:
        return errorListener.onUncaugth(appExceptionWrapper, context);
      default:
        return errorListener.onUncaugth(appExceptionWrapper, context);
    }
  }
}
