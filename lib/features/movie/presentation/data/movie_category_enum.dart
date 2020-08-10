import 'package:vnum/vnum.dart';

@VnumDefinition
class MovieCategoryEnum extends Vnum<int> {
  /// Case Definition
  static const MovieCategoryEnum COLLECT = const MovieCategoryEnum.define(-1);
  static const MovieCategoryEnum BUY = const MovieCategoryEnum.define(-2);
  static const MovieCategoryEnum EXPAND = const MovieCategoryEnum.define(-3);
  static const MovieCategoryEnum FOLD = const MovieCategoryEnum.define(-4);
  static const MovieCategoryEnum CATEGORY = const MovieCategoryEnum.define(0);

  /// Used for defining cases
  const MovieCategoryEnum.define(int fromValue) : super.define(fromValue);

  /// Used for loading enum using value
  factory MovieCategoryEnum(int value) =>
      Vnum.fromValue(value, MovieCategoryEnum);

  @override
  String toString() {
    return 'MovieCategoryEnum($value)';
  }
}
