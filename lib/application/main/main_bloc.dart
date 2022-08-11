import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../presentation/presentation.dart';
import '../../shared/shared.dart';
import '../core/core.dart';
import 'main_event.dart';
import 'main_state.dart';

@Injectable()
class MainBloc extends BaseBloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<MainInitial>(onInitial);
  }

  Future<void> onInitial(
    MainInitial event,
    Emitter<MainState> emit,
  ) async {
    final requestPermission = await FirebaseMessagingHelper.instance.requestPermission();

    if (requestPermission) {
      final deviceToken = await FirebaseMessagingHelper.instance.deviceToken;
      if (deviceToken != null) {
        logD("deviceToken $deviceToken");
        await AppStreamChat.instance.client.addDevice(
          deviceToken,
          PushProvider.firebase,
        );
      }

      FirebaseMessagingHelper.instance.onTokenRefresh.listen((event) async {
        await AppStreamChat.instance.client.addDevice(
          event,
          PushProvider.firebase,
        );
      });

      final getInitialMessage = await FirebaseMessagingHelper.instance.getInitialMessage;
      if (getInitialMessage != null) {
        await LocalPushNotificationHelper.instance.handleSelectNotificationMap(
          getInitialMessage.data,
          handleClickNotification,
        );
      }
      final getNotificationAppLaunchDetails =
          await LocalPushNotificationHelper.instance.getNotificationAppLaunchDetails;
      if (getNotificationAppLaunchDetails != null) {
        await LocalPushNotificationHelper.instance.handleSelectNotificationPayload(
          getNotificationAppLaunchDetails.payload,
          handleClickNotification,
        );
      }
      FirebaseMessagingHelper.instance.onMessageOpenedApp.listen((event) async {
        await LocalPushNotificationHelper.instance.handleSelectNotificationMap(
          event.data,
          handleClickNotification,
        );
      });
      LocalPushNotificationHelper.instance.selectNotificationSubject.listen((value) {
        LocalPushNotificationHelper.instance.handleSelectNotificationPayload(
          value,
          handleClickNotification,
        );
      });
      FirebaseMessagingHelper.instance.onMessage.listen((event) {
        logD("onMessage $event");

        LocalPushNotificationHelper.instance.notify(
          event,
          AppStreamChat.instance.client,
        );
      });
    }
  }

  Future<void> handleClickNotification(Option<String> messageId) async {
    await messageId.fold(() => null, (id) async {
      final response = await AppStreamChat.instance.client.getMessage(id);
      if (response.channel != null) {
        final channel = response.channel!;
        await navigator.push(
          ChatRoute(
            channel: Channel(
              AppStreamChat.instance.client,
              channel.type,
              channel.id,
            ),
          ),
        );
      }
    });
  }
}
