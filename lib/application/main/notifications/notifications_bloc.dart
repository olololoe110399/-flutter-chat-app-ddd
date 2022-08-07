import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/core.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

@Injectable()
class NotificationsBloc extends BaseBloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(const NotificationsState()) {
    on<NotificationsInitial>(onInitial);
  }

  Future<void> onInitial(
    NotificationsInitial event,
    Emitter<NotificationsState> emit,
  ) async {}
}
