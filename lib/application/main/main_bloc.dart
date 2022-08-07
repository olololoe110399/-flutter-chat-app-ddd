import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../core/core.dart';
import 'main_event.dart';
import 'main_state.dart';

@Injectable()
class MainBloc extends BaseBloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<MainInitial>(onInitial);
  }

  Future<void> onInitial(
    MainInitial event,
    Emitter<MainState> emit,
  ) async {}
}
