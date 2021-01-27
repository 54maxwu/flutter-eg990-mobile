import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/bankcard/data/form/bankcard_form.dart';

import '../state/agent_store.dart';

class AgentDisplayBankcardEdit extends StatefulWidget {
  final AgentStore bankcardStore;

  AgentDisplayBankcardEdit({@required this.bankcardStore});

  @override
  _AgentDisplayBankcardEditState createState() =>
      _AgentDisplayBankcardEditState();
}

class _AgentDisplayBankcardEditState extends State<AgentDisplayBankcardEdit> {
  final String tag = 'AgentDisplayBankcardEdit';

  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');
  // Fields
  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _accountFieldKey =
      new GlobalKey(debugLabel: 'account');
  final GlobalKey<CustomizeFieldWidgetState> _branchFieldKey =
      new GlobalKey(debugLabel: 'branch');

  List<ReactionDisposer> _disposers;
  Map<String, String> bankMap;
  String _bankSelected;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      BankcardForm dataForm = BankcardForm(
        owner: _nameFieldKey.currentState.getInput,
        bankId: _bankSelected ?? '',
        card: _accountFieldKey.currentState.getInput,
        branch: _branchFieldKey.currentState.getInput,
      );
      if (dataForm.isValid) {
        debugPrint('bankcard form: ${dataForm.toJson()}');
        if (widget.bankcardStore.waitForNewCardResult)
          callToast(localeStr.messageWait);
        else
          widget.bankcardStore.addBankcard(dataForm);
      } else {
        callToast(localeStr.messageActionFillForm);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    widget.bankcardStore.getBanks();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.bankcardStore.banksMap,
        // Run some logic with the content of the observed field
        (map) {
          debugPrint('bank map changed, size: ${map.keys.length}');
          if (bankMap != map) {
            setState(() {
              bankMap = map;
            });
          }
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
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        constraints: BoxConstraints(maxWidth: Global.device.width - 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    /// Name Input Field
                    new CustomizeFieldWidget(
                      key: _nameFieldKey,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.bankcardViewTitleOwner,
                      errorMsg: localeStr.messageInvalidCardOwner,
                      validCondition: (value) => rangeCheck(
                          value: value.length,
                          min: InputLimit.NAME_MIN,
                          max: InputLimit.NAME_MAX),
                      titleLetterSpacing: 4,
                      maxInputLength: InputLimit.NAME_MAX,
                    ),

                    /// Bank Option
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

                    /// Account Input Field
                    new CustomizeFieldWidget(
                      key: _accountFieldKey,
                      fieldType: FieldType.Numbers,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.bankcardViewTitleCardNumber,
                      errorMsg: localeStr.messageInvalidCardNumber,
                      validCondition: (value) => rangeCheck(
                          value: value.length,
                          min: InputLimit.CARD_MIN,
                          max: InputLimit.CARD_MAX),
                      titleLetterSpacing: 4,
                      maxInputLength: InputLimit.CARD_MAX,
                    ),

                    /// Branch Input Field
                    new CustomizeFieldWidget(
                      key: _branchFieldKey,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.bankcardViewTitleBankBranch,
                      errorMsg: localeStr.messageInvalidCardBankPoint,
                      validCondition: (value) => rangeCheck(
                          value: value.length,
                          min: InputLimit.NAME_MIN,
                          max: InputLimit.NAME_MAX),
                      titleLetterSpacing: 4,
                      maxInputLength: InputLimit.NAME_MAX,
                    ),
                  ],
                ),
              ),
            ),

            /// Confirm Button
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
                        onPressed: () {
                          try {
                            _validateForm();
                          } catch (e, s) {
                            MyLogger.error(msg: 'form error: $e\n$s', tag: tag);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Hint Text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
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
      ),
    );
  }
}
