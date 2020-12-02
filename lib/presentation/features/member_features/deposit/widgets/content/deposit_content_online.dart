import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/types/deposit_method.dart';
import 'package:provider/provider.dart';

import '../../state/deposit_store.dart';
import '../deposit_display_provider.dart';
import 'deposit_online_form.dart';
import 'deposit_virtual_form.dart';

class DepositContentOnline extends StatefulWidget {
  final DepositMethod method;

  const DepositContentOnline(this.method);

  @override
  _DepositContentOnlineState createState() => _DepositContentOnlineState();
}

class _DepositContentOnlineState extends State<DepositContentOnline> {
  DepositStore _store;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= Provider.of<DepositDisplayProvider>(context).store;
    return Container(
      child: (widget.method is DepositMethodOnline)
          ? DepositOnlineFormWidget(
              options: (widget.method as DepositMethodOnline).options,
              onDepositRequest: (form) => {
                /// TODO Send Request
              },
            )
          : DepositVirtualFormWidget(
              method: widget.method as DepositMethodVirtualData,
              onDepositRequest: (form) {
                callToastInfo(localeStr.workInProgress);
              },
            ),
    );
  }
}
