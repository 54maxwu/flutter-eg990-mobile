import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';

import '../../data/models/bankcard_model.dart';
import '../state/bankcard_store.dart';

class BankcardDisplayCard extends StatefulWidget {
  final BankcardStore store;
  final BankcardModel bankcard;
  final bool nested;

  BankcardDisplayCard({
    this.store,
    this.bankcard,
    this.nested = false,
  });

  @override
  _BankcardDisplayCardState createState() => _BankcardDisplayCardState();
}

class _BankcardDisplayCardState extends State<BankcardDisplayCard>
    with AfterLayoutMixin {
  final String tag = 'BankcardDisplayCard';

  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _accountFieldKey =
      new GlobalKey(debugLabel: 'account');
  final GlobalKey<CustomizeFieldWidgetState> _branchFieldKey =
      new GlobalKey(debugLabel: 'branch');
  final GlobalKey<CustomizeFieldWidgetState> _bankFieldKey =
      new GlobalKey(debugLabel: 'bank');
  final GlobalKey<CustomizeFieldWidgetState> _provinceFieldKey =
      new GlobalKey(debugLabel: 'province');

  final RegExp chineseRegex = RegExp("[\u4e00-\u9fa5]");

  List<ReactionDisposer> _disposers;
  String _cityCode = '';
  String _province = '';
  String _city = '';
  String _area = '';
  String _addressDetail = '';
  bool _waitProvinceMap;
  bool _waitCityMap;
  bool _waitAreaMap;

  @override
  void initState() {
    _waitProvinceMap = widget.bankcard.bankProvince.isNotEmpty &&
        widget.bankcard.bankProvince.contains(chineseRegex) == false;
    _waitCityMap = widget.bankcard.bankCity.isNotEmpty &&
        widget.bankcard.bankProvince.contains(chineseRegex) == false;
    super.initState();

    if (_waitProvinceMap)
      widget.store.getProvinces();
    else
      _province = widget.bankcard.bankProvince;

    if (_waitCityMap) {
      _cityCode = widget.bankcard.bankCity;
      widget.store.getCities(widget.bankcard.bankProvince, showError: false);
    } else {
      _city = widget.bankcard.bankCity;
    }

    if (!_waitProvinceMap && !_waitCityMap) _waitAreaMap = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.provinceMap,
        // Run some logic with the content of the observed field
        (map) {
          print('province map changed, '
              'size: ${map.keys.length}, '
              'hasKey: ${map.containsKey(widget.bankcard.bankProvince)}');
          if (map.containsKey(widget.bankcard.bankProvince)) {
            _province = map[widget.bankcard.bankProvince];
            print('card province: $_province');
          }
          _waitProvinceMap = false;
          updateReadOnlyField();
        },
      ),
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.cityMap,
        // Run some logic with the content of the observed field
        (Map<String, String> map) {
          print('city map changed, '
              'size: ${map.keys.length}, '
              'hasKey: ${map.containsKey(_cityCode)}');
          if (map.containsKey(_cityCode)) {
            // normal city code behavior
            _city = map[_cityCode];
            _waitCityMap = false;
            print('card city: $_city');

            // if area map is null, request for area map if needed
            if (_waitAreaMap == null && widget.bankcard.bankArea.isNotEmpty) {
              _waitAreaMap = true;
              widget.store.getAreas(widget.bankcard.bankArea);
            }
          } else if (_waitAreaMap == null) {
            // get the area code's start index from last key
            // (which city code should be the largest)
            int subIndex = map.keys.last.lastIndexOf(RegExp('[1-9]'));
            print('city code substring end index: $subIndex');

            // find the real city code from city map else return empty string
            _cityCode = map.keys.firstWhere((key) {
              String shortKey = key.substring(0, subIndex + 1);
              print('compare: $shortKey with ${widget.bankcard.bankCity}, '
                  'result: ${widget.bankcard.bankCity.startsWith(shortKey)}');
              return widget.bankcard.bankCity.startsWith(shortKey);
            }, orElse: () => '');

            if (_cityCode.isNotEmpty) {
              // request for area map
              _city = map[_cityCode];
              print('found city code: $_cityCode, card city: $_city');
              _waitAreaMap = true;
              widget.store.getAreas(_cityCode);
            } else {
              _waitAreaMap = false;
            }
            _waitCityMap = false;
          }
          updateReadOnlyField();
        },
      ),
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.areaMap,
        // Run some logic with the content of the observed field
        (map) {
          print('area map changed, '
              'size: ${map.keys.length}, '
              'hasKey: ${map.containsKey(widget.bankcard.bankArea)}');
          if (map.containsKey(widget.bankcard.bankArea)) {
            _area = map[widget.bankcard.bankArea];
            print('card area: $_area');
          } else if (map.containsKey(widget.bankcard.bankCity)) {
            _area = map[widget.bankcard.bankCity];
            print('card area: $_area');
          }
          _waitAreaMap = false;
          updateReadOnlyField();
        },
      ),
    ];
  }

  void updateReadOnlyField() {
    if (!_waitProvinceMap && !_waitCityMap && !_waitAreaMap) {
      StringBuffer buffer = new StringBuffer();
      if (_province.isNotEmpty) buffer.write(_province);
      if (_city.isNotEmpty) buffer.write(' / $_city');
      if (_area.isNotEmpty) buffer.write(' / $_area');
      _addressDetail = buffer.toString();
      print('bank address detail changed: $_addressDetail');

      _provinceFieldKey.currentState.setInput = _addressDetail;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: ListView(
        primary: widget.nested == false,
        shrinkWrap: true,
        children: <Widget>[
          /* Name Field */
          new CustomizeFieldWidget(
            key: _nameFieldKey,
            fieldType: FieldType.ChineseOnly,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleOwner,
            titleLetterSpacing: 4,
            readOnly: true,
          ),
          /* Bank Field */
          new CustomizeFieldWidget(
            key: _bankFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleBankName,
            titleLetterSpacing: 4,
            readOnly: true,
          ),
          /* Account Field */
          new CustomizeFieldWidget(
            key: _accountFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleCardNumber,
            titleLetterSpacing: 4,
            readOnly: true,
          ),
          /* Branch Field */
          new CustomizeFieldWidget(
            key: _branchFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleBankPoint,
            titleLetterSpacing: 4,
            readOnly: true,
          ),
          /* Province Field */
          new CustomizeFieldWidget(
            key: _provinceFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleBankProvince,
            titleLetterSpacing: 4,
            readOnly: true,
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _nameFieldKey.currentState.setInput = widget.bankcard.firstName;
    _bankFieldKey.currentState.setInput = widget.bankcard.bankName;
    _accountFieldKey.currentState.setInput = widget.bankcard.bankAccountNo;
    _branchFieldKey.currentState.setInput = widget.bankcard.bankAddress;
    setState(() {});
    updateReadOnlyField();
  }
}
