import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/core.dart';

part 'notifications_state.freezed.dart';

@freezed
class NotificationsState extends BaseBlocState with _$NotificationsState {
  const factory NotificationsState() = _NotificationsState;
}
