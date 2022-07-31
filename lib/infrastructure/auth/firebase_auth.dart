import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/domain.dart';
import '../error/core.dart';

@LazySingleton(as: IAuth)
class FirebaseAuth implements IAuth {
  @override
  Future<UnitResult> stateAuthenticated() async {
    try {
      return right(unit);
    } catch (e) {
      return left(ErrorMapperFactory.map(e));
    }
  }
}
