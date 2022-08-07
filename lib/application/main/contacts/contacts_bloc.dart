import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/core.dart';
import 'contacts_event.dart';
import 'contacts_state.dart';

@Injectable()
class ContactsBloc extends BaseBloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(const ContactsState()) {
    on<ContactsInitial>(onInitial);
  }

  Future<void> onInitial(
    ContactsInitial event,
    Emitter<ContactsState> emit,
  ) async {}
}
