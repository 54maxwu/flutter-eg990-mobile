import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';

import 'state/deposit_store.dart';
import 'widgets/deposit_display.dart';

/// Main View of [Router.promoRoute]
///@author H.C.CHIANG
///@version 2020/3/12
class DepositRoute extends StatefulWidget {
  @override
  _DepositRouteState createState() => _DepositRouteState();
}

class _DepositRouteState extends State<DepositRoute> {
  DepositStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.errorMessage,
        // Run some logic with the content of the observed field
        (String message) {
          if (message != null && message.isNotEmpty) {
            Future.delayed(Duration(milliseconds: 200)).then(
              (value) => FLToast.showError(
                text: message,
                showDuration: ToastDuration.DEFAULT.value,
              ),
            );
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
  void initState() {
    _store ??= sl.get<DepositStore>();
    super.initState();
    _store.getPaymentType();
    _store.getPaymentPromo();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Observer(
        builder: (_) {
          switch (_store.state) {
            case DepositStoreState.loading:
              return LoadingWidget();
            case DepositStoreState.loaded:
              return DepositDisplay(store: _store);
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
