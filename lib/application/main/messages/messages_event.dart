import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/core.dart';

part 'messages_event.freezed.dart';

@freezed
class MessagesEvent extends BaseBlocEvent with _$MessagesEvent {
  const factory MessagesEvent.messagesInitial() = MessagesInitial;
}
