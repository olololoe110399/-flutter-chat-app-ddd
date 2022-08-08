import 'package:cloud_functions/cloud_functions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';
import '../error/core.dart';

@LazySingleton(as: IAuth)
class IAuthImpl implements IAuth {
  IAuthImpl(
    this._firebaseAuth,
    this._firebaseFunctions,
  );

  final FirebaseAuth _firebaseAuth;
  final FirebaseFunctions _firebaseFunctions;

  @override
  Future<Result<Option<AuthEntity>>> getSignedInUser() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user != null) {
        final results = await _firebaseFunctions.httpsCallable('getStreamUserToken').call<String>();
        // authenticated

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
  }) async {
    try {
      final emailAddressStr = emailAddress.getOrCrash();
      final passwordStr = password.getOrCrash();
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );

      if (userCredential.user != null) {
        final results = await _firebaseFunctions.httpsCallable('getStreamUserToken').call<String>();

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
        final results = await _firebaseFunctions.httpsCallable('getStreamUserToken').call<String>();

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
