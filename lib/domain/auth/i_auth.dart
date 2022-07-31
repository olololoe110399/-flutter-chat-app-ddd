import '../domain.dart';

abstract class IAuth {
  Future<UnitResult> stateAuthenticated();
}
