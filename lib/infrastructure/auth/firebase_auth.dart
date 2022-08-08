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
        final callable =
            _firebaseFunctions.httpsCallable('ext-auth-chat-getStreamUserToken').call<String>();

        final results = await callable;
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
}
