import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter/services.dart';

part 'input_field_type.dart';

enum FieldInputCornerType { NONE, ROUND_RIGHT, ROUND }

enum _FieldType { Normal, Custom }

class FieldInputWidget extends StatefulWidget {
  final _FieldType fieldType;

  final InputDecoration inputDecoration;

  final TextStyle inputStyle;

  /// Do something on input change
  final ValueChanged<String> onChanged;

  /// Validates the value on input change
  final FormFieldValidator<String> validator;

  final FieldInputType inputType;

  final FieldInputCornerType cornerType;

  final double radius;

  final bool enableSuggestions;

  final int maxInputLength;

  const FieldInputWidget({
    Key key,
    @required this.inputDecoration,
    this.inputStyle,
    this.onChanged,
    this.validator,
    this.inputType,
    this.cornerType = FieldInputCornerType.NONE,
    this.radius = 0,
    this.enableSuggestions = true,
    this.maxInputLength = 100,
  })  : this.fieldType = _FieldType.Normal,
        assert((cornerType == FieldInputCornerType.NONE && radius == 0) ||
            (cornerType != FieldInputCornerType.NONE && radius > 0)),
        super(key: key);

  const FieldInputWidget.custom({
    Key key,
    @required this.inputDecoration,
    this.inputStyle,
    this.onChanged,
    this.inputType,
    this.cornerType = FieldInputCornerType.NONE,
    this.radius = 0,
    this.enableSuggestions = true,
    this.maxInputLength = 100,
  })  : this.fieldType = _FieldType.Custom,
        this.validator = null,
        assert((cornerType == FieldInputCornerType.NONE && radius == 0) ||
            (cornerType != FieldInputCornerType.NONE && radius > 0)),
        super(key: key);

  @override
  FieldInputWidgetState createState() => FieldInputWidgetState();
}

class FieldInputWidgetState extends State<FieldInputWidget> {
  final TextEditingController _controller = new TextEditingController();

  BorderRadius _borderRadius;
  bool _readOnly = false;

  String get input => _controller.text;

  set setReadOnly(bool value) => setState(() => _readOnly = value);

  set setInput(String text) {
    _controller.text = text;
    if (text.isNotEmpty) {
      // Android on change resets cursor position(cursor goes to 0)
      // so you have to check if it reset, then put in the end(just on android)
      // as IOS bugs if you simply put it in the end
      _controller.selection =
          new TextSelection.fromPosition(new TextPosition(offset: text.length));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (widget.inputType == FieldInputType.Date) {
      _controller.addListener(() => _onDateInputChanged());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_borderRadius == null) {
      switch (widget.cornerType) {
        case FieldInputCornerType.NONE:
          _borderRadius = BorderRadius.zero;
          break;
        case FieldInputCornerType.ROUND_RIGHT:
          _borderRadius =
              BorderRadius.horizontal(right: Radius.circular(widget.radius));
          break;
        case FieldInputCornerType.ROUND:
          _borderRadius = BorderRadius.circular(widget.radius);
          break;
      }
    }
    // TextFormField(
    //   decoration: const InputDecoration(
    //     prefixIcon: Icon(Icons.person),
    //     labelText: 'Account',
    //   ),
    //   autocorrect: false,
    //   initialValue: widget.historyForm?.username ?? '',
    //   onChanged: (value) => _username = Username.dirty(value: value),
    //   validator: (_) => (_username.valid) ? null : 'Account Error',
    // ),
    return Container(
      constraints: BoxConstraints.loose(Size(
        double.infinity,
        ThemeInterface.fieldHeight * 2.5,
      )),
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
      ),
      child: TextFormField(
        controller: _controller,
        readOnly: _readOnly,
        obscureText: widget.inputType == FieldInputType.Password,
        decoration: widget.inputDecoration.copyWith(
          fillColor: themeColor.fieldFillColor,
        ),
        style: widget.inputStyle ??
            TextStyle(
              fontSize: FontSize.MESSAGE.value,
              color: themeColor.fieldInputTextColor,
            ),
        autocorrect: false,
        keyboardType: _keyboardType,
        inputFormatters: _formatterList,
        enableSuggestions: widget.enableSuggestions,
        enableInteractiveSelection: false,
        onChanged: (widget.onChanged != null)
            ? widget.onChanged
            : (widget.inputType == FieldInputType.Date)
                ? _onDateInputChanged()
                : _onInputChanged(),
        validator: widget.validator,
      ),
    );
  }

  ValueChanged<String> _onDateInputChanged() => (String value) {
        String input = value;
        int pos = input.length;
        String newText = input;

        // adds - between year and month, and between month and day
        if (pos == 5 && input[pos - 1] != '-') {
          newText = input.replaceRange(pos - 1, pos, '-' + input[pos - 1]);
        } else if (pos == 8 && input[pos - 1] != '-') {
          newText = input.replaceRange(pos - 1, pos, '-' + input[pos - 1]);
        }

        // update cursor position
        if (newText != input) {
          _controller.text = newText;
          _controller.selection = TextSelection.fromPosition(
              new TextPosition(offset: newText.length));
        }
      };

  ValueChanged<String> _onInputChanged() => (String value) {
        // debugPrint('input value: $value');
        // debugPrint('controller text: ${_controller.text}');
        // debugPrint('controller selection: ${_controller.selection}');

        // fix cursor position
        if (_controller.selection.baseOffset ==
                _controller.selection.extentOffset &&
            _controller.selection.baseOffset != value.length) {
          _controller.selection = new TextSelection.fromPosition(
              new TextPosition(offset: value.length));
          debugPrint('fixed controller selection: ${_controller.selection}');
        }
      };

  TextInputType get _keyboardType {
    switch (widget.inputType) {
      case FieldInputType.Numbers:
        return TextInputType.number;
      case FieldInputType.Email:
        return TextInputType.emailAddress;
      case FieldInputType.Date:
        return TextInputType.datetime;
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> get _formatterList {
    switch (widget.inputType) {
      case FieldInputType.Numbers:
        return [
          _numbersInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength),
        ];
      case FieldInputType.Date:
        return [
          _dateInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength),
        ];
      case FieldInputType.Email:
        return [
          _emailInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength),
        ];
      case FieldInputType.Account:
        return [
          _accountInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength),
        ];
      case FieldInputType.Password:
        return [
          _passwordInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength),
        ];
      default:
        return [
          LengthLimitingTextInputFormatter(widget.maxInputLength),
        ];
    }
  }
}
