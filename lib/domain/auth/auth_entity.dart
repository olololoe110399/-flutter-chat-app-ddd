import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
class AuthEntity {
  const AuthEntity({
    required this.token,
    required this.user,
  });

  final String token;
  final User user;
}
