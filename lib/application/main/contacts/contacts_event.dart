import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/core.dart';

part 'contacts_event.freezed.dart';

@freezed
class ContactsEvent extends BaseBlocEvent with _$ContactsEvent {
  const factory ContactsEvent.contactsInitial() = ContactsInitial;
}
