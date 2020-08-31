import 'package:vnum/vnum.dart';

@VnumDefinition
class MovieRate extends Vnum<int> {
  static const MovieRate GOOD = const MovieRate.define(1);
  static const MovieRate BAD = const MovieRate.define(-1);
  static const MovieRate CANCEL = const MovieRate.define(0);

  /// Used for defining cases
  const MovieRate.define(int fromValue) : super.define(fromValue);
}
