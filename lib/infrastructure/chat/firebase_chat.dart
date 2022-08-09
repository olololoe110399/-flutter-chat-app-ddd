import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';
import '../infrastructure.dart';

@LazySingleton(as: IChat)
class IChatImpl implements IChat {
  IChatImpl(
    this._firebaseStorage,
  );

  final FirebaseStorage _firebaseStorage;

  @override
  Future<Result<List<String>>> uploadAttachments({
    required List<File> attachments,
  }) async {
    try {
      final futures = attachments
          .map(
            (file) => uploadFile(
              file,
              DateTime.now().millisecondsSinceEpoch.toString(),
            ),
          )
          .toList();

      return right(
        await Future.wait(futures),
      );
    } catch (err) {
      return left(ErrorMapperFactory.map(err));
    }
  }

  Future<String> uploadFile(
    File avatarImageFile,
    String fileName,
  ) async {
    final Reference reference = _firebaseStorage.ref().child(fileName);
    final TaskSnapshot snapshot = await reference.putFile(avatarImageFile);

    return snapshot.ref.getDownloadURL();
  }
}
