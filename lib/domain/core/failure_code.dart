import 'package:meta/meta.dart' show immutable;

import 'failure_type.dart';

export 'failure_type.dart';

@immutable
class FailureCode {
  final FailureType type;
  final int code;

  int get errorCode => type.value + code;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const FailureCode({
    this.type = FailureType.NOT_DEFINED,
    this.code = 0,
  });

  FailureCode copyWith({
    FailureType type,
    int code,
  }) {
    if ((type == null || identical(type, this.type)) &&
        (code == null || identical(code, this.code))) {
      return this;
    }

    return new FailureCode(
      type: type ?? this.type,
      code: code ?? this.code,
    );
  }

  @override
  String toString() {
    return 'FailureCode{type: $type, code: $code}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FailureCode &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          code == other.code);

  @override
  int get hashCode => type.hashCode ^ code.hashCode;

//</editor-fold>

}
