import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';

import '../../data/form/bankcard_form.dart';
import '../../data/models/bankcard_model.dart';
import '../state/bankcard_store.dart';

class BankcardDisplay extends StatefulWidget {
  final BankcardStore store;
  final BankcardModel bankcard;

  BankcardDisplay({this.store, this.bankcard});

  @override
  _BankcardDisplayState createState() => _BankcardDisplayState();
}

class _BankcardDisplayState extends State<BankcardDisplay> {
  final String tag = 'BankcardDisplay';

  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');

  // Fields
  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _accountFieldKey =
      new GlobalKey(debugLabel: 'account');
  final GlobalKey<CustomizeFieldWidgetState> _branchFieldKey =
      new GlobalKey(debugLabel: 'branch');
  // Dropdowns
  final GlobalKey<CustomizeDropdownWidgetState> _cityKey =
      new GlobalKey(debugLabel: 'city');
  final GlobalKey<CustomizeDropdownWidgetState> _areaKey =
      new GlobalKey(debugLabel: 'area');

  List<ReactionDisposer> _disposers;
  Map<String, String> provinceMap;
  Map<String, String> bankMap;
  Map<String, String> cityMap;
  Map<String, String> areaMap;

  bool _waitBankMap = true;
  bool _waitProvinceMap = true;
  String _bankSelected;
  String _provinceSelected;
  String _citySelected;
  String _areaSelected;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      BankcardForm dataForm = BankcardForm(
        owner: _nameFieldKey.currentState.getInput,
        bankId: _bankSelected,
        card: _accountFieldKey.currentState.getInput,
        branch: _branchFieldKey.currentState.getInput,
        province: _provinceSelected,
        area: (_areaSelected != null) ? _areaSelected : _citySelected,
      );
      if (dataForm.isValid) {
        print('bankcard form: ${dataForm.toJson()}');
        if (widget.store.waitForNewCardResult)
          FLToast.showText(
            text: localeStr.messageWait,
            showDuration: ToastDuration.DEFAULT.value,
            position: FLToastPosition.top,
          );
        else
          widget.store.sendRequest(dataForm);
      } else {
        FLToast.showText(
          text: localeStr.messageActionFillForm,
          position: FLToastPosition.top,
          showDuration: ToastDuration.DEFAULT.value,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    widget.store.getBanks();
    widget.store.getProvinces();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.banksMap,
        // Run some logic with the content of the observed field
        (map) {
          print('bank map changed, size: ${map.keys.length}');
          bankMap = map;
          _waitBankMap = false;
          if (!_waitBankMap && !_waitProvinceMap) setState(() {});
        },
      ),
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.provinceMap,
        // Run some logic with the content of the observed field
        (map) {
          print('province map changed, size: ${map.keys.length}');
          provinceMap = map;
          _waitProvinceMap = false;
          if (!_waitBankMap && !_waitProvinceMap) setState(() {});
        },
      ),
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.cityMap,
        // Run some logic with the content of the observed field
        (map) {
          print('city map changed, size: ${map.keys.length}');
          cityMap = map;
          _citySelected = cityMap.keys.first;
          setState(() {});
        },
      ),
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.areaMap,
        // Run some logic with the content of the observed field
        (map) {
          print('area map changed, size: ${map.keys.length}');
          areaMap = map;
          _areaSelected = areaMap.keys.first;
          setState(() {});
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        constraints: BoxConstraints(
          maxWidth: Global.device.width - 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InkWell(
              // to dismiss the keyboard when the user tabs out of the TextField
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: new Form(
                key: _formKey,
                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: <Widget>[
                    /* Name Input Field */
                    new CustomizeFieldWidget(
                      key: _nameFieldKey,
                      fieldType: FieldType.ChineseOnly,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.bankcardViewTitleOwner,
                      errorMsg: localeStr.messageInvalidCardOwner,
                      validCondition: (value) =>
                          rangeCheck(value: value.length, min: 2, max: 12),
                      titleLetterSpacing: 4,
                      maxInputLength: 12,
                    ),
                    /* Bank Option */
                    CustomizeDropdownWidget(
                      prefixText: localeStr.bankcardViewTitleBankName,
                      titleLetterSpacing: 4,
                      optionValues:
                          (bankMap != null) ? bankMap.keys.toList() : [],
                      optionStrings:
                          (bankMap != null) ? bankMap.values.toList() : [],
                      changeNotify: (data) {
                        _bankSelected = data;
                      },
                    ),
                    /* Account Input Field */
                    new CustomizeFieldWidget(
                      key: _accountFieldKey,
                      fieldType: FieldType.Numbers,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.bankcardViewTitleCardNumber,
                      errorMsg: localeStr.messageInvalidCardNumber,
                      validCondition: (value) =>
                          rangeCheck(value: value.length, min: 16, max: 19),
                      titleLetterSpacing: 4,
                      maxInputLength: 19,
                    ),
                    /* Branch Input Field */
                    new CustomizeFieldWidget(
                      key: _branchFieldKey,
                      fieldType: FieldType.ChineseOnly,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.bankcardViewTitleBankPoint,
                      errorMsg: localeStr.messageInvalidCardBankPoint,
                      validCondition: (value) =>
                          rangeCheck(value: value.length, min: 3, max: 10),
                      titleLetterSpacing: 4,
                      maxInputLength: 10,
                    ),
                  ],
                ),
              ),
            ),
            /* Province Option */
            CustomizeDropdownWidget(
              prefixText: localeStr.bankcardViewTitleBankProvince,
              titleLetterSpacing: 4,
              optionValues:
                  (provinceMap != null) ? provinceMap.keys.toList() : [],
              optionStrings:
                  (provinceMap != null) ? provinceMap.values.toList() : [],
              changeNotify: (data) {
                // clear text field focus
                FocusScope.of(context).requestFocus(new FocusNode());
                // set selected data
                _provinceSelected = data;
                // clear dropdown value that's relative
                cityMap = null;
                _citySelected = null;
                areaMap = null;
                _areaSelected = null;
                // request cities map
                widget.store.getCities(data);
              },
            ),
            /* City Option */
            if (cityMap != null)
              CustomizeDropdownWidget(
                key: _cityKey,
                prefixText: localeStr.bankcardViewTitleBankArea,
                titleLetterSpacing: 4,
                optionValues: cityMap.keys.toList(),
                optionStrings: cityMap.values.toList(),
                changeNotify: (data) {
                  // clear text field focus
                  FocusScope.of(context).requestFocus(new FocusNode());
                  // set selected data
                  _citySelected = data;
                  // clear dropdown value that's relative
                  areaMap = null;
                  _areaSelected = null;
                  // request areas map
                  widget.store.getAreas(data);
                },
                clearValueOnMenuChanged: true,
              ),
            /* Area Option */
            if (areaMap != null)
              CustomizeDropdownWidget(
                key: _areaKey,
                prefixText: '${localeStr.bankcardViewTitleBankArea}2',
                titleLetterSpacing: 4,
                optionValues: areaMap.keys.toList(),
                optionStrings: areaMap.values.toList(),
                changeNotify: (data) {
                  // clear text field focus
                  FocusScope.of(context).requestFocus(new FocusNode());
                  // set selected data
                  _areaSelected = data;
                },
                clearValueOnMenuChanged: true,
              ),
            /* Confirm Button */
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: Global.device.comfortButtonHeight,
                      child: RaisedButton(
                        child: Text(localeStr.btnSend),
                        textColor: Themes.defaultTextColorBlack,
                        onPressed: () {
                          try {
                            _validateForm();
                          } catch (e) {
                            MyLogger.error(
                                msg: 'form error: $e', error: e, tag: tag);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//  Widget _buildDataTest() {
//    return Container(
//      constraints: BoxConstraints(
//        maxHeight: Global.device.height * 0.75,
//        maxWidth: Global.device.width - 16,
//      ),
//      padding: const EdgeInsets.all(8.0),
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Expanded(
//            child: SingleChildScrollView(
//              child: RichText(text: TextSpan(text: widget.bankcard.toString())),
//            ),
//          ),
//          Expanded(
//            child: SingleChildScrollView(
//              child: RichText(text: TextSpan(text: provinceMap.toString())),
//            ),
//          ),
//          Expanded(
//            child: SingleChildScrollView(
//              child: RichText(text: TextSpan(text: bankMap.toString())),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
}
