import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/pager_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/transactions/presentation/widgets/transaction_display_table.dart';

import '../data/enum/transaction_date_enum.dart';
import 'state/transaction_store.dart';
import 'widgets/transaction_display_table.dart';

class TransactionRoute extends StatefulWidget {
  @override
  _TransactionRouteState createState() => _TransactionRouteState();
}

class _TransactionRouteState extends State<TransactionRoute> {
  TransactionStore _store;
  List<ReactionDisposer> _disposers;
  CancelFunc toastDismiss;

  final GlobalKey<CustomizeDropdownWidgetState> _selectorKey =
      new GlobalKey(debugLabel: 'selector');
  final GlobalKey<TransactionDisplayTableState> contentKey =
      new GlobalKey(debugLabel: 'content');
  final GlobalKey<PagerWidgetState> pagerKey =
      new GlobalKey(debugLabel: 'pager');

  final List<TransactionDateSelected> _selectorValues = [
    TransactionDateSelected.all,
    TransactionDateSelected.today,
    TransactionDateSelected.yesterday,
    TransactionDateSelected.month,
  ];

  List<String> _selectorStrings;
  TransactionDateSelected _selected;

  void getPageData(int page) {
    if (_store == null) return;
    _store.getRecord(page: page, selection: _selected);
  }

  void _updateDropdown() {
    _selectorStrings = [
      localeStr.spinnerDateAll,
      localeStr.spinnerDateToday,
      localeStr.spinnerDateYesterday,
      localeStr.spinnerDateMonth,
    ];
  }

  @override
  void initState() {
    _store ??= sl.get<TransactionStore>();
    _updateDropdown();
    _selected = _selectorValues[0];
    super.initState();
  }

  @override
  void didUpdateWidget(TransactionRoute oldWidget) {
    _updateDropdown();
    super.didUpdateWidget(oldWidget);
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
        (String message) {
          if (message != null && message.isNotEmpty) {
            callToastError(message, delayedMilli: 200);
          }
        },
      ),
      /* Reaction on search action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForPageData,
        // Run some logic with the content of the observed field
        (bool wait) {
          debugPrint('reaction on wait transaction: $wait');
          if (wait) {
            toastDismiss = callToastLoading();
          } else if (toastDismiss != null) {
            toastDismiss();
            toastDismiss = null;
            if (_store.dataModel != null) {
              debugPrint(
                  'updating transaction record, page: ${_store.dataModel.currentPage}');
              try {
                if (_store.dataModel.total > 0) {
                  pagerKey.currentState.updateTotalPage =
                      _store.dataModel.lastPage;
                  pagerKey.currentState.updateCurrentPage =
                      _store.dataModel.currentPage;
                } else {
                  pagerKey.currentState.updateTotalPage = 0;
                }
                contentKey.currentState.updateContent = _store.dataModel.data;
              } on Exception {
                callToastError(localeStr.messageActionFailed);
              }
            }
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    if (toastDismiss != null) {
      toastDismiss();
      toastDismiss = null;
    }
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        debugPrint('pop transaction route');
        AppNavigator.back();
        return Future(() => true);
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomizeDropdownWidget(
                    key: _selectorKey,
                    horizontalInset: 16.0,
                    prefixText: localeStr.transactionViewSpinnerTitle,
                    titleLetterSpacing: 4,
                    optionValues: _selectorValues,
                    optionStrings: _selectorStrings,
                    changeNotify: (data) {
                      _selected = data;
                      debugPrint('selected: $data');
                    },
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: Global.device.comfortButtonHeight,
                        child: RaisedButton(
                          child: Text(localeStr.btnQueryNow),
                          onPressed: () => getPageData(1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 10.0),
                child: TransactionDisplayTable(contentKey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  PagerWidget(
                    pagerKey,
                    horizontalInset: 20.0,
                    onAction: (page) => getPageData(page),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
