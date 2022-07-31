import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'inejection.dart';
import 'presentation/core/app_widget.dart';
import 'presentation/core/theme/theme.dart';
import 'shared/constants/ui_constants.dart';
import 'shared/enum.dart';
import 'shared/utils/view_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  await ViewUtils.setPreferredOrientations(
    UiConstants.deviceType == DeviceType.mobile
        ? UiConstants.mobileOrientation
        : UiConstants.tabletOrientation,
  );
  ViewUtils.setSystemUIOverlayStyle(UiConstants.systemUiOverlay);
  runApp(
    AppWidget(
      appTheme: AppTheme(),
    ),
  );
}
