import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../../application/application.dart';
import '../../../domain/domain.dart';
import '../../../presentation/presentation.dart';
import '../../../shared/shared.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends BasePageState<MessagesPage, MessagesBloc> {
  late final channelListController = AppStreamChat.instance.channelListController;

  @override
  void initState() {
    channelListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    channelListController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return PagedValueListenableBuilder<int, Channel>(
      valueListenable: channelListController,
      builder: (context, value, child) {
        return value.when(
          (channels, nextPageKey, error) {
            if (channels.isEmpty) {
              return Center(
                child: Text(
                  S.of(context).soEmptyngoAndMessageSomeone,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return LazyLoadScrollView(
              onEndOfPage: () async {
                if (nextPageKey != null) {
                  await channelListController.loadMore(nextPageKey);
                }
              },
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: _Stories(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _delegete(context, index, channels[index]);
                      },
                      childCount: channels.length,
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => Center(
            child: SizedBox(
              height: Dimens.d100.responsive(),
              width: Dimens.d100.responsive(),
              child: const CircularProgressIndicator(),
            ),
          ),
          error: (e) => DisplayErrorMessage(
            error: e,
          ),
        );
      },
    );
  }

  Widget _delegete(BuildContext context, int index, Channel channel) {
    return _MessageTitle(
      channel: channel,
      onTap: () {
        navigator.push(
          ChatRoute(
            channel: channel,
          ),
        );
      },
    );
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({
    required this.channel,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Channel channel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Dimens.d4.responsive()),
        height: Dimens.d100.responsive(),
        margin: EdgeInsets.symmetric(
          horizontal: Dimens.d8.responsive(),
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(Dimens.d10.responsive()),
              child: Avatar.medium(
                url: ChannelUtils.getChannelImage(channel, AppStreamChat.instance.currentUser),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimens.d8.responsive()),
                    child: Text(
                      ChannelUtils.getChannelName(channel, AppStreamChat.instance.currentUser),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        letterSpacing: 0.2,
                        wordSpacing: 1.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.d20.responsive(),
                    child: _buildLastMessage(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                right: Dimens.d20.responsive(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: Dimens.d4.responsive(),
                  ),
                  _buildLastMessageAt(),
                  SizedBox(
                    height: Dimens.d8.responsive(),
                  ),
                  Center(
                    child: UnreadIndicator(
                      channel: channel,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastMessage() {
    return BetterStreamBuilder<int>(
      stream: channel.state?.unreadCountStream,
      initialData: channel.state?.unreadCount ?? 0,
      builder: (context, count) {
        return BetterStreamBuilder<Message>(
          stream: channel.state?.lastMessageStream,
          initialData: channel.state?.lastMessage,
          builder: (context, lastMessage) {
            return Text(
              lastMessage.text ?? '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: Dimens.d12.responsive(),
                color: (count > 0) ? AppColors.secondary : AppColors.textFaded,
                fontWeight: (count > 0) ? FontWeight.bold : FontWeight.normal,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLastMessageAt() {
    return BetterStreamBuilder<DateTime>(
      stream: channel.lastMessageAtStream,
      initialData: channel.lastMessageAt,
      builder: (context, data) {
        return Text(
          DateTimeUtils.fromNowChannel(data.toLocal()),
          style: TextStyle(
            fontSize: Dimens.d11.responsive(),
            letterSpacing: -0.2,
            fontWeight: FontWeight.w600,
            color: AppColors.textFaded,
          ),
        );
      },
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: Dimens.d16.responsive(),
              top: Dimens.d8.responsive(),
              bottom: Dimens.d16.responsive(),
            ),
            child: Text(
              S.current.stories,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: Dimens.d15.responsive(),
                color: AppColors.textFaded,
              ),
            ),
          ),
          SizedBox(
            height: Dimens.d103.responsive(),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _StoryCard(
                  storyData: StoryEntity(
                    name: Faker().person.name(),
                    url: RandomUtils.randomPictureUrl(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.storyData,
    Key? key,
  }) : super(key: key);

  final StoryEntity storyData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.d8.responsive()),
      child: SizedBox(
        width: Dimens.d60.responsive(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Avatar.medium(url: storyData.url),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: Dimens.d16.responsive()),
                child: Text(
                  storyData.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Dimens.d11.responsive(),
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
