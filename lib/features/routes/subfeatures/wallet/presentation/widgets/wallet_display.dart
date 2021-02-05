import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/res.dart';

import '../enum/wallet_type.dart';
import '../state/wallet_store.dart';
import 'wallet_dialog.dart';

class WalletDisplay extends StatefulWidget {
  final WalletStore store;

  WalletDisplay({@required this.store});

  @override
  _WalletDisplayState createState() => _WalletDisplayState();
}

class _WalletDisplayState extends State<WalletDisplay> {
  List<ReactionDisposer> _disposers;
  final GlobalKey _optionListKey = new GlobalKey(debugLabel: 'options');
  final GlobalKey _creditBoxKey = new GlobalKey(debugLabel: 'box');

  ScrollController _scrollController;
  double _heightFactor;
  double _bgHeight;
  double _bgWidth;
  double _bgMarginBottom;

  double _innerBoxMaxHeight;
  double _innerBoxMinHeight;
  bool _higherBox = false;

  String _credit;
  WalletType _selected;
  WalletType _walletType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      /* Reaction on transfer action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.waitForTransfer,
        // Run some logic with the content of the observed field
        (bool wait) {
          debugPrint('reaction on wait wallet transfer: $wait');
          if (wait == null) return;
          if (wait && widget.store.showingDialog != true) {
            widget.store.showingDialog = true;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => new WalletDialog(store: widget.store),
            );
          }
        },
      ),
      /* Reaction on wallet data change */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.wallet,
        // Run some logic with the content of the observed field
        (wallet) {
          debugPrint('reaction on wallet changed: $wallet');
          if (wallet == null) return;
          String newCredit = widget.store.wallet.credit;
          WalletType newWalletType =
              (widget.store.wallet.auto == WalletType.SINGLE.value)
                  ? WalletType.SINGLE
                  : WalletType.MULTI;
          debugPrint('new wallet type: $newWalletType, current: $_walletType');
          if (newWalletType != _walletType)
            _optionListKey.currentState.setState(() {
              _walletType = newWalletType;
            });
          if (newCredit != _credit)
            _creditBoxKey.currentState.setState(() {
              _credit = newCredit;
            });
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
    _heightFactor = Global.device.heightScale;
    if (_heightFactor < 1.0) _heightFactor = 1.0;
    // 100 = expect margin top(10)+bottom(90)
    _bgHeight = Global.device.featureContentHeight - 48;
    if (_bgHeight > 480) _bgHeight = _bgHeight / _heightFactor;
    if (_bgHeight < 442) _bgHeight = 442;
    _bgMarginBottom = Global.device.featureContentHeight - 20 - _bgHeight;

    _higherBox = !Global.lang.isChinese;
    _innerBoxMaxHeight = (_higherBox) ? _bgHeight * 0.35 : _bgHeight * 0.325;
    _innerBoxMinHeight = _innerBoxMaxHeight - 24.0;

    _bgWidth = Global.device.width - 20.0;
    if (_bgWidth > 380) _bgWidth = 380;
    debugPrint('wallet bg w$_bgWidth*h$_bgHeight');

    _credit = widget.store.wallet.credit;
    _walletType = (widget.store.wallet.auto == WalletType.SINGLE.value)
        ? WalletType.SINGLE
        : WalletType.MULTI;
    _selected = _walletType;
    super.initState();

    _scrollController = new ScrollController();
  }

