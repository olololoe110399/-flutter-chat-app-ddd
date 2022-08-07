import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/core.dart';

part 'main_state.freezed.dart';

@freezed
class MainState extends BaseBlocState with _$MainState {
  const factory MainState() = _MainState;
}
