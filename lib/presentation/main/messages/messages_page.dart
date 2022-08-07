import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget buildPage(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: _Stories(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            _delegete,
          ),
        ),
      ],
    );
  }

  Widget _delegete(BuildContext context, int index) {
    final faker = Faker();
    final date = RandomUtils.randomDate();
    final messageData = MessageEntity(
      senderName: faker.person.name(),
      message: faker.lorem.sentence(),
      messageDate: date,
      dateMessage: DateTimeUtils.fromNow(date),
      profilePicture: RandomUtils.randomPictureUrl(),
    );

    return _MessageTitle(
      messageData: messageData,
      onTap: () {
        navigator.push(ChatRoute(
          messageEntity: messageData,
        ));
      },
    );
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({
    required this.messageData,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final MessageEntity messageData;
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
                url: messageData.profilePicture,
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
                      messageData.senderName,
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
                    child: Text(
                      messageData.message,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Dimens.d12.responsive(),
                        color: AppColors.textFaded,
                      ),
                    ),
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
                  Text(
                    messageData.dateMessage.toUpperCase(),
                    style: TextStyle(
                      fontSize: Dimens.d11.responsive(),
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textFaded,
                    ),
                  ),
                  SizedBox(
                    height: Dimens.d8.responsive(),
                  ),
                  Container(
                    height: Dimens.d18.responsive(),
                    width: Dimens.d18.responsive(),
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          fontSize: Dimens.d10,
                          color: AppColors.textLigth,
                        ),
                      ),
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
