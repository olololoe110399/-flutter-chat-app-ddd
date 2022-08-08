import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ConnectionStatusBuilder extends StatelessWidget {
  const ConnectionStatusBuilder({
    required this.client,
    required this.statusBuilder,
    Key? key,
    this.connectionStatusStream,
    this.errorBuilder,
    this.loadingBuilder,
  }) : super(key: key);

  final Stream<ConnectionStatus>? connectionStatusStream;

  final Widget Function(BuildContext context, Object? error)? errorBuilder;

  final WidgetBuilder? loadingBuilder;

  final Widget Function(BuildContext context, ConnectionStatus status) statusBuilder;

  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    final stream = connectionStatusStream ?? client.wsConnectionStatusStream;

    return BetterStreamBuilder<ConnectionStatus>(
      initialData: client.wsConnectionStatus,
      stream: stream,
      noDataBuilder: loadingBuilder,
      errorBuilder: (context, error) {
        if (errorBuilder != null) {
          return errorBuilder!(context, error);
        }

        return const Offstage();
      },
      builder: statusBuilder,
    );
  }
}
