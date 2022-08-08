import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(
      (l) => left(l),
      (r) => right(unit),
    );
  }

  @override
  int get hashCode => value.hashCode;

  bool isValid() => value.isRight();

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold(
      (f) => throw AppError(
        appExceptionType: AppExceptionType.unexpectedValueError,
        error: f,
        message: 'Encountered a ValueFailure at an unrecoverable point. Terminating. $f',
      ),
      id,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) {
      return true;
    }

    return o is ValueObject<T> && o.value == value;
  }

  @override
  String toString() => 'Value($value)';
}
