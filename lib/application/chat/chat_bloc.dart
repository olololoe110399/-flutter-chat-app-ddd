import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../../domain/domain.dart';
import '../../presentation/chat/chat_page.dart';
import '../core/core.dart';
import 'chat_event.dart';
import 'chat_state.dart';

@Injectable()
class ChatBloc extends BaseBloc<ChatEvent, ChatState> {
  ChatBloc(this._iChat) : super(ChatState.initial()) {
    on<ChatInitial>(onInitial);
    on<ChatPickImage>(onChatPickImage);
    on<ChatTextChanged>(onChatTextChanged);
  }

  final IChat _iChat;

  Future<void> onInitial(
    ChatInitial event,
    Emitter<ChatState> emit,
  ) async {}

  Future<void> onChatTextChanged(
    ChatTextChanged event,
    Emitter<ChatState> emit,
  ) async {
    emit(
      state.copyWith(
        text: event.text,
      ),
    );
  }

  Future<void> onChatPickImage(
    ChatPickImage event,
    Emitter<ChatState> emit,
  ) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker
        .pickImage(
      source: ImageSource.gallery,
    )
        .catchError(
      (dynamic error) {
        logE(error);
        navigator.showErrorSnackBar(error.toString());
      },
    );
    if (pickedFile != null) {
      await runBlocCatching<List<String>>(
        _iChat.uploadAttachments(
          attachments: [
            File(pickedFile.path),
          ],
        ),
        doOnSuccess: (urls) {
          emit(
            state.copyWith(
              attachments: optionOf(
                urls
                    .map(
                      (url) => Attachment(
                        type: AttachmentType.image.name,
                        assetUrl: url,
                      ),
                    )
                    .toList(),
              ),
            ),
          );
          emit(
            state.copyWith(
              attachments: optionOf(null),
            ),
          );
        },
      );
    }
  }
}
