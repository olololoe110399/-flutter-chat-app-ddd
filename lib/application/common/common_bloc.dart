import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../core/base_bloc.dart';
import 'common_event.dart';
import 'common_state.dart';

@LazySingleton()
class CommonBloc extends BaseBloc<CommonEvent, CommonState> {
  CommonBloc() : super(const CommonState()) {
    on<LoadingChanged>(onLoadingChanged);
    on<AppThemeChanged>(onAppThemeChanged);
    on<AppLanguageChanged>(onAppLanguageChanged);
    on<Initital>(onInitial);
  }

  Future<void> onLoadingChanged(
    LoadingChanged event,
    Emitter<CommonState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: event.isLoading,
      ),
    );
  }

  Future<void> onAppThemeChanged(
    AppThemeChanged event,
    Emitter<CommonState> emit,
  ) async {
    emit(
      state.copyWith(
        isDarkTheme: event.isDarkTheme,
      ),
    );
  }

  Future<void> onAppLanguageChanged(
    AppLanguageChanged event,
    Emitter<CommonState> emit,
  ) async {
    emit(
      state.copyWith(
        languageCode: event.languageCode,
      ),
    );
  }

  Future<void> onInitial(
    Initital event,
    Emitter<CommonState> emit,
  ) async {
    // initial page
  }
}
