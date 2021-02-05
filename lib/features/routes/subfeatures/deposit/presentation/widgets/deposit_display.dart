import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/data/error/error_message_map.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/types_grid_widget.dart';
import 'package:flutter_eg990_mobile/features/router/app_navigator_export.dart';

import '../../data/model/deposit_result.dart';
import '../../data/model/payment_type.dart';
import '../state/deposit_store.dart';
import 'payment_content.dart';

class DepositDisplay extends StatefulWidget {
  final DepositStore store;

  DepositDisplay({this.store});

  @override
  _DepositDisplayState createState() => _DepositDisplayState();
}

class _DepositDisplayState extends State<DepositDisplay> with AfterLayoutMixin {
  final GlobalKey<PaymentContentState> _contentKey = new GlobalKey();

  List<ReactionDisposer> _disposers;
  CancelFunc toastDismiss;

  void updateContent(PaymentType type) {
    debugPrint('switching deposit type...${type.label}');
    if (!mounted) return;
    setState(() {
      _contentKey.currentState?.update(type);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      /* Reaction on deposit action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.waitForDepositResult,
        // Run some logic with the content of the observed field
        (bool wait) {
          debugPrint('deposit display wait result: $wait');
          if (wait) {
            toastDismiss = callToastLoading();
          } else if (toastDismiss != null) {
            toastDismiss();
            toastDismiss = null;
          }
        },
      ),
      /* Reaction on deposit result changed */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.depositResult,
        // Run some logic with the content of the observed field
        (DepositResult result) {
          debugPrint('deposit display result: $result');
          if (result == null) return;
          if (result.code == 0 && result.ledger >= 0) {
            callToastInfo(
              localeStr.depositMessageSuccessLocal(result.ledger),
              icon: Icons.check_circle_outline,
            );
          } else if (result.code == 0 && result.url != null) {
            debugPrint('deposit display url: ${result.url}');
            AppNavigator.navigateTo(
              RoutePage.depositWeb,
              arg: WebRouteArguments(startUrl: result.url),
            );
          } else {
            callToastError(MessageMap.getErrorMessage(
              result.msg,
              RouteEnum.DEPOSIT,
            ));
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
    return SizedBox(
      width: Global.device.width - 16.0,
      child: InkWell(
        // to dismiss the keyboard when the user tabs out of the TextField
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: (widget.store.paymentTypes.isEmpty)
            ? Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: localeStr.depositPaymentNoData,
                    style: TextStyle(
                        color: themeColor.defaultTextColor,
                        fontSize: FontSize.SUBTITLE.value),
                  ),
                ),
              )
            : ListView(
                primary: true,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: TypesGridWidget<PaymentType>(
                      types: widget.store.paymentTypes,
                      tabsPerRow: 3,
                      expectTabHeight: 36.0,
                      itemSpace: 6.0,
                      itemSpaceHorFactor: 1.0,
                      titleKey: 'label',
                      onTypeGridTap: (_, type) => updateContent(type),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: PaymentContent(
                      key: _contentKey,
                      promos: widget.store.promoMap,
                      infoList: widget.store.infoList,
                      banks: widget.store.banks,
                      rules: widget.store.depositRule,
                      depositCall: widget.store.sendRequest,
                      firstTypeKey: widget.store.paymentTypes.first.key,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.store.paymentTypes.length > 0)
      _contentKey.currentState.update(widget.store.paymentTypes.first);
  }
}
