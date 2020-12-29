part of 'firebase_interface.dart';

enum FirebaseLog {
  TEST,
}

enum FirebaseLogParam {
  DEVICE,
}

extension FirebaseLogExtension on FirebaseLog {
  String get name {
    switch (this) {
      case FirebaseLog.TEST:
      default:
        return 'test_event';
    }
  }
}

extension FirebaseLogParamExtension on FirebaseLogParam {
  String get name {
    switch (this) {
      case FirebaseLogParam.DEVICE:
      default:
        return 'device';
    }
  }
}
