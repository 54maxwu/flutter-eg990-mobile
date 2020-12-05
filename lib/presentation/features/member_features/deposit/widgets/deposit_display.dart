import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/types/deposit_method.dart';
import 'package:flutter_eg990_mobile/res.dart';

import 'content/deposit_content_local.dart';
import 'content/deposit_content_online.dart';
import 'deposit_display_provider.dart';
import 'methods/deposit_method_control.dart';
import 'methods/deposit_methods_grid.dart';

class DepositDisplay extends StatefulWidget {
  @override
  _DepositDisplayState createState() => _DepositDisplayState();
}

class _DepositDisplayState extends State<DepositDisplay> {
  final GlobalKey _gridKey = new GlobalKey(debugLabel: 'depositgrid');

  DepositMethodControl methodControl;
  bool hasValidData = false;

  @override
  Widget build(BuildContext context) {
    hasValidData =
        Provider.of<DepositDisplayProvider>(context).hasAvailableTypes;
    methodControl = Provider.of<DepositDisplayProvider>(context).methodControl;
    return Container(
      height: Global.device.featureContentHeightNoNav,
      child: (!hasValidData)
          ? Center(child: Image.asset(Res.img_no_data))
          : ChangeNotifierProvider<DepositMethodControl>.value(
              value: methodControl,
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Selector<DepositDisplayProvider, List<DepositMethod>>(
                    selector: (_, provider) => provider.store.depositMethods,
                    builder: (_, types, __) {
                      return DepositMethodsGrid(
                        key: _gridKey,
                        methodControl: methodControl,
                        methods: types,
                      );
                    },
                  ),
                  Selector<DepositMethodControl, DepositMethod>(
                    selector: (_, control) => control.getSelected,
                    builder: (_, method, __) {
                      return (method is DepositMethodLocal)
                          ? DepositContentLocal(method)
                          : DepositContentOnline(method);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
