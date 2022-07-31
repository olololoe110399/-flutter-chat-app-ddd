import 'package:flutter/material.dart';

import '../core/core.dart';

abstract class ErrorListener {
  void onRemote(AppExceptionWrapper appExceptionWrapper, BuildContext context);
  void onLocal(AppExceptionWrapper appExceptionWrapper, BuildContext context);
  void onUncauth(AppExceptionWrapper appExceptionWrapper, BuildContext context);
  void onNoInternet(AppExceptionWrapper appExceptionWrapper, BuildContext context);
  void onUncaugth(AppExceptionWrapper appExceptionWrapper, BuildContext context);
}
