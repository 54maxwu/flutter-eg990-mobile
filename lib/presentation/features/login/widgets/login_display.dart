import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_display_widget.dart';

import '../state/login_store.dart';
import 'login_form_widget.dart';
import 'login_navigate_dialog.dart';

class LoginDisplay extends StatefulWidget {
  final LoginStore store;

  LoginDisplay(this.store);

  @override
  _LoginDisplayState createState() => _LoginDisplayState();
}

class _LoginDisplayState extends State<LoginDisplay> {
  final GlobalKey<LoginFormWidgetState> _formWidgetKey =
      new GlobalKey(debugLabel: 'loginForm');

  List<ReactionDisposer> _disposers;
  CancelFunc _toast;
  Widget _formWidget;

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.loginState,
        // Run some logic with the content of the observed field
        (LoginState state) {
          if (_toast != null) {
            _toast();
            _toast = null;
          }
          switch (state) {
            case LoginState.loading:
              _toast = callToastLoading(
                  message: localeStr.messageWait, clickClose: false);
              break;
            case LoginState.complete:
              Future.delayed(Duration(milliseconds: 200), () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => LoginNavigateDialog(
                    username: widget.store.lastUser,
                  ),
                );
              });
              break;
            case LoginState.initial:
            case LoginState.failed:
              debugPrint('login state: $state');
              break;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _formWidget ??= LoginFormWidget(
      key: _formWidgetKey,
      historyForm: widget.store.hiveLoginForm,
      onRequestLogin: (form) => widget.store.login(form),
      callInitComplete: () => widget.store.cleanHistoryData(),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: _formWidget,
    );
  }
}
