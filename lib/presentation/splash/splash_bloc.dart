import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../application/core/core.dart';
import 'splash_event.dart';
import 'splash_state.dart';

@Injectable()
class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<Initital>(onInitial);
  }

  Future<void> onInitial(
    Initital event,
    Emitter<SplashState> emit,
  ) async {
    // initial page
  }
}
