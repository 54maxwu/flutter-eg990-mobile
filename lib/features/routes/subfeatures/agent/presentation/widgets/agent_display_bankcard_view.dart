import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/bankcard/data/models/bankcard_model.dart';

class AgentDisplayBankcardView extends StatefulWidget {
  final BankcardModel bankcard;

  AgentDisplayBankcardView({@required this.bankcard});

  @override
  _AgentDisplayBankcardViewState createState() =>
      _AgentDisplayBankcardViewState();
}

class _AgentDisplayBankcardViewState extends State<AgentDisplayBankcardView>
    with AfterLayoutMixin {
  final String tag = 'AgentDisplayBankcardView';

  final GlobalKey<CustomizeFieldWidgetState> _cardOwnerFieldKey =
      new GlobalKey(debugLabel: 'owner');
  final GlobalKey<CustomizeFieldWidgetState> _cardNumberFieldKey =
      new GlobalKey(debugLabel: 'cnumber');
  final GlobalKey<CustomizeFieldWidgetState> _bankFieldKey =
      new GlobalKey(debugLabel: 'bank');
  final GlobalKey<CustomizeFieldWidgetState> _branchFieldKey =
      new GlobalKey(debugLabel: 'branch');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          /// Name Field
          new CustomizeFieldWidget(
            key: _cardOwnerFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleOwner,
            titleLetterSpacing: 4,
            maxInputLength: InputLimit.NAME_MAX,
            readOnly: true,
          ),

          /// Bank Field
          new CustomizeFieldWidget(
            key: _bankFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleBankName,
            titleLetterSpacing: 4,
            maxInputLength: InputLimit.SHORT_ADDRESS_MAX,
            readOnly: true,
          ),

          /// Account Field
          new CustomizeFieldWidget(
            key: _cardNumberFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleCardNumber,
            maxInputLength: InputLimit.CARD_MAX,
            titleLetterSpacing: 4,
            readOnly: true,
          ),

          /// Branch Field
          new CustomizeFieldWidget(
            key: _branchFieldKey,
            hint: '',
            persistHint: false,
            prefixText: localeStr.bankcardViewTitleBankBranch,
            titleLetterSpacing: 4,
            maxInputLength: InputLimit.SHORT_ADDRESS_MAX,
            readOnly: true,
          ),

          /// Hint Text
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                children: <InlineSpan>[
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0, bottom: 2.0),
                      child: Icon(
                        const IconData(0xf05a, fontFamily: 'FontAwesome'),
                        color: themeColor.hintHyperLink,
                        size: FontSize.NORMAL.value,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: localeStr.agentBankcardHint,
                    style: TextStyle(color: themeColor.hintHyperLink),
                  ),
                ],
              ),
            ),
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
