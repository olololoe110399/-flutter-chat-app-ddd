import 'package:flutter/material.dart';

import '../core/core.dart';

abstract class ErrorListener {
  void onNoInternet(AppExceptionWrapper appExceptionWrapper, BuildContext context);
  void onUncaugth(AppExceptionWrapper appExceptionWrapper, BuildContext context);
  void onFirebaseAuthException(AppExceptionWrapper appExceptionWrapper, BuildContext context);
  void onFirebaseFunctionsException(AppExceptionWrapper appExceptionWrapper, BuildContext context);
}
