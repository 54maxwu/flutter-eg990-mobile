part of 'field_input_widget.dart';

enum FieldInputType {
  Normal,
  Numbers,
  Email,
  Date,
  Password,
  Account,
}

/// DATE
final _dateInputRegex = RegExp("-|[0-9]");

final _dateInputFormatter = FilteringTextInputFormatter.allow(_dateInputRegex);

/// NUMBERS
final _numInputRegex = RegExp("[0-9]");

final _numbersInputFormatter = FilteringTextInputFormatter.digitsOnly;

/// ENG
final _engInputRegex = RegExp("[a-zA-Z]");

final _engLowerCaseInputRegex = RegExp("[a-z]");

final _accountInputFormatter = FilteringTextInputFormatter.allow(
  RegExp("${_engLowerCaseInputRegex.pattern}|"
      "${_numInputRegex.pattern}|[!#_\$%&*+-=?^@]"),
);

final _emailInputFormatter = FilteringTextInputFormatter.allow(
  RegExp("${_engInputRegex.pattern}|"
      "${_numInputRegex.pattern}|[!#\$%&'*+-/=?^_`{|}~.@]"),
);

/// OTHER
final _symbolsInputRegex = RegExp("[\$&+,:;=?@#|'<>.-^*()%!_ ]");

final _passwordInputFormatter = FilteringTextInputFormatter.allow(
  RegExp("${_engInputRegex.pattern}|"
      "${_numInputRegex.pattern}|"
      "${_symbolsInputRegex.pattern}"),
);
//
// final _engSpaceInputRegex = RegExp("[a-zA-Z ]");
//
// // 中文、注音、二聲、四聲、三聲、輕聲
// final _chineseInputRegex = RegExp(
//     "[\u4e00-\u9fa5]|[\u3105-\u3129]|[\u02CA]|[\u02CB]|[\u02C7]|[\u02C9]");
//
// final _textOnlyInputFormatter = FilteringTextInputFormatter.allow(
//   RegExp("${_engSpaceInputRegex.pattern}|"
//       "${_chineseInputRegex.pattern}"),
// );
//
// final _normalInputFormatter = FilteringTextInputFormatter.allow(
//   RegExp("${_engInputRegex.pattern}|"
//       "${_numInputRegex.pattern}|"
//       "${_symbolsInputRegex.pattern}|"
//       "${_chineseInputRegex.pattern}"),
// );
