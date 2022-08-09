import 'dart:io';

import 'package:dartz/dartz.dart';

import '../domain.dart';

abstract class IAuth {
  Future<Result<Option<AuthEntity>>> getSignedInUser();
  Future<UnitResult> signOnut();
  Future<Result<Option<AuthEntity>>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
    required Name name,
    required File? file,
  });
  Future<Result<Option<AuthEntity>>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
}
