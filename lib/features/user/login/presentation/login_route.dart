import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/dialog_widget.dart';

import 'state/login_store.dart';
import 'widgets/login_display.dart';

class LoginRoute extends StatefulWidget {
  final bool returnHomeAfterLogin;
  final bool isDialog;

  LoginRoute({
    this.returnHomeAfterLogin = false,
    this.isDialog = false,
  });

  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  LoginStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<LoginStore>();
    super.initState();
    // execute action on init
    _store.initBox();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.errorMessage,
        // Run some logic with the content of the observed field
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
    try {
      _store.close();
      _disposers.forEach((d) => d());
    } on Exception {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(
        // Observe using specific widget
        builder: (_) {
          switch (_store.state) {
            case LoginStoreState.loading:
              return LoadingWidget();
            case LoginStoreState.loaded:
              return (widget.isDialog)
                  ? DialogWidget(
                      children: [
                        LoginDisplay(
                          _store,
                          widget.returnHomeAfterLogin,
                          widget.isDialog,
                        ),
                      ],
                    )
                  : LoginDisplay(
                      _store,
                      widget.returnHomeAfterLogin,
                      widget.isDialog,
                    );
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
