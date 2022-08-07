import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/core.dart';

part 'chat_event.freezed.dart';

@freezed
class ChatEvent extends BaseBlocEvent with _$ChatEvent {
  const factory ChatEvent.callsInitial() = ChatInitial;
}
