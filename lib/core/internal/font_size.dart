import 'package:generic_enum/generic_enum.dart';

class FontSize extends GenericEnum<double> {
  const FontSize._(double value) : super(value);

  /// font size = 16
  static const FontSize NORMAL = FontSize._(16.0);

  /// font size = 18
  static const FontSize MESSAGE = FontSize._(18.0);

  /// font size = 20
  static const FontSize TITLE = FontSize._(20.0);
}
