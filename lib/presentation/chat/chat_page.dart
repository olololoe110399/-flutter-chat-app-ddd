import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../../application/application.dart';
import '../../presentation/presentation.dart';
import '../../shared/shared.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    required this.channel,
    Key? key,
  }) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return StreamChannel(
      channel: channel,
      child: const _ChatPage(),
    );
  }
}

class _ChatPage extends StatefulWidget {
  const _ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<_ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends BasePageState<_ChatPage, ChatBloc> {
  late StreamSubscription<int>? unreadCountSubscription;

  @override
  void initState() {
    super.initState();
    unreadCountSubscription = AppStreamChat.instance.channel?.state?.unreadCountStream.listen(
      _unreadCountHandler,
    );
  }

  @override
  void dispose() {
    unreadCountSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    AppStreamChat.ofChannel(context);

    return GestureDetector(
      onTap: () => ViewUtils.hideKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: Dimens.d54.responsive(),
          leading: Align(
            alignment: Alignment.centerRight,
            child: IconBackground(
              icon: CupertinoIcons.back,
              onTap: () => navigator.pop(),
            ),
          ),
          title: _AppBarTitle(
            channel: AppStreamChat.instance.channel,
            client: AppStreamChat.instance.client,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.d8.responsive(),
              ),
              child: Center(
                child: IconBorder(
                  icon: CupertinoIcons.video_camera_solid,
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.d8.responsive(),
              ),
              child: Center(
                child: IconBorder(
                  icon: CupertinoIcons.phone_solid,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: MessageListCore(
                loadingBuilder: (context) {
                  return const Center(child: CircularProgressIndicator());
                },
                emptyBuilder: (context) => const SizedBox.shrink(),
                errorBuilder: (context, error) => DisplayErrorMessage(error: error),
                messageListBuilder: (context, messages) => _MessageList(messages: messages),
              ),
            ),
            _ActionBar(
              channel: AppStreamChat.instance.channel,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _unreadCountHandler(int count) async {
    if (count > 0) {
      await AppStreamChat.instance.channel?.markRead();
    }
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    required this.channel,
    required this.client,
    Key? key,
  }) : super(key: key);

  final Channel? channel;
  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar.small(
          url: channel != null
              ? ChannelUtils.getChannelImage(channel!, AppStreamChat.instance.currentUser)
              : null,
        ),
        SizedBox(
          width: Dimens.d16.responsive(),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                channel != null
                    ? ChannelUtils.getChannelName(channel!, AppStreamChat.instance.currentUser)
                    : '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Dimens.d14.responsive(),
                ),
              ),
              SizedBox(
                height: Dimens.d2.responsive(),
              ),
              if (channel != null) status(),
            ],
          ),
        ),
      ],
    );
  }

  Widget status() {
    return BetterStreamBuilder<List<Member>>(
      stream: channel?.state?.membersStream,
      initialData: channel?.state?.members,
      builder: (context, data) => ConnectionStatusBuilder(
        client: client,
        statusBuilder: (context, status) {
          switch (status) {
            case ConnectionStatus.connected:
              return _buildConnectedTitleState(context, data, channel!);
            case ConnectionStatus.connecting:
              return Text(
                S.of(context).connecting,
                style: TextStyle(
                  fontSize: Dimens.d10.responsive(),
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              );
            case ConnectionStatus.disconnected:
              return Text(
                S.of(context).offline,
                style: TextStyle(
                  fontSize: Dimens.d10.responsive(),
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({
    required this.messages,
    Key? key,
  }) : super(key: key);

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: messages.length + 1,
        reverse: true,
        separatorBuilder: (context, index) {
          if (index == messages.length - 1) {
            return _DateLabel(dateTime: messages[index].createdAt);
          }
          if (messages.length == 1) {
            return const SizedBox.shrink();
          } else if (index >= messages.length - 1) {
            return const SizedBox.shrink();
          } else if (index <= messages.length) {
            final message = messages[index];
            final nextMessage = messages[index + 1];

            return DateTimeUtils.isNotSame(
              message.createdAt,
              nextMessage.createdAt,
            )
                ? _DateLabel(dateTime: message.createdAt)
                : const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        },
        itemBuilder: (context, index) {
          if (index < messages.length) {
            final message = messages[index];

            return message.user?.id == AppStreamChat.instance.currentUser?.id
                ? _MessageOwnTitle(message: message)
                : _MessageTitle(message: message);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _DateLabel extends StatefulWidget {
  const _DateLabel({
    required this.dateTime,
    Key? key,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  __DateLabelState createState() => __DateLabelState();
}

class __DateLabelState extends State<_DateLabel> {
  late String dayInfo;

  @override
  void initState() {
    dayInfo = DateTimeUtils.fromNowCustom(widget.dateTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Dimens.d32.responsive()),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Dimens.d4.responsive(),
              horizontal: Dimens.d12.responsive(),
            ),
            child: Text(
              dayInfo,
              style: TextStyle(
                fontSize: Dimens.d12.responsive(),
                fontWeight: FontWeight.bold,
                color: AppColors.textFaded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({
    required this.message,
    Key? key,
  }) : super(key: key);

  final Message message;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimens.d4.responsive()),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.d12.responsive(),
                  vertical: Dimens.d20.responsive(),
                ),
                child: Text(message.text ?? ''),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.d8.responsive()),
              child: Text(
                DateTimeUtils.jm(message.createdAt),
                style: TextStyle(
                  color: AppColors.textFaded,
                  fontSize: Dimens.d10.responsive(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageOwnTitle extends StatelessWidget {
  const _MessageOwnTitle({
    required this.message,
    Key? key,
  }) : super(key: key);

  final Message message;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimens.d4.responsive()),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.d12.responsive(),
                  vertical: Dimens.d20.responsive(),
                ),
                child: Text(
                  message.text ?? '',
                  style: const TextStyle(
                    color: AppColors.textLigth,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.d8.responsive()),
              child: Text(
                DateTimeUtils.jm(message.createdAt),
                style: TextStyle(
                  color: AppColors.textFaded,
                  fontSize: Dimens.d10.responsive(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionBar extends StatefulWidget {
  const _ActionBar({
    required this.channel,
    Key? key,
  }) : super(key: key);

  final Channel? channel;

  @override
  __ActionBarState createState() => __ActionBarState();
}

class __ActionBarState extends State<_ActionBar> {
  final StreamMessageInputController controller = StreamMessageInputController();

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onTextChange);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: Dimens.d2.responsive(),
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.d16.responsive(),
              ),
              child: const Icon(
                CupertinoIcons.camera_fill,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: Dimens.d16.responsive(),
              ),
              child: TextField(
                controller: controller.textEditingController,
                onChanged: (val) => controller.text = val,
                style: TextStyle(fontSize: Dimens.d14.responsive()),
                decoration: InputDecoration(
                  hintText: S.of(context).typeSomething,
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Dimens.d12.responsive(),
              right: Dimens.d24.responsive(),
            ),
            child: GlowingActionButton(
              color: AppColors.accent,
              icon: Icons.send_rounded,
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  void _onTextChange() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        widget.channel?.keyStroke();
      }
    });
  }

  Future<void> _sendMessage() async {
    if (controller.text.isNotEmpty) {
      await widget.channel?.sendMessage(controller.message);
      controller.clear();
      ViewUtils.hideKeyboard(context);
    }
  }
}

Widget _buildConnectedTitleState(
  BuildContext context,
  List<Member>? members,
  Channel channel,
) {
  Widget? alternativeWidget;
  final memberCount = channel.memberCount;
  if (memberCount != null && memberCount > 2) {
    var text = '${S.of(context).members}: $memberCount';
    final watcherCount = channel.state?.watcherCount ?? 0;
    if (watcherCount > 0) {
      text = '${S.of(context).watchers} $watcherCount';
    }
    alternativeWidget = Text(
      text,
    );
  } else {
    final userId = StreamChatCore.of(context).currentUser?.id;
    final Member? otherMember = members?.firstOrNullWhere(
      (element) => element.userId != userId,
    );

    if (otherMember != null) {
      alternativeWidget = otherMember.user?.online == true
          ? Text(
              S.of(context).online,
              style: TextStyle(
                fontSize: Dimens.d10.responsive(),
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            )
          : Text(
              '${S.of(context).lastOnline} '
              '${DateTimeUtils.fromNow(otherMember.user?.lastActive)}',
              style: TextStyle(
                fontSize: Dimens.d10.responsive(),
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            );
    }
  }

  return _TypingIndicator(
    alternativeWidget: alternativeWidget,
    channel: channel,
  );
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator({
    required this.channel,
    Key? key,
    this.alternativeWidget,
  }) : super(key: key);

  final Widget? alternativeWidget;

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    final channelState = channel.state!;

    final altWidget = alternativeWidget ?? const SizedBox.shrink();

    return BetterStreamBuilder<Iterable<User>>(
      initialData: channelState.typingEvents.keys,
      stream: channelState.typingEventsStream.map((typings) => typings.entries.map((e) => e.key)),
      builder: (context, data) {
        return Align(
          alignment: Alignment.centerLeft,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: data.isNotEmpty
                ? Align(
                    alignment: Alignment.centerLeft,
                    key: const ValueKey('typing-text'),
                    child: Text(
                      S.of(context).typingMessage,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: Dimens.d10.responsive(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    key: const ValueKey('altwidget'),
                    child: altWidget,
                  ),
          ),
        );
      },
    );
  }
}
