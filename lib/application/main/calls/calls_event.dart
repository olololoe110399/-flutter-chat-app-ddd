import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/core.dart';

part 'calls_event.freezed.dart';

@freezed
class CallsEvent extends BaseBlocEvent with _$CallsEvent {
  const factory CallsEvent.callsInitial() = CallsInitial;
}
