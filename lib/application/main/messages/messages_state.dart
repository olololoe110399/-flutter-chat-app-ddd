import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/core.dart';

part 'messages_state.freezed.dart';

@freezed
class MessagesState extends BaseBlocState with _$MessagesState {
  const factory MessagesState() = _MessagesState;
}
