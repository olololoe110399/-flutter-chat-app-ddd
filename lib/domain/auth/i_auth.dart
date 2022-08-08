import 'package:dartz/dartz.dart';

import '../domain.dart';

abstract class IAuth {
  Future<Result<Option<AuthEntity>>> getSignedInUser();
}
