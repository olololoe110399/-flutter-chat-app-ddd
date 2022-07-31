import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/navigator/app_navigator.dart';
import '../common/common_bloc.dart';
import 'base_bloc_event.dart';
import 'base_bloc_state.dart';

abstract class BaseBloc<E extends BaseBlocEvent, S extends BaseBlocState>
    extends BaseBlocDelegete<E, S> {
  BaseBloc(S initialState) : super(initialState);
}

abstract class BaseBlocDelegete<E extends BaseBlocEvent, S extends BaseBlocState>
    extends Bloc<E, S> {
  BaseBlocDelegete(S initialState) : super(initialState);
  late final AppNavigator navigator;
  late final CommonBloc commonBloc;
}
