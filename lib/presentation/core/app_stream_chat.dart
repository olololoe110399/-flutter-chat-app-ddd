import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class AppStreamChat {
  AppStreamChat._({
    required this.streamChatCoreState,
  });

  static late AppStreamChat instance;

  static const messagingChannel = 'messaging';
  static const membersExtraData = 'members';

  final StreamChatCoreState streamChatCoreState;

  String? get currentUserImage => streamChatCoreState.currentUser?.image;

  User? get currentUser => streamChatCoreState.currentUser;

  StreamUserListController get userListController {
    return StreamUserListController(
      client: streamChatCoreState.client,
      limit: 20,
      filter: Filter.notEqual(
        'id',
        streamChatCoreState.currentUser?.id ?? '',
      ),
    );
  }

  static AppStreamChat of(BuildContext context) {
    final streamChatCoreState = StreamChatCore.of(context);
    final appStreamChat = AppStreamChat._(
      streamChatCoreState: streamChatCoreState,
    );
    instance = appStreamChat;

    return instance;
  }

  void disconnectUser() {
    streamChatCoreState.client.disconnectUser();
  }
}
