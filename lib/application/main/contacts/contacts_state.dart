import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/core.dart';

part 'contacts_state.freezed.dart';

@freezed
class ContactsState extends BaseBlocState with _$ContactsState {
  const factory ContactsState() = _ContactsState;
}
