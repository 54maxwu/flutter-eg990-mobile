import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/agent/data/models/downline_agent_model.dart';

class AgentDialogDownlineDetail extends StatefulWidget {
  final DownlineAgentModel data;

  AgentDialogDownlineDetail(this.data);

  @override
  _AgentDialogDownlineDetailState createState() =>
      _AgentDialogDownlineDetailState();
}

class _AgentDialogDownlineDetailState extends State<AgentDialogDownlineDetail>
    with AfterLayoutMixin {
  final GlobalKey<CustomizeFieldWidgetState> _bankAccountFieldKey =
      new GlobalKey(debugLabel: 'account');
  final GlobalKey<CustomizeFieldWidgetState> _bankFieldKey =
      new GlobalKey(debugLabel: 'bank');
  final GlobalKey<CustomizeFieldWidgetState> _branchFieldKey =
      new GlobalKey(debugLabel: 'branch');
  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _phoneFieldKey =
      new GlobalKey(debugLabel: 'phone');
  final GlobalKey<CustomizeFieldWidgetState> _mailFieldKey =
      new GlobalKey(debugLabel: 'mail');
  final GlobalKey<CustomizeFieldWidgetState> _lineFieldKey =
      new GlobalKey(debugLabel: 'line');

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      heightFactor: 0.5,
      maxHeight: 450,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                localeStr.agentDownlineHeaderMore,
                style: TextStyle(
                  fontSize: FontSize.TITLE.value,
                  color: themeColor.dialogTitleColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                primary: false,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  /* Name Field */
                  new CustomizeFieldWidget(
                    key: _bankAccountFieldKey,
                    hint: '',
                    persistHint: false,
                    prefixText: localeStr.bankcardViewTitleCardNumber,
                    readOnly: true,
                  ),
                  /* Name Field */
                  new CustomizeFieldWidget(
                    key: _bankFieldKey,
                    hint: '',
                    persistHint: false,
                    prefixText: localeStr.bankcardViewTitleBankName,
                    readOnly: true,
                  ),
                  /* Name Field */
                  new CustomizeFieldWidget(
                    key: _branchFieldKey,
                    hint: '',
                    persistHint: false,
                    prefixText: localeStr.bankcardViewTitleBankBranch,
                    readOnly: true,
                  ),
                  /* Name Field */
                  new CustomizeFieldWidget(
                    key: _nameFieldKey,
                    hint: '',
                    persistHint: false,
                    prefixText: localeStr.bankcardViewTitleOwner,
                    readOnly: true,
                  ),
                  /* Name Field */
                  new CustomizeFieldWidget(
                    key: _phoneFieldKey,
                    hint: '',
                    persistHint: false,
                    prefixText: localeStr.registerFieldTitlePhone,
                    readOnly: true,
                  ),
                  /* Name Field */
                  new CustomizeFieldWidget(
                    key: _mailFieldKey,
                    hint: '',
                    persistHint: false,
                    prefixText: localeStr.registerFieldTitleEmail,
                    readOnly: true,
                  ),
                  /* Name Field */
                  new CustomizeFieldWidget(
                    key: _lineFieldKey,
                    hint: '',
                    persistHint: false,
                    prefixText: localeStr.registerFieldTitleLine,
                    readOnly: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _bankAccountFieldKey.currentState?.setInput = widget.data.bankAccount;
    _branchFieldKey.currentState?.setInput = widget.data.bankAddress;
    _nameFieldKey.currentState?.setInput = widget.data.account;
    _mailFieldKey.currentState?.setInput = widget.data.email;
    _phoneFieldKey.currentState?.setInput = widget.data.phone;
    _lineFieldKey.currentState?.setInput = widget.data.zalo;
  }
}
