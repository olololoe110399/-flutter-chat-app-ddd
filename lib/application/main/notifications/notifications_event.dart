import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/core.dart';

part 'notifications_event.freezed.dart';

@freezed
class NotificationsEvent extends BaseBlocEvent with _$NotificationsEvent {
  const factory NotificationsEvent.notificationsInitial() = NotificationsInitial;
}