  @override
  void didUpdateWidget(WalletDisplay oldWidget) {
    _credit = widget.store.wallet.credit;
    _walletType = (widget.store.wallet.auto == WalletType.SINGLE.value)
        ? WalletType.SINGLE
        : WalletType.MULTI;
    _selected = _walletType;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        ///Background Container
        constraints: BoxConstraints.tight(Size(_bgWidth, _bgHeight)),
        decoration: BoxDecoration(
          color: themeColor.dialogBgColor1,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 0.7,
              blurRadius: 3.5,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.fromLTRB(14.0, 10.0, 14.0, _bgMarginBottom),
        alignment: Alignment.topCenter,
//      child: Placeholder(),
        child: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Row(
              /// Background Top Icon
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 120, // same as icon height
                    decoration: BoxDecoration(
                      color: themeColor.walletCardBgColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Image.asset(
                      Res.wlpop_titico,
                      alignment: Alignment.topLeft,
                      fit: BoxFit.none,
                      color: themeColor.walletCardIconBgColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: _bgHeight - 24,
                      maxHeight: _bgHeight - 24,
                      maxWidth: _bgWidth - 40,
                    ),
                    child: Column(
                      /// Wallet Content
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Res.wlpop_titico_small,
                              color: themeColor.iconColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                localeStr.walletViewTitleMy,
                                style:
                                    TextStyle(fontSize: FontSize.LARGE.value),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
                          child: _buildWalletBox(),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                          child: _buildOptions(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Build wallet box content
  ///
  Widget _buildWalletBox() {
    return Container(
      constraints: BoxConstraints(
        minHeight: _innerBoxMinHeight,
        maxHeight: _innerBoxMaxHeight,
        minWidth: _bgWidth - 32,
      ),
      decoration: BoxDecoration(
        color: themeColor.walletBoxBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 0.6,
            blurRadius: 3,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /// Wallet Credit
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  child: Padding(
                    padding: (!Global.lang.isChinese)
                        ? EdgeInsets.only(bottom: 4.0)
                        : EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      localeStr.walletViewTitleRemain,
                      style:
                          TextStyle(color: themeColor.walletCreditTitleColor),
                    ),
                  ),
                ),
                if (!Global.lang.isChinese) TextSpan(text: '\n'),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 3.0),
                    child: Transform.scale(
                      scale: 0.9,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: themeColor.iconSubColor2,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            const IconData(0xf155, fontFamily: 'FontAwesome'),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () => widget.store.updateCredit(),
                    child: Text(
                      _credit,
                      style: TextStyle(
                        fontSize: FontSize.XLARGE.value,
                        fontWeight: FontWeight.bold,
                        color: themeColor.defaultAccentColor,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
                if (!Global.lang.isChinese)
                  WidgetSpan(child: SizedBox(height: 4.0)),
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(bottom: 8.0),
          //       child: Text(
          //         localeStr.walletViewTitleRemain,
          //         style: TextStyle(color: themeColor.walletCreditTitleColor),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 3.0),
          //       child: Transform.scale(
          //         scale: 0.9,
          //         child: DecoratedBox(
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: themeColor.iconSubColor2,
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(4.0),
          //             child: Icon(
          //               const IconData(0xf155, fontFamily: 'FontAwesome'),
          //               color: Colors.white,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () => widget.store.updateCredit(),
          //       child: Text(
          //         _credit,
          //         style: TextStyle(
          //           fontSize: FontSize.XLARGE.value,
          //           fontWeight: FontWeight.bold,
          //           color: themeColor.defaultAccentColor,
          //         ),
          //         overflow: TextOverflow.visible,
          //       ),
          //     ),
          //   ],
          // ),

          /// Transfer Button
          SizedBox(
            width: _bgWidth / 3,
            height: Global.device.comfortButtonHeight,
            child: RaisedButton(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              child: FittedBox(
                child: Text(
                  localeStr.walletViewButtonOneClick,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () {
                if (widget.store.waitForTransfer != true) {
                  widget.store.postWalletTransfer();
                }
              },
            ),
          ),

          /// Transfer Hint
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              localeStr.walletViewHintOneClick,
              style: TextStyle(
                  fontSize: FontSize.SMALLER.value,
                  color: themeColor.defaultHintColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Build Radio options and hints
  ///
  Widget _buildOptions() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: _bgHeight * 0.25,
        // (_bgHeight * 0.325) = wallet box
        // 64 = parent padding and items above
        // 60 = child padding and font line space
        maxHeight: _bgHeight - _innerBoxMaxHeight - 64 - 60,
      ),
      child: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: ListView.builder(
          key: _optionListKey,
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (_, index) {
            switch (index) {
              case 0:
              case 2:
                String radioLabel = (index == 0)
                    ? localeStr.walletViewTitleWalletSingle
                    : localeStr.walletViewTitleWalletMulti;
                WalletType radioValue =
                    (index == 0) ? WalletType.SINGLE : WalletType.MULTI;
                return Row(
                  /// Radio Options
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Radio(
                      visualDensity: VisualDensity.compact,
                      value: radioValue,
                      groupValue: _selected,
                      onChanged: (value) {
                        setState(() {
                          _selected = value;
                        });
                        debugPrint('selected: $_selected');
                      },
                    ),
                    Text(
                      radioLabel,
                      style: TextStyle(
                        fontSize: FontSize.TITLE.value,
                        color: (_selected == radioValue)
                            ? themeColor.defaultAccentColor
                            : themeColor.walletRadioColor,
                      ),
                    ),
                    if (_walletType == radioValue)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, left: 2.0),
                        child: Icon(
                          Icons.check_circle,
                          color: themeColor.defaultSelectableWidgetColor,
                          size: 14,
                        ),
                      )
                  ],
                );
                break;
              case 1:
              case 3:
                String radioHint = (index == 1)
                    ? localeStr.walletViewHintWalletSingle
                    : localeStr.walletViewHintWalletMulti;
                return Padding(
                  /// Radio Hints
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 36.0,
                    right: 6.0,
                  ),
                  child: Text(
                    radioHint,
                    style: TextStyle(
                      color: themeColor.defaultHintSubColor,
                    ),
                  ),
                );
                break;
              case 4:
                return Row(
                  /// Action Button
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        width: _bgWidth / 3,
                        height: Global.device.comfortButtonHeight,
                        child: RaisedButton(
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          child: Text(localeStr.btnConfirm),
                          onPressed: () {
                            if (widget.store.waitForTypeChange) {
                              callToast(localeStr.messageWait);
                            } else if (_walletType != _selected) {
                              if (_selected == WalletType.SINGLE)
                                widget.store.postWalletType(true);
                              else
                                widget.store.postWalletType(false);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                );
                break;
              default:
                return SizedBox.shrink();
                break;
            }
          },
        ),
      ),
    );
  }
}
