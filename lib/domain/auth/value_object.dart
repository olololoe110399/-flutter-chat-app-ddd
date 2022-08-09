import 'package:dartz/dartz.dart';

import '../domain.dart';

class EmailAddress extends ValueObject<String> {
  const EmailAddress._(this.value);

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateStringNotEmpty(input).flatMap(validateEmailAddress),
    );
  }

  @override
  final Either<ValueFailure<String>, String> value;
}

class Password extends ValueObject<String> {
  factory Password(String input) {
    return Password._(
      validateStringNotEmpty(input).flatMap(validatePassword),
    );
  }

  const Password._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class Name extends ValueObject<String> {
  factory Name(String input) {
    return Name._(validateStringNotEmpty(input));
  }

  const Name._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}
