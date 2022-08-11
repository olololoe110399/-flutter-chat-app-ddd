import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';
import '../error/core.dart';

@LazySingleton(as: IAuth)
class IAuthImpl implements IAuth {
  IAuthImpl(
    this._firebaseAuth,
    this._firebaseFunctions,
    this._firebaseStorage,
  );

  final FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _firebaseFunctions;
  final FirebaseStorage _firebaseStorage;

  @override
  Future<Result<Option<AuthEntity>>> getSignedInUser() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user != null) {
        final results = await _firebaseFunctions
            .httpsCallable('ext-auth-chat-getStreamUserToken')
            .call<String>();
        // authenticated
        print("hehe ${user.uid}");
        return right(
          optionOf(
            AuthEntity(
              token: results.data,
              user: user,
            ),
          ),
        );
      } else {
        // not authenticated
        return right(
          optionOf(null),
        );
      }
    } catch (e) {
      return left(ErrorMapperFactory.map(e));
    }
  }

  @override
  Future<Result<Option<AuthEntity>>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
    required Name name,
    required File? file,
  }) async {
    try {
      final emailAddressStr = emailAddress.getOrCrash();
      final passwordStr = password.getOrCrash();
      final nameStr = name.getOrCrash();
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );
      if (userCredential.user != null) {
        final user = userCredential.user!;
        final results = await _firebaseFunctions
            .httpsCallable('ext-auth-chat-getStreamUserToken')
            .call<String>();
        if (file != null) {
          final photoURL = await uploadFile(file, user.uid);
          await user.updatePhotoURL(photoURL);
        }
        await user.updateDisplayName(nameStr);
        await user.reload();

        return right(
          optionOf(
            AuthEntity(
              token: results.data,
              user: _firebaseAuth.currentUser!,
            ),
          ),
        );
      }

      return right(optionOf(null));
    } catch (e) {
      return left(ErrorMapperFactory.map(e));
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

  @override
  Future<Result<Option<AuthEntity>>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    try {
      final emailAddressStr = emailAddress.getOrCrash();
      final passwordStr = password.getOrCrash();
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );

      if (userCredential.user != null) {
        // Get Stream user token from Firebase Functions
        final results = await _firebaseFunctions
            .httpsCallable('ext-auth-chat-getStreamUserToken')
            .call<String>();

        return right(
          optionOf(
            AuthEntity(
              token: results.data,
              user: userCredential.user!,
            ),
          ),
        );
      }

      return right(optionOf(null));
    } catch (e) {
      return left(ErrorMapperFactory.map(e));
    }
  }

  @override
  Future<UnitResult> signOnut() async {
    try {
      await _firebaseAuth.signOut();

      return right(unit);
    } catch (e) {
      return left(ErrorMapperFactory.map(e));
    }
  }
}
