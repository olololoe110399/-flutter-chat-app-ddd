import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/core.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState extends BaseBlocState with _$ChatState {
  const factory ChatState() = _ChatState;
}
