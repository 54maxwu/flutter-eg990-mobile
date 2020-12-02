import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import 'errors.dart';
import 'failures.dart';

///
/// Generic class to validate value inside it.
///
/// Example:
/// class EmailAddress extends ValueObject<String> {
///   final Either<ValueFailure<String>, String> value;
///
///   factory EmailAddress(String input) {
///     assert(input != null);
///     // if email passes validate, [isValid] will return true.
///     // if email passes validate, [getOrCrash] will return email address else throw [UnexpectedValueError].
///     return EmailAddress._(validateEmailAddress(input));
///   }
///
///   const EmailAddress._(this.value);
/// }
///
@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold((f) => throw UnexpectedValueError(f), id);
  }

  bool isValid() => value.isRight();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueId(String identifier) {
    return UniqueId._(
      right(Uuid().v5(Uuid.NAMESPACE_OID, identifier)),
    );
  }

  factory UniqueId.fromUniqueString(String uniqueId) {
    assert(uniqueId != null);
    return UniqueId._(
      right(uniqueId),
    );
  }

  const UniqueId._(this.value);
}
