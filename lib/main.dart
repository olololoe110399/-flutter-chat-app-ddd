import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import 'firebase_options.dart';
import 'inejection.dart';
import 'presentation/presentation.dart';
import 'shared/shared.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  getIt.registerSingleton<AppRouter>(AppRouter());
  await configureInjection(Environment.prod);
  await SharedPrefHelper.instance.init();
  await FirebaseMessagingHelper.instance.init();
  await LocalPushNotificationHelper.instance.init();
  await ViewUtils.setPreferredOrientations(
    UiConstants.deviceType == DeviceType.mobile
        ? UiConstants.mobileOrientation
        : UiConstants.tabletOrientation,
  );
  ViewUtils.setSystemUIOverlayStyle(UiConstants.systemUiOverlay);
  runApp(
    AppWidget(
      appTheme: AppTheme(),
      client: StreamChatClient(
        AppConfig.instance.streamKey,
        logLevel: Level.INFO,
      ),
    ),
  );
}
