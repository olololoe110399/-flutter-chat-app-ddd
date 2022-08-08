import 'package:dartz/dartz.dart';

import '../domain.dart';

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  return input.isNotEmpty
      ? right(input)
      : left(
          ValueFailure.empty(
            failedValue: input,
          ),
        );
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  return RegExp(emailRegex).hasMatch(input)
      ? right(input)
      : left(
          ValueFailure.invalidEmail(
            failedValue: input,
          ),
        );
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  return input.length >= 6
      ? right(input)
      : left(
          ValueFailure.shortPassword(
            failedValue: input,
          ),
        );
}
