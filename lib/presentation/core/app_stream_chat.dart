import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class AppStreamChat {
  AppStreamChat._({
    required this.streamChatCoreState,
    this.streamChannelState,
  });

  static late AppStreamChat instance;

  static const messagingChannel = 'messaging';
  static const typeChannel = 'type';
  static const membersExtraData = 'members';

  final StreamChatCoreState streamChatCoreState;
  final StreamChannelState? streamChannelState;

  String? get currentUserImage => streamChatCoreState.currentUser?.image;

  StreamChatClient get client => streamChatCoreState.client;

  User? get currentUser => streamChatCoreState.currentUser;

  Channel? get channel => streamChannelState?.channel;

  StreamUserListController get userListController {
    return StreamUserListController(
      client: client,
      limit: 20,
      filter: Filter.notEqual(
        'id',
        streamChatCoreState.currentUser?.id ?? '',
      ),
    );
  }

  StreamChannelListController get channelListController {
    return StreamChannelListController(
      client: client,
      filter: Filter.and(
        [
          Filter.equal(typeChannel, messagingChannel),
          Filter.in_(
            membersExtraData,
            [currentUser?.id ?? ''],
          ),
        ],
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

  static AppStreamChat ofChannel(BuildContext context) {
    final streamChatCoreState = StreamChatCore.of(context);
    final streamChannelState = StreamChannel.of(context);
    final appStreamChat = AppStreamChat._(
      streamChatCoreState: streamChatCoreState,
      streamChannelState: streamChannelState,
    );
    instance = appStreamChat;

    return instance;
  }

  void disconnectUser() {
    streamChatCoreState.client.disconnectUser();
  }

  void connectUser({
    required String token,
    required User user,
  }) =>
      client.connectUser(
        user,
        token,
      );
}
