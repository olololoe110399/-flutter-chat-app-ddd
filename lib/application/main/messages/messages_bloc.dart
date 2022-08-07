import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/core.dart';
import 'messages_event.dart';
import 'messages_state.dart';

@Injectable()
class MessagesBloc extends BaseBloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(const MessagesState()) {
    on<MessagesInitial>(onInitial);
  }

  Future<void> onInitial(
    MessagesInitial event,
    Emitter<MessagesState> emit,
  ) async {}
}
