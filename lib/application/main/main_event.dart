import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/core.dart';

part 'main_event.freezed.dart';

@freezed
class MainEvent extends BaseBlocEvent with _$MainEvent {
  const factory MainEvent.mainInitial() = MainInitial;
}
