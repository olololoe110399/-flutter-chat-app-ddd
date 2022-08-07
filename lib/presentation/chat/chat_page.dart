import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../application/application.dart';
import '../../domain/domain.dart';
import '../../presentation/presentation.dart';
import '../../shared/shared.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.messageEntity,
    Key? key,
  }) : super(key: key);

  final MessageEntity messageEntity;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends BasePageState<ChatPage, ChatBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
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
          messageEntity: widget.messageEntity,
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
          const Expanded(
            child: _DemoMessageList(),
          ),
          const _ActionBar(),
        ],
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    required this.messageEntity,
    Key? key,
  }) : super(key: key);

  final MessageEntity messageEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar.small(
          url: messageEntity.profilePicture,
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
                messageEntity.senderName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Dimens.d14.responsive(),
                ),
              ),
              SizedBox(
                height: Dimens.d2.responsive(),
              ),
              Text(
                S.of(context).onlineNow,
                style: TextStyle(
                  fontSize: Dimens.d10.responsive(),
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.d8.responsive()),
      child: ListView(
        children: [
          _DateLabel(
            dateTime: DateTime.now().subtract(
              const Duration(days: 1),
            ),
          ),
          const _MessageTile(
            message: 'hi',
            messageDate: '12:0 PM',
          ),
          const _MessageOwnerTile(
            message: 'hi, minhf laf duy',
            messageDate: '12:0 PM',
          ),
        ],
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

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    required this.message,
    required this.messageDate,
    Key? key,
  }) : super(key: key);

  final String message;
  final String messageDate;

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
                child: Text(message),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.d8.responsive()),
              child: Text(
                messageDate,
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

class _MessageOwnerTile extends StatelessWidget {
  const _MessageOwnerTile({
    required this.message,
    required this.messageDate,
    Key? key,
  }) : super(key: key);

  final String message;
  final String messageDate;

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
                  message,
                  style: const TextStyle(
                    color: AppColors.textLigth,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.d8.responsive()),
              child: Text(
                messageDate,
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
  const _ActionBar({Key? key}) : super(key: key);

  @override
  __ActionBarState createState() => __ActionBarState();
}

class __ActionBarState extends State<_ActionBar> {
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
                  width: 2,
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
                onChanged: (val) {},
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

  Future<void> _sendMessage() async {}
}
