import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_interface.dart';
import 'package:flutter_eg990_mobile/domain/core/failures.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/types/deposit_method.dart';
import 'package:flutter_eg990_mobile/presentation/common/other/warning_display.dart';

import 'deposit_method_control.dart';
import 'deposit_method_item.dart';

typedef OnClickDepositMethod = void Function(DepositMethod);

class DepositMethodsGrid extends StatefulWidget {
  final DepositMethodControl methodControl;
  final List<DepositMethod> methods;

  DepositMethodsGrid(
      {Key key, @required this.methodControl, @required this.methods})
      : super(key: key);

  @override
  DepositMethodsGridState createState() => DepositMethodsGridState();
}

class DepositMethodsGridState extends State<DepositMethodsGrid> {
  Widget _sliver;

  @override
  void initState() {
    // debugPrint('deposit methods: ${widget.methods}');
    super.initState();
    if (widget.methods.isNotEmpty) {
      widget.methodControl.setSelected = widget.methods.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.methods.isEmpty) {
      return WarningDisplay(message: Failure.server().message);
    }
    _sliver ??= SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 160,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.5,
      ),
      delegate: SliverChildBuilderDelegate(
        (_, index) => GestureDetector(
          onTap: () => widget.methodControl.setSelected = widget.methods[index],
          child: DepositMethodItem(method: widget.methods[index]),
        ),
        childCount: widget.methods.length,
      ),
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(6.0),
      color: themeColor.defaultBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 4.0),
            child: Text(
              localeStr.depositPaymentSpinnerTitleMethod,
              style: TextStyle(
                fontSize: FontSize.MESSAGE.value,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(thickness: 0.2, height: 2.0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              slivers: [_sliver],
            ),
          ),
        ],
      ),
    );
  }
}
