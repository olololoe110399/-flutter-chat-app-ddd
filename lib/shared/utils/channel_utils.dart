import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChannelUtils {
  const ChannelUtils._();

  static String getChannelName(Channel channel, User? currentUser) {
    if (channel.name != null) {
      return channel.name!;
    } else if (channel.state?.members.isNotEmpty ?? false) {
      final otherMembers = channel.state?.members
          .where(
            (element) => element.userId != currentUser?.id,
          )
          .toList();

      return otherMembers?.length == 1
          ? otherMembers?.first.user?.name ?? 'No name'
          : 'Multiple users';
    } else {
      return 'No Channel Name';
    }
  }

  static String? getChannelImage(Channel channel, User? currentUser) {
    if (channel.image != null) {
      return channel.image!;
    } else if (channel.state?.members.isNotEmpty ?? false) {
      final otherMembers = channel.state?.members
          .where(
            (element) => element.userId != currentUser?.id,
          )
          .toList();

      if (otherMembers?.length == 1) {
        return otherMembers?.first.user?.image;
      }
    }

    return null;
  }
}
