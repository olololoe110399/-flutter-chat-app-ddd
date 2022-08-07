import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../core/core.dart';
import 'chat_event.dart';
import 'chat_state.dart';

@Injectable()
class ChatBloc extends BaseBloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<ChatInitial>(onInitial);
  }

  Future<void> onInitial(
    ChatInitial event,
    Emitter<ChatState> emit,
  ) async {}
}
