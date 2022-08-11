import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../presentation/core/app_config.dart';
import '../shared.dart';

class FirebaseMessagingHelper with LogMixin {
  final _messaging = FirebaseMessaging.instance;

  static final FirebaseMessagingHelper _singleton = FirebaseMessagingHelper();

  static FirebaseMessagingHelper get instance => _singleton;

  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;
  Future<String?> get deviceToken => _messaging.getToken();
  Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;
  Future<RemoteMessage?> get getInitialMessage => _messaging.getInitialMessage();
  Stream<RemoteMessage> get onMessageOpenedApp => FirebaseMessaging.onMessageOpenedApp;

  Future<void> init() async {
    /// Set the background messaging handler early on
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<bool> requestPermission() async {
    if (Platform.isIOS) {
      final NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

      switch (settings.authorizationStatus) {
        case AuthorizationStatus.authorized:
        // User granted permission
        case AuthorizationStatus.provisional:
          // User granted provisional permission
          return true;
        default:
          // User declined or has not accepted permission
          return false;
      }
    }

    return true;
  }
}

Future _handleBackgroundMessage(RemoteMessage remoteMessage) async {
  /// If you're going to use other Firebase services in the background, such as Firestore,
  /// make sure you call `Firebase.initializeApp()` before using other Firebase services.
  debugPrint('[FirebaseMessagingHelper] onBackgroundMessage ${remoteMessage.notification?.title}');
  await LocalPushNotificationHelper.instance.init();
  final chatClient = StreamChatClient(AppConfig.instance.streamKey);
  if (SharedPrefHelper.instance.userId.isNotEmpty &&
      SharedPrefHelper.instance.userToken.isNotEmpty) {
    await chatClient.connectUser(
      User(id: SharedPrefHelper.instance.userId),
      SharedPrefHelper.instance.userToken,
      connectWebSocket: false,
    );
    await LocalPushNotificationHelper.instance.notify(remoteMessage, chatClient);
  }
}
