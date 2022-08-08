import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../core/core.dart';
import 'error.dart';

mixin ErrorListenerMixin<T extends StatefulWidget, B extends BaseBloc>
    on BasePageStateDelegete<T, B> implements ErrorListener {
  @override
  void onNoInternet(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
  ) {
    logE(appExceptionWrapper.toString());
  }

  @override
  void onUncaugth(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
  ) {
    logE(appExceptionWrapper.toString());
  }

  @override
  void onFirebaseAuthException(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
  ) {
    navigator.showErrorSnackBar(appExceptionWrapper.appError.message);
    logE(appExceptionWrapper.toString());
  }

  @override
  void onFirebaseFunctionsException(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
  ) {
    navigator.showErrorSnackBar(appExceptionWrapper.appError.message);
    logE(appExceptionWrapper.toString());
  }
}
