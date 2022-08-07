import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/core.dart';
import 'calls_event.dart';
import 'calls_state.dart';

@Injectable()
class CallsBloc extends BaseBloc<CallsEvent, CallsState> {
  CallsBloc() : super(const CallsState()) {
    on<CallsInitial>(onInitial);
  }

  Future<void> onInitial(
    CallsInitial event,
    Emitter<CallsState> emit,
  ) async {}
}
