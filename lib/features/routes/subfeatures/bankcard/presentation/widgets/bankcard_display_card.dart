import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';

import '../../data/models/bankcard_model.dart';
import '../state/bankcard_store.dart';

class BankcardDisplayCard extends StatefulWidget {
  final BankcardStore store;
  final BankcardModel bankcard;
  final bool nested;

  BankcardDisplayCard({
    @required this.store,
    @required this.bankcard,
    this.nested = false,
  });

  @override
  _BankcardDisplayCardState createState() => _BankcardDisplayCardState();
}

class _BankcardDisplayCardState extends State<BankcardDisplayCard>
    with AfterLayoutMixin {
  final String tag = 'BankcardDisplayCard';

  final GlobalKey<CustomizeFieldWidgetState> _cardOwnerFieldKey =
      new GlobalKey(debugLabel: 'owner');
  final GlobalKey<CustomizeFieldWidgetState> _cardNumberFieldKey =
      new GlobalKey(debugLabel: 'cnumber');
  final GlobalKey<CustomizeFieldWidgetState> _branchFieldKey =
      new GlobalKey(debugLabel: 'branch');
  final GlobalKey<CustomizeFieldWidgetState> _bankFieldKey =
      new GlobalKey(debugLabel: 'bank');

  final RegExp chineseRegex = RegExp("[\u4e00-\u9fa5]");

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
            key: _cardOwnerFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleOwner,
            titleLetterSpacing: 4,
            maxInputLength: InputLimit.NAME_MAX,
            readOnly: true,
          ),
          /* Bank Field */
          new CustomizeFieldWidget(
            key: _bankFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleBankName,
            titleLetterSpacing: 4,
            maxInputLength: InputLimit.SHORT_ADDRESS_MAX,
            readOnly: true,
          ),
          /* Account Field */
          new CustomizeFieldWidget(
            key: _cardNumberFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleCardNumber,
            maxInputLength: InputLimit.CARD_MAX,
            titleLetterSpacing: 4,
            readOnly: true,
          ),
          /* Branch Field */
          new CustomizeFieldWidget(
            key: _branchFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleBankBranch,
            titleLetterSpacing: 4,
            maxInputLength: InputLimit.SHORT_ADDRESS_MAX,
            readOnly: true,
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _cardOwnerFieldKey.currentState.setInput = widget.bankcard.firstName;
    _bankFieldKey.currentState.setInput = widget.bankcard.bankName;
    _cardNumberFieldKey.currentState.setInput = widget.bankcard.bankAccountNo;
    _branchFieldKey.currentState.setInput = widget.bankcard.bankAddress;
    setState(() {});
  }
}
