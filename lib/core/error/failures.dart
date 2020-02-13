import 'package:equatable/equatable.dart';
import 'package:to_string/to_string.dart';

part 'failures.g.dart';

@ToString()
abstract class Failure extends Equatable {
  final List<dynamic> properties;

  Failure({
    this.properties,
  });

  @override
  List<Object> get props => [properties];

  @override
  String toString() {
    return _$FailureToString(this);
  }
}

class NetworkFailure extends Failure {}

class ServerFailure extends Failure {}

class DataSourceFailure extends Failure {}

class CacheFailure extends Failure {}

class DataTypeFailure extends Failure {}

class CheckCachedFileFailure extends Failure {}

class InternalFailure extends Failure {}
