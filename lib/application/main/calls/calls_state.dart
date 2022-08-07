import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/core.dart';

part 'calls_state.freezed.dart';

@freezed
class CallsState extends BaseBlocState with _$CallsState {
  const factory CallsState() = _CallsState;
}
