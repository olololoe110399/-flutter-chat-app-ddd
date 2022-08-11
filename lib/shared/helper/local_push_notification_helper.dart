import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../shared.dart';

class LocalPushNotificationHelper with LogMixin {
  static const _channelId = 'vtnd.duynn.flutterChatApp';
  static const _channelName = 'flutterChatApp';
  static const _channelDescription = 'flutterChatApp';
  static const _androidDefaultIcon = '@mipmap/ic_launcher';
  static const _bitCount = 31;
  static final LocalPushNotificationHelper _singleton = LocalPushNotificationHelper();

  // ignore: close_sinks
  static final BehaviorSubject<String?> _selectNotificationSubject = BehaviorSubject<String?>();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int get _randomNotificationId => Random().nextInt(pow(2, _bitCount).toInt() - 1);

  static LocalPushNotificationHelper get instance => _singleton;

  BehaviorSubject<String?> get selectNotificationSubject => _selectNotificationSubject;

  Future<NotificationAppLaunchDetails?> get getNotificationAppLaunchDetails =>
      _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  Future<void> init() async {
    /// Change icon at android\app\src\main\res\drawable\app_icon.png
    const androidInit = AndroidInitializationSettings(_androidDefaultIcon);

    /// don't request permission here
    /// we use firebase_messaging package to request permission instead
    const iOSInit = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const init = InitializationSettings(android: androidInit, iOS: iOSInit);

    /// init local notification
    await FlutterLocalNotificationsPlugin().initialize(
      init,
      onSelectNotification: _selectNotificationSubject.add,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
          _channelId,
          _channelName,
          description: _channelDescription,
          importance: Importance.high,
        ));
  }

  Future<void> notify(
    RemoteMessage message,
    StreamChatClient chatClient,
  ) async {
    final data = message.data;

    if (data['type'] == 'message.new') {
      final String messageId = data['id'];
      final GetMessageResponse response = await chatClient.getMessage(messageId);

      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
        autoCancel: true,
        enableVibration: true,
        playSound: true,
      );
      const iOSPlatformChannelSpecifics = IOSNotificationDetails();

      const platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      await FlutterLocalNotificationsPlugin()
          .show(
            _randomNotificationId,
            'New message from ${response.message.user?.name} in ${response.channel?.name}',
            response.message.text,
            platformChannelSpecifics,
            payload: jsonEncode(message.data),
          )
          .onError(
            (error, stackTrace) => logE(
              'Can not show notification cause $error',
              stackTrace: stackTrace,
            ),
          );
    }
  }

  Future<void> handleSelectNotificationMap(
    Map<String, dynamic>? data,
    Function(Option<String> messageId)? readChanged,
  ) async {
    if (data?['type'] == 'message.new') {
      readChanged?.call(optionOf(data?['id']));
    }
  }

  Future<void> handleSelectNotificationPayload(
    String? payload,
    Function(Option<String> messageId)? readChanged,
  ) async {
    final data = ParseUtils.parseStringToMap(payload);
    if (data != null) {
      await handleSelectNotificationMap(data, readChanged);
    }
  }
}
