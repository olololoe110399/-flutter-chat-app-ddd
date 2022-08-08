import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../../application/application.dart';
import '../../presentation.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends BasePageState<ContactsPage, ContactsBloc> {
  late final userListController = AppStreamChat.instance.userListController;

  @override
  void initState() {
    userListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    userListController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return PagedValueListenableBuilder<int, User>(
      valueListenable: userListController,
      builder: (context, value, child) {
        return value.when(
          (users, nextPageKey, error) {
            if (users.isEmpty) {
              return Center(
                child: Text(S.of(context).thereAreNotUsers),
              );
            }

            return LazyLoadScrollView(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users.elementAtOrNull(index);

                  return InkWell(
                    onTap: () => createChannel(user),
                    child: ListTile(
                      leading: Avatar.small(url: user?.image),
                      title: Text(user?.name ?? ''),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error) => DisplayErrorMessage(
            error: error,
          ),
        );
      },
    );
  }

  Future<void> createChannel(User? user) async {
    final channel =
        AppStreamChat.instance.client.channel(AppStreamChat.messagingChannel, extraData: {
      AppStreamChat.membersExtraData: [
        AppStreamChat.instance.currentUser?.id,
        user?.id,
      ],
    });
    await channel.watch();
    await navigator.push(ChatRoute(channel: channel));
  }
}
