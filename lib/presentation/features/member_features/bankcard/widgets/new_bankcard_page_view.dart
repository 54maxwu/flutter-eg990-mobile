import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_form.dart';
import 'package:flutter_eg990_mobile/domain/sector/bankcard/bankcard_form_data.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/common/toast/toast_text.dart';

import 'bankcard_display_provider.dart';
import 'new_bankcard_page_1.dart';
import 'new_bankcard_page_2.dart';

class NewBankcardPageView extends StatefulWidget {
  @override
  _NewBankcardPageViewState createState() => _NewBankcardPageViewState();
}

class _NewBankcardPageViewState extends State<NewBankcardPageView>
    with SingleTickerProviderStateMixin {
  final Key _pageViewKey = new UniqueKey();

  PageController _pageController;

  BankcardNewData _cardInfo = BankcardNewData.pure();
  BankcardNewAddress _bankAddress = BankcardNewAddress.pure();
  BankcardNewMobile _mobile = BankcardNewMobile.pure();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    try {
      // if (_tabController != null) _tabController.dispose();
      _pageController?.dispose();
    } catch (e) {
      MyLogger.debug(
        msg: 'dispose bankcard controller has exception: $e',
        tag: "GamesPage",
      );
    }
    super.dispose();
  }

  void _animateToPage(int pageIndex) => _pageController.animateToPage(pageIndex,
      duration: Duration(milliseconds: 300), curve: Curves.easeIn);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageController.page > 0) {
          debugPrint('current bankcard step page: ${_pageController.page}');
          return Future(() => false);
        } else {
          debugPrint('pop bankcard step page');
          return Future(() => true);
        }
      },
      child: Scaffold(
        backgroundColor: themeColor.defaultLayeredBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: PageView(
            key: _pageViewKey,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              NewBankcardPageOne(
                onTapForward: (bankcard) {
                  _cardInfo = bankcard;
                  _animateToPage(1);
                },
                onCancel: () {},
              ),
              NewBankcardPageTwo(
                onTapForward: (address) {
                  _bankAddress = address;
                  // _animateToPage(2);
                  final form = BankcardForm(
                    cardInfo: _cardInfo,
                    bankAddress: _bankAddress,
                    mobile: _mobile,
                  );
                  if (form.validate.isRight()) {
                    debugPrint('bankcard form is valid');
                    context
                        .read<BankcardDisplayProvider>()
                        .store
                        .postNewCard(form);
                  } else if (form.status.index == 0) {
                    callToast(localeStr.msgFormNotFilled);
                  } else {
                    debugPrint(
                        'bankcard form error: ${form.validate.getOrElse(() => null)}');
                  }
                },
                onTapBackward: () => _animateToPage(0),
              ),
              // NewBankcardPageThree(
              //   onConfirm: (mobile) {
              //     _mobile = mobile;
              //     final form = BankcardForm(
              //       cardInfo: _cardInfo,
              //       bankAddress: _bankAddress,
              //       mobile: _mobile,
              //     );
              //     debugPrint('new bankcard form: $form');
              //   },
              //   onTapBackward: () => _animateToPage(1),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
