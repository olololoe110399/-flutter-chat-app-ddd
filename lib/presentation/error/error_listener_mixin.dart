import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../core/core.dart';
import 'error.dart';

mixin ErrorListenerMixin<T extends StatefulWidget, B extends BaseBloc>
    on BasePageStateDelegete<T, B> implements ErrorListener {
  @override
  void onRemote(AppExceptionWrapper appExceptionWrapper, BuildContext context) {}

  @override
  void onLocal(AppExceptionWrapper appExceptionWrapper, BuildContext context) {}

  @override
  void onUncauth(AppExceptionWrapper appExceptionWrapper, BuildContext context) {}

  @override
  void onNoInternet(AppExceptionWrapper appExceptionWrapper, BuildContext context) {}

  @override
  void onUncaugth(AppExceptionWrapper appExceptionWrapper, BuildContext context) {}
}
