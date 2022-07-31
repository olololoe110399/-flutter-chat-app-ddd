import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/presentation.dart';
import '../common/common.dart';
import 'core.dart';

abstract class BaseBloc<E extends BaseBlocEvent, S extends BaseBlocState>
    extends BaseBlocDelegete<E, S> with BaseBlocMixin {
  BaseBloc(S initialState) : super(initialState);
}

abstract class BaseBlocDelegete<E extends BaseBlocEvent, S extends BaseBlocState>
    extends Bloc<E, S> {
  BaseBlocDelegete(S initialState) : super(initialState);
  late final AppNavigator navigator;
  late final CommonBloc commonBloc;

  void showLoading() {
    commonBloc.add(const CommonEvent.loadingVisibity(true));
  }

  void hideLoading() {
    commonBloc.add(const CommonEvent.loadingVisibity(false));
  }

  void addException(AppExceptionWrapper appExceptionWrapper) {
    commonBloc.add(CommonEvent.exceptionEmitted(appExceptionWrapper));
  }
}
