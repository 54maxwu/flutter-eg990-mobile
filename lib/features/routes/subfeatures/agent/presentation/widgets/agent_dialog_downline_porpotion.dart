import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/dialog_widget.dart';

import '../../data/models/downline_agent_model.dart';
import 'agent_proportion_table.dart';

class AgentDialogDownlineProportion extends StatefulWidget {
  final DownlineAgentModel data;
  final ChangeAgentProportion onSubmit;
  final GlobalKey dialogKey;

  AgentDialogDownlineProportion({this.data, this.onSubmit, this.dialogKey});

  @override
  _AgentDialogDownlineProportionState createState() =>
      _AgentDialogDownlineProportionState();
}

class _AgentDialogDownlineProportionState
    extends State<AgentDialogDownlineProportion> {
  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      key: widget.dialogKey,
      maxHeight: 520,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: RichText(
                maxLines: 1,
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      '${localeStr.agentDownlineButtonProportion} - ${widget.data.account}',
                  style: TextStyle(
                    color: themeColor.dialogTitleColor,
                    fontSize: FontSize.TITLE.value,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: AgentProportionTable(520.0, (form) {
                widget.onSubmit(form.copyWith(agentId: widget.data.accountId));
              }),
            )
          ],
        ),
      ],
    );
  }
}
