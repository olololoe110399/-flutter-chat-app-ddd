import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../core/core.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState extends BaseBlocState with _$ChatState {
  const factory ChatState({
    required Option<List<Attachment>> attachments,
    required String text,
  }) = _ChatState;

  factory ChatState.initial() => ChatState(
        attachments: optionOf(null),
        text: '',
      );
}
