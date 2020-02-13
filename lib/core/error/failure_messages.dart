import 'failures.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String NETWORK_FAILURE_MESSAGE =
    'Please check your network status and IP location';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INTERNAL_FAILURE_MESSAGE =
    'Internal Failure - There should be an error log somewhere';

extension mapFailureToMessage on Failure {
  String get message {
    switch (runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case InternalFailure:
        return INTERNAL_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
