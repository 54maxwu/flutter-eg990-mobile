import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@freezed
abstract class AuthFailure with _$AuthFailure {
  const factory AuthFailure.serverError() = AuthServerError;

  const factory AuthFailure.dataFormatError() = AuthDataFormatError;

  const factory AuthFailure.invalidUsernameAndPasswordCombination() =
      InvalidUsernameAndPasswordCombination;
}
