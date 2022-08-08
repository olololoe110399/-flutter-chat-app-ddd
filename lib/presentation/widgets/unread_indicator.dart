import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../shared/shared.dart';

class UnreadIndicator extends StatelessWidget {
  const UnreadIndicator({
    required this.channel,
    Key? key,
  }) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: BetterStreamBuilder<int>(
        stream: channel.state?.unreadCountStream,
        initialData: channel.state?.unreadCount,
        builder: (context, data) {
          if (data == 0) {
            return const SizedBox.shrink();
          }

          return Material(
            borderRadius: BorderRadius.circular(Dimens.d8.responsive()),
            color: AppColors.secondary,
            child: Padding(
              padding: EdgeInsets.only(
                left: Dimens.d5.responsive(),
                right: Dimens.d5.responsive(),
                top: Dimens.d2.responsive(),
                bottom: Dimens.d1.responsive(),
              ),
              child: Center(
                child: Text(
                  '${data > 99 ? '99+' : data}',
                  style: TextStyle(
                    fontSize: Dimens.d11.responsive(),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
