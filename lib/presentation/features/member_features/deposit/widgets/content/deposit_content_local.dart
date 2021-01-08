import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/common/toast/toast_info_widget.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/types/deposit_method.dart';

import '../../state/deposit_store.dart';
import '../deposit_display_provider.dart';
import 'deposit_local_form.dart';

class DepositContentLocal extends StatefulWidget {
  final DepositMethodLocal method;

  const DepositContentLocal(this.method);

  @override
  _DepositContentLocalState createState() => _DepositContentLocalState();
}

class _DepositContentLocalState extends State<DepositContentLocal> {
  DepositStore _store;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= Provider.of<DepositDisplayProvider>(context).store;
    return Container(
      child: DepositLocalFormWidget(
        options: (widget.method).banks,
        onDepositRequest: (form) {
          callToastInfo(localeStr.msgWorkInProgress);
        },
      ),
    );
  }
}
