import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import 'inejection.dart';
import 'presentation/presentation.dart';
import 'shared/shared.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<AppRouter>(AppRouter());
  await configureInjection(Environment.prod);
  await ViewUtils.setPreferredOrientations(
    UiConstants.deviceType == DeviceType.mobile
        ? UiConstants.mobileOrientation
        : UiConstants.tabletOrientation,
  );
  ViewUtils.setSystemUIOverlayStyle(UiConstants.systemUiOverlay);
  AppConfig.instance.init();
  runApp(
    AppWidget(
      appTheme: AppTheme(),
      client: StreamChatClient(AppConfig.instance.streamKey),
    ),
  );
}
