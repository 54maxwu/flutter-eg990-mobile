import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/sector/wallet/wallet_type.dart';
import 'package:flutter_eg990_mobile/presentation/common/settings/settings_ui.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_display_widget.dart';

import '../state/transfer_store.dart';

class TransferDisplay extends StatefulWidget {
  final TransferStore store;

  TransferDisplay(this.store);

  @override
  _TransferDisplayState createState() => _TransferDisplayState();
}

class _TransferDisplayState extends State<TransferDisplay> {
  Timer _postRequestTimer;
  bool _wait = false;

  bool _singleWallet;

  void _startLockTimer() {
    _postRequestTimer?.cancel();
    _postRequestTimer = null;
    _postRequestTimer = Timer(Duration(milliseconds: 1000), () {
      if (_wait) return;
      setState(() {
        _wait = true;
      });
      bool singleWallet = _singleWallet;
      widget.store.postWalletType(singleWallet).whenComplete(
            () => setState(() {
              _singleWallet = _singleWallet;
              _wait = false;
            }),
          );
    });
  }

  @override
  void initState() {
    _singleWallet = widget.store.walletType == WalletType.SINGLE;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeColor.defaultCardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SettingsTile.switchTile(
                title: localeStr.walletViewTitleWalletSingle,
                titleTextStyle: TextStyle(
                  fontSize: FontSize.SUBTITLE.value,
                  fontWeight: FontWeight.w600,
                  color: themeColor.defaultTitleColor,
                ),
                switchValue: _singleWallet,
                enabled: !_wait,
                onToggle: (bool value) {
                  setState(() {
                    _singleWallet = value;
                  });
                  _startLockTimer();
                },
              ),
              if (_wait)
                Positioned(
                  top: FontSize.SUBTITLE.value,
                  right: 84.0,
                  child: Container(
                    height: FontSize.SUBTITLE.value,
                    width: FontSize.SUBTITLE.value,
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            child: Text(
              localeStr.walletViewHintWalletType,
              style: TextStyle(color: themeColor.defaultHintColor),
            ),
          ),
        ],
      ),
    );
  }
}
