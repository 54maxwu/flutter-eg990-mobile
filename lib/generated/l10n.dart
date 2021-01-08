// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Press again to close the app {cnt}`
  String appExitHint(Object cnt) {
    return Intl.message(
      'Press again to close the app $cnt',
      name: 'appExitHint',
      desc: '',
      args: [cnt],
    );
  }

  /// `{count, plural, =0{Hello}=1{Hello World}=2{Hello both Worlds}few{Hello {count} worlds}many{Hello all {count} worlds}other{Hello other {count} worlds}}`
  String appPluralExample(num count) {
    return Intl.plural(
      count,
      zero: 'Hello',
      one: 'Hello World',
      two: 'Hello both Worlds',
      few: 'Hello $count worlds',
      many: 'Hello all $count worlds',
      other: 'Hello other $count worlds',
      name: 'appPluralExample',
      desc: 'test flutter plural',
      args: [count],
    );
  }

  /// `Dark`
  String get appThemeColorDark {
    return Intl.message(
      'Dark',
      name: 'appThemeColorDark',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get appThemeColorDefault {
    return Intl.message(
      'Default',
      name: 'appThemeColorDefault',
      desc: '',
      args: [],
    );
  }

  /// `Choose theme color`
  String get appThemeColorHintSelect {
    return Intl.message(
      'Choose theme color',
      name: 'appThemeColorHintSelect',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get appThemeColorLight {
    return Intl.message(
      'Light',
      name: 'appThemeColorLight',
      desc: '',
      args: [],
    );
  }

  /// `Yabo Mobile`
  String get appTitle {
    return Intl.message(
      'Yabo Mobile',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Version {value}`
  String appVersion(Object value) {
    return Intl.message(
      'Version $value',
      name: 'appVersion',
      desc: '',
      args: [value],
    );
  }

  /// `Back`
  String get btnBack {
    return Intl.message(
      'Back',
      name: 'btnBack',
      desc: '',
      args: [],
    );
  }

  /// `Bind`
  String get btnBind {
    return Intl.message(
      'Bind',
      name: 'btnBind',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get btnCancel {
    return Intl.message(
      'Cancel',
      name: 'btnCancel',
      desc: '',
      args: [],
    );
  }

  /// `Tap Image to refresh`
  String get btnClickImageToRefresh {
    return Intl.message(
      'Tap Image to refresh',
      name: 'btnClickImageToRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Click me to bind`
  String get btnClickToBind {
    return Intl.message(
      'Click me to bind',
      name: 'btnClickToBind',
      desc: '',
      args: [],
    );
  }

  /// `Click me to download`
  String get btnClickToDownload {
    return Intl.message(
      'Click me to download',
      name: 'btnClickToDownload',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get btnClose {
    return Intl.message(
      'Close',
      name: 'btnClose',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get btnConfirm {
    return Intl.message(
      'Confirm',
      name: 'btnConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Confirm and send`
  String get btnConfirmSend {
    return Intl.message(
      'Confirm and send',
      name: 'btnConfirmSend',
      desc: '',
      args: [],
    );
  }

  /// `Confirm transfer`
  String get btnConfirmTransfer {
    return Intl.message(
      'Confirm transfer',
      name: 'btnConfirmTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get btnCopy {
    return Intl.message(
      'Copy',
      name: 'btnCopy',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get btnDownload {
    return Intl.message(
      'Download',
      name: 'btnDownload',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get btnEdit {
    return Intl.message(
      'Edit',
      name: 'btnEdit',
      desc: '',
      args: [],
    );
  }

  /// `Go to`
  String get btnForwardTo {
    return Intl.message(
      'Go to',
      name: 'btnForwardTo',
      desc: '',
      args: [],
    );
  }

  /// `Next step`
  String get btnNextStep {
    return Intl.message(
      'Next step',
      name: 'btnNextStep',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get btnOpen {
    return Intl.message(
      'Open',
      name: 'btnOpen',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get btnPreStep {
    return Intl.message(
      'Previous',
      name: 'btnPreStep',
      desc: '',
      args: [],
    );
  }

  /// `Inquire`
  String get btnQuery {
    return Intl.message(
      'Inquire',
      name: 'btnQuery',
      desc: '',
      args: [],
    );
  }

  /// `Enquire now`
  String get btnQueryNow {
    return Intl.message(
      'Enquire now',
      name: 'btnQueryNow',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get btnRefresh {
    return Intl.message(
      'Refresh',
      name: 'btnRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Forget password`
  String get btnResetPassword {
    return Intl.message(
      'Forget password',
      name: 'btnResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get btnSearch {
    return Intl.message(
      'Search',
      name: 'btnSearch',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get btnSend {
    return Intl.message(
      'Send',
      name: 'btnSend',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get btnSendOut {
    return Intl.message(
      'Send',
      name: 'btnSendOut',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get btnShow {
    return Intl.message(
      'Show',
      name: 'btnShow',
      desc: '',
      args: [],
    );
  }

  /// `Sign in now`
  String get btnSignUp {
    return Intl.message(
      'Sign in now',
      name: 'btnSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get btnSubmit {
    return Intl.message(
      'Submit',
      name: 'btnSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get btnSwitchOff {
    return Intl.message(
      'Off',
      name: 'btnSwitchOff',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get btnSwitchOn {
    return Intl.message(
      'On',
      name: 'btnSwitchOn',
      desc: '',
      args: [],
    );
  }

  /// `Transfer to`
  String get btnTransferIn {
    return Intl.message(
      'Transfer to',
      name: 'btnTransferIn',
      desc: '',
      args: [],
    );
  }

  /// `Transfer from`
  String get btnTransferOut {
    return Intl.message(
      'Transfer from',
      name: 'btnTransferOut',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get btnUpdate {
    return Intl.message(
      'Update',
      name: 'btnUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Bind email to protect account security`
  String get centerHintEMail {
    return Intl.message(
      'Bind email to protect account security',
      name: 'centerHintEMail',
      desc: '',
      args: [],
    );
  }

  /// `The name must be the same as the name of the bank card holder, otherwise the withdrawal will not be possible`
  String get centerHintMemberName {
    return Intl.message(
      'The name must be the same as the name of the bank card holder, otherwise the withdrawal will not be possible',
      name: 'centerHintMemberName',
      desc: '',
      args: [],
    );
  }

  /// `Please go to bind the bank card to make relevant settings`
  String get centerHintNoName {
    return Intl.message(
      'Please go to bind the bank card to make relevant settings',
      name: 'centerHintNoName',
      desc: '',
      args: [],
    );
  }

  /// `For your privacy, the information cannot be modified after confirmation\nIf you need assistance, please contact customer service`
  String get centerHintPrivacyEdit {
    return Intl.message(
      'For your privacy, the information cannot be modified after confirmation\nIf you need assistance, please contact customer service',
      name: 'centerHintPrivacyEdit',
      desc: '',
      args: [],
    );
  }

  /// `personal information`
  String get centerTabMemberData {
    return Intl.message(
      'personal information',
      name: 'centerTabMemberData',
      desc: '',
      args: [],
    );
  }

  /// `VIP class`
  String get centerTabVipRank {
    return Intl.message(
      'VIP class',
      name: 'centerTabVipRank',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get centerTextHeadPhoto {
    return Intl.message(
      'Profile',
      name: 'centerTextHeadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get certificateTitle {
    return Intl.message(
      'License',
      name: 'certificateTitle',
      desc: '',
      args: [],
    );
  }

  /// `British Virgin Islands (BVI) certification`
  String get certificateTitleBVI {
    return Intl.message(
      'British Virgin Islands (BVI) certification',
      name: 'certificateTitleBVI',
      desc: '',
      args: [],
    );
  }

  /// `British GC Oversight Committee`
  String get certificateTitleGC {
    return Intl.message(
      'British GC Oversight Committee',
      name: 'certificateTitleGC',
      desc: '',
      args: [],
    );
  }

  /// `Malta Gaming License (MGA) Certification`
  String get certificateTitleMGA {
    return Intl.message(
      'Malta Gaming License (MGA) Certification',
      name: 'certificateTitleMGA',
      desc: '',
      args: [],
    );
  }

  /// `The Philippines (PAGCOR) Supervises Gaming Cards`
  String get certificateTitlePGC {
    return Intl.message(
      'The Philippines (PAGCOR) Supervises Gaming Cards',
      name: 'certificateTitlePGC',
      desc: '',
      args: [],
    );
  }

  /// `Adjust deposit`
  String get dealsDetailTypeAdjustDeposit {
    return Intl.message(
      'Adjust deposit',
      name: 'dealsDetailTypeAdjustDeposit',
      desc: '',
      args: [],
    );
  }

  /// `Adjust withdrawal`
  String get dealsDetailTypeAdjustWithdraw {
    return Intl.message(
      'Adjust withdrawal',
      name: 'dealsDetailTypeAdjustWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Please contact customer service for deposit target account information`
  String get depositHintGetInfoFromCs {
    return Intl.message(
      'Please contact customer service for deposit target account information',
      name: 'depositHintGetInfoFromCs',
      desc: '',
      args: [],
    );
  }

  /// `please fill in the bank card information first`
  String get depositHintNoBankcard {
    return Intl.message(
      'please fill in the bank card information first',
      name: 'depositHintNoBankcard',
      desc: '',
      args: [],
    );
  }

  /// `Single maximum limit: {value}`
  String depositHintOrderMaxAmount(Object value) {
    return Intl.message(
      'Single maximum limit: $value',
      name: 'depositHintOrderMaxAmount',
      desc: '',
      args: [value],
    );
  }

  /// `Check that there is no recharge method available`
  String get depositPaymentNoData {
    return Intl.message(
      'Check that there is no recharge method available',
      name: 'depositPaymentNoData',
      desc: '',
      args: [],
    );
  }

  /// `Ali Pay`
  String get depositPaymentTitleAli {
    return Intl.message(
      'Ali Pay',
      name: 'depositPaymentTitleAli',
      desc: '',
      args: [],
    );
  }

  /// `Online Transfer`
  String get depositPaymentTitleAtm {
    return Intl.message(
      'Online Transfer',
      name: 'depositPaymentTitleAtm',
      desc: '',
      args: [],
    );
  }

  /// `Bank Deposit`
  String get depositPaymentTitleBank {
    return Intl.message(
      'Bank Deposit',
      name: 'depositPaymentTitleBank',
      desc: '',
      args: [],
    );
  }

  /// `CG Pay`
  String get depositPaymentTitleCgp {
    return Intl.message(
      'CG Pay',
      name: 'depositPaymentTitleCgp',
      desc: '',
      args: [],
    );
  }

  /// `JD Pay`
  String get depositPaymentTitleJd {
    return Intl.message(
      'JD Pay',
      name: 'depositPaymentTitleJd',
      desc: '',
      args: [],
    );
  }

  /// `Online Payment`
  String get depositPaymentTitleOnline {
    return Intl.message(
      'Online Payment',
      name: 'depositPaymentTitleOnline',
      desc: '',
      args: [],
    );
  }

  /// `QR Pay`
  String get depositPaymentTitleQr {
    return Intl.message(
      'QR Pay',
      name: 'depositPaymentTitleQr',
      desc: '',
      args: [],
    );
  }

  /// `Quick Pay(Recommend)`
  String get depositPaymentTitleQuick {
    return Intl.message(
      'Quick Pay(Recommend)',
      name: 'depositPaymentTitleQuick',
      desc: '',
      args: [],
    );
  }

  /// `Union Pay`
  String get depositPaymentTitleUnion {
    return Intl.message(
      'Union Pay',
      name: 'depositPaymentTitleUnion',
      desc: '',
      args: [],
    );
  }

  /// `WeChat Pay`
  String get depositPaymentTitleWechat {
    return Intl.message(
      'WeChat Pay',
      name: 'depositPaymentTitleWechat',
      desc: '',
      args: [],
    );
  }

  /// `Confirm {action} {platform} platform?`
  String dialogTextTransferActionTo(Object action, Object platform) {
    return Intl.message(
      'Confirm $action $platform platform?',
      name: 'dialogTextTransferActionTo',
      desc: '',
      args: [action, platform],
    );
  }

  /// `Confirm information`
  String get dialogTitleConfirmInfo {
    return Intl.message(
      'Confirm information',
      name: 'dialogTitleConfirmInfo',
      desc: '',
      args: [],
    );
  }

  /// `Account error`
  String get errorAccount {
    return Intl.message(
      'Account error',
      name: 'errorAccount',
      desc: '',
      args: [],
    );
  }

  /// `The account is locked, please contact customer service`
  String get errorAccountLocked {
    return Intl.message(
      'The account is locked, please contact customer service',
      name: 'errorAccountLocked',
      desc: '',
      args: [],
    );
  }

  /// `Invalid operation`
  String get errorActionFailed {
    return Intl.message(
      'Invalid operation',
      name: 'errorActionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Request too frequent`
  String get errorActionTooFrequent {
    return Intl.message(
      'Request too frequent',
      name: 'errorActionTooFrequent',
      desc: '',
      args: [],
    );
  }

  /// `Cached data error, please try again later or contact customer service`
  String get errorCachedFile {
    return Intl.message(
      'Cached data error, please try again later or contact customer service',
      name: 'errorCachedFile',
      desc: '',
      args: [],
    );
  }

  /// `Recharge failed, please try again later or contact customer service`
  String get errorDeposit {
    return Intl.message(
      'Recharge failed, please try again later or contact customer service',
      name: 'errorDeposit',
      desc: '',
      args: [],
    );
  }

  /// `Unable to get the sign-in activity data, please try again later or contact customer service`
  String get errorEvent {
    return Intl.message(
      'Unable to get the sign-in activity data, please try again later or contact customer service',
      name: 'errorEvent',
      desc: '',
      args: [],
    );
  }

  /// `Game access denied, please contact customer service`
  String get errorGameAccessPermission {
    return Intl.message(
      'Game access denied, please contact customer service',
      name: 'errorGameAccessPermission',
      desc: '',
      args: [],
    );
  }

  /// `Bank card has been bound`
  String get errorHaveBoundCard {
    return Intl.message(
      'Bank card has been bound',
      name: 'errorHaveBoundCard',
      desc: '',
      args: [],
    );
  }

  /// `Internal error, please try again later or contact customer service`
  String get errorInternal {
    return Intl.message(
      'Internal error, please try again later or contact customer service',
      name: 'errorInternal',
      desc: '',
      args: [],
    );
  }

  /// `Below the minimum withdrawal amount`
  String get errorInvalidAmountBelowLimit {
    return Intl.message(
      'Below the minimum withdrawal amount',
      name: 'errorInvalidAmountBelowLimit',
      desc: '',
      args: [],
    );
  }

  /// `Exceed account balance`
  String get errorInvalidAmountExceedRemain {
    return Intl.message(
      'Exceed account balance',
      name: 'errorInvalidAmountExceedRemain',
      desc: '',
      args: [],
    );
  }

  /// `The recharge amount exceeds the upper limit`
  String get errorInvalidDepositAmountMaxLimit {
    return Intl.message(
      'The recharge amount exceeds the upper limit',
      name: 'errorInvalidDepositAmountMaxLimit',
      desc: '',
      args: [],
    );
  }

  /// `The recharge amount is below the lower limit`
  String get errorInvalidDepositAmountMinLimit {
    return Intl.message(
      'The recharge amount is below the lower limit',
      name: 'errorInvalidDepositAmountMinLimit',
      desc: '',
      args: [],
    );
  }

  /// `Exceeds the single maximum withdrawal amount (please refer to the membership level system)`
  String get errorInvalidExceedOrderAmount {
    return Intl.message(
      'Exceeds the single maximum withdrawal amount (please refer to the membership level system)',
      name: 'errorInvalidExceedOrderAmount',
      desc: '',
      args: [],
    );
  }

  /// `Wrong phone number`
  String get errorInvalidMobile {
    return Intl.message(
      'Wrong phone number',
      name: 'errorInvalidMobile',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get errorInvalidPassword {
    return Intl.message(
      'Wrong password',
      name: 'errorInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `The password does not match, the account will be locked for five errors`
  String get errorInvalidPasswordFive {
    return Intl.message(
      'The password does not match, the account will be locked for five errors',
      name: 'errorInvalidPasswordFive',
      desc: '',
      args: [],
    );
  }

  /// `Invalid referral code`
  String get errorInvalidReferral {
    return Intl.message(
      'Invalid referral code',
      name: 'errorInvalidReferral',
      desc: '',
      args: [],
    );
  }

  /// `The password does not match (the default value is the login password)`
  String get errorInvalidWithdrawPassword {
    return Intl.message(
      'The password does not match (the default value is the login password)',
      name: 'errorInvalidWithdrawPassword',
      desc: '',
      args: [],
    );
  }

  /// `There was an error loading the game, please try again later`
  String get errorLoadingGame {
    return Intl.message(
      'There was an error loading the game, please try again later',
      name: 'errorLoadingGame',
      desc: '',
      args: [],
    );
  }

  /// `Page loading error, please try again later`
  String get errorLoadingPayUrl {
    return Intl.message(
      'Page loading error, please try again later',
      name: 'errorLoadingPayUrl',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get errorLoginFailed {
    return Intl.message(
      'Login failed',
      name: 'errorLoginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate phone number registration`
  String get errorMobileAlreadyRegistered {
    return Intl.message(
      'Duplicate phone number registration',
      name: 'errorMobileAlreadyRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Unable to connect to the server!!`
  String get errorNoServerConnection {
    return Intl.message(
      'Unable to connect to the server!!',
      name: 'errorNoServerConnection',
      desc: '',
      args: [],
    );
  }

  /// `The selected platform is currently unable to transfer funds`
  String get errorPlatformTransferNotAvailable {
    return Intl.message(
      'The selected platform is currently unable to transfer funds',
      name: 'errorPlatformTransferNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get errorRegisterFailed {
    return Intl.message(
      'Registration failed',
      name: 'errorRegisterFailed',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate account registration`
  String get errorRegisterRepeatAccount {
    return Intl.message(
      'Duplicate account registration',
      name: 'errorRegisterRepeatAccount',
      desc: '',
      args: [],
    );
  }

  /// `Server data error, please try again later or contact customer service`
  String get errorServerData {
    return Intl.message(
      'Server data error, please try again later or contact customer service',
      name: 'errorServerData',
      desc: '',
      args: [],
    );
  }

  /// `Error: {msg}`
  String errorStatus(Object msg) {
    return Intl.message(
      'Error: $msg',
      name: 'errorStatus',
      desc: '',
      args: [msg],
    );
  }

  /// `Error: (msg) ((msg2))`
  String errorStatusCause(Object msg, Object msg2) {
    return Intl.message(
      'Error: (msg) ((msg2))',
      name: 'errorStatusCause',
      desc: '',
      args: [msg, msg2],
    );
  }

  /// `{msg} failed`
  String errorTaskFailed(Object msg) {
    return Intl.message(
      '$msg failed',
      name: 'errorTaskFailed',
      desc: '',
      args: [msg],
    );
  }

  /// `The network timed out, please try again later`
  String get errorTimeoutError {
    return Intl.message(
      'The network timed out, please try again later',
      name: 'errorTimeoutError',
      desc: '',
      args: [],
    );
  }

  /// `User verification failed, please log in again or contact customer service`
  String get errorToken {
    return Intl.message(
      'User verification failed, please log in again or contact customer service',
      name: 'errorToken',
      desc: '',
      args: [],
    );
  }

  /// `Transfer failed`
  String get errorTransfer {
    return Intl.message(
      'Transfer failed',
      name: 'errorTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal failed`
  String get errorWithdraw {
    return Intl.message(
      'Withdrawal failed',
      name: 'errorWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get fieldActionChangePassword {
    return Intl.message(
      'Change Password',
      name: 'fieldActionChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Get Verification Code`
  String get fieldActionGetVerifyCode {
    return Intl.message(
      'Get Verification Code',
      name: 'fieldActionGetVerifyCode',
      desc: '',
      args: [],
    );
  }

  /// `Receive promotion information`
  String get fieldCheckBoxPromoNews {
    return Intl.message(
      'Receive promotion information',
      name: 'fieldCheckBoxPromoNews',
      desc: '',
      args: [],
    );
  }

  /// `Remember login info`
  String get fieldCheckBoxSaveLogin {
    return Intl.message(
      'Remember login info',
      name: 'fieldCheckBoxSaveLogin',
      desc: '',
      args: [],
    );
  }

  /// `Do not show again`
  String get fieldCheckBoxStopShowing {
    return Intl.message(
      'Do not show again',
      name: 'fieldCheckBoxStopShowing',
      desc: '',
      args: [],
    );
  }

  /// `Have read and agree to the betting rules of the "Terms and Conditions"`
  String get fieldCheckBoxTerms {
    return Intl.message(
      'Have read and agree to the betting rules of the "Terms and Conditions"',
      name: 'fieldCheckBoxTerms',
      desc: '',
      args: [],
    );
  }

  /// `Max`
  String get fieldChipAmountAll {
    return Intl.message(
      'Max',
      name: 'fieldChipAmountAll',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect account name`
  String get fieldErrorCardAccountName {
    return Intl.message(
      'Incorrect account name',
      name: 'fieldErrorCardAccountName',
      desc: '',
      args: [],
    );
  }

  /// `The card number is {min}~{max} characters`
  String fieldErrorCardNumber(Object min, Object max) {
    return Intl.message(
      'The card number is $min~$max characters',
      name: 'fieldErrorCardNumber',
      desc: '',
      args: [min, max],
    );
  }

  /// `The card number is {min}~{max} characters (beginning with {fixed})`
  String fieldErrorCardNumberFixed(Object min, Object max, Object fixed) {
    return Intl.message(
      'The card number is $min~$max characters (beginning with $fixed)',
      name: 'fieldErrorCardNumberFixed',
      desc: '',
      args: [min, max, fixed],
    );
  }

  /// `Cardholder name is wrong`
  String get fieldErrorCardOwner {
    return Intl.message(
      'Cardholder name is wrong',
      name: 'fieldErrorCardOwner',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get fieldErrorConfirmPassword {
    return Intl.message(
      'Password does not match',
      name: 'fieldErrorConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `The account number is {min}~{max} lowercase English/Numbers`
  String fieldErrorInvalidAccount(Object min, Object max) {
    return Intl.message(
      'The account number is $min~$max lowercase English/Numbers',
      name: 'fieldErrorInvalidAccount',
      desc: '',
      args: [min, max],
    );
  }

  /// `Amount entered incorrectly`
  String get fieldErrorInvalidCreditAmount {
    return Intl.message(
      'Amount entered incorrectly',
      name: 'fieldErrorInvalidCreditAmount',
      desc: '',
      args: [],
    );
  }

  /// `The maximum amount is {num}`
  String fieldErrorInvalidCreditMax(Object num) {
    return Intl.message(
      'The maximum amount is $num',
      name: 'fieldErrorInvalidCreditMax',
      desc: '',
      args: [num],
    );
  }

  /// `The minimum amount is {num}`
  String fieldErrorInvalidCreditMin(Object num) {
    return Intl.message(
      'The minimum amount is $num',
      name: 'fieldErrorInvalidCreditMin',
      desc: '',
      args: [num],
    );
  }

  /// `Please enter the correct date (format: New Year – Month – Day)`
  String get fieldErrorInvalidDate {
    return Intl.message(
      'Please enter the correct date (format: New Year – Month – Day)',
      name: 'fieldErrorInvalidDate',
      desc: '',
      args: [],
    );
  }

  /// `Wrong time range`
  String get fieldErrorInvalidDateRange {
    return Intl.message(
      'Wrong time range',
      name: 'fieldErrorInvalidDateRange',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the correct email address`
  String get fieldErrorInvalidEmail {
    return Intl.message(
      'Please enter the correct email address',
      name: 'fieldErrorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Input format error`
  String get fieldErrorInvalidFormat {
    return Intl.message(
      'Input format error',
      name: 'fieldErrorInvalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `Contains illegal characters`
  String get fieldErrorInvalidInput {
    return Intl.message(
      'Contains illegal characters',
      name: 'fieldErrorInvalidInput',
      desc: '',
      args: [],
    );
  }

  /// `Password should be {min}~{max} characters`
  String fieldErrorInvalidPassword(Object min, Object max) {
    return Intl.message(
      'Password should be $min~$max characters',
      name: 'fieldErrorInvalidPassword',
      desc: '',
      args: [min, max],
    );
  }

  /// `Phone format error ({num} code)`
  String fieldErrorInvalidPhone(Object num) {
    return Intl.message(
      'Phone format error ($num code)',
      name: 'fieldErrorInvalidPhone',
      desc: '',
      args: [num],
    );
  }

  /// `Phone format error ({min}~{max} code)`
  String fieldErrorInvalidPhone2(Object min, Object max) {
    return Intl.message(
      'Phone format error ($min~$max code)',
      name: 'fieldErrorInvalidPhone2',
      desc: '',
      args: [min, max],
    );
  }

  /// `Incorrect postal code (5~8 codes)`
  String get fieldErrorInvalidPostCode {
    return Intl.message(
      'Incorrect postal code (5~8 codes)',
      name: 'fieldErrorInvalidPostCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter verification code`
  String get fieldErrorInvalidVerify {
    return Intl.message(
      'Please enter verification code',
      name: 'fieldErrorInvalidVerify',
      desc: '',
      args: [],
    );
  }

  /// `Wechat format error`
  String get fieldErrorInvalidWechat {
    return Intl.message(
      'Wechat format error',
      name: 'fieldErrorInvalidWechat',
      desc: '',
      args: [],
    );
  }

  /// `Zalo format error`
  String get fieldErrorInvalidZalo {
    return Intl.message(
      'Zalo format error',
      name: 'fieldErrorInvalidZalo',
      desc: '',
      args: [],
    );
  }

  /// `It is recommended that you deposit a special amount so that it can be matched quickly (for example: 105, 503, etc.)`
  String get fieldHintAmount {
    return Intl.message(
      'It is recommended that you deposit a special amount so that it can be matched quickly (for example: 105, 503, etc.)',
      name: 'fieldHintAmount',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the birthday date to ensure that you are of legal age`
  String get fieldHintBirthday {
    return Intl.message(
      'Fill in the birthday date to ensure that you are of legal age',
      name: 'fieldHintBirthday',
      desc: '',
      args: [],
    );
  }

  /// `The format is: 0000–00–00`
  String get fieldHintDateFormat {
    return Intl.message(
      'The format is: 0000–00–00',
      name: 'fieldHintDateFormat',
      desc: '',
      args: [],
    );
  }

  /// `amount range: {num}~{num2}`
  String fieldHintDepositAmountRange(Object num, Object num2) {
    return Intl.message(
      'amount range: $num~$num2',
      name: 'fieldHintDepositAmountRange',
      desc: '',
      args: [num, num2],
    );
  }

  /// `The amount is a multiple of {step}`
  String fieldHintDepositAmountStep(Object step) {
    return Intl.message(
      'The amount is a multiple of $step',
      name: 'fieldHintDepositAmountStep',
      desc: '',
      args: [step],
    );
  }

  /// `please enter your bank account`
  String get fieldHintDepositBankAccount {
    return Intl.message(
      'please enter your bank account',
      name: 'fieldHintDepositBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `please fill in the transaction code`
  String get fieldHintDepositCode {
    return Intl.message(
      'please fill in the transaction code',
      name: 'fieldHintDepositCode',
      desc: '',
      args: [],
    );
  }

  /// `please enter the account owner's name`
  String get fieldHintDepositName {
    return Intl.message(
      'please enter the account owner\'s name',
      name: 'fieldHintDepositName',
      desc: '',
      args: [],
    );
  }

  /// `please enter your account`
  String get fieldHintInputAccount {
    return Intl.message(
      'please enter your account',
      name: 'fieldHintInputAccount',
      desc: '',
      args: [],
    );
  }

  /// `please enter confirm password`
  String get fieldHintInputConfirmedPassword {
    return Intl.message(
      'please enter confirm password',
      name: 'fieldHintInputConfirmedPassword',
      desc: '',
      args: [],
    );
  }

  /// `please enter your email`
  String get fieldHintInputEmail {
    return Intl.message(
      'please enter your email',
      name: 'fieldHintInputEmail',
      desc: '',
      args: [],
    );
  }

  /// `please enter user name`
  String get fieldHintInputName {
    return Intl.message(
      'please enter user name',
      name: 'fieldHintInputName',
      desc: '',
      args: [],
    );
  }

  /// `please enter password`
  String get fieldHintInputPassword {
    return Intl.message(
      'please enter password',
      name: 'fieldHintInputPassword',
      desc: '',
      args: [],
    );
  }

  /// `enter the password again`
  String get fieldHintInputPasswordAgain {
    return Intl.message(
      'enter the password again',
      name: 'fieldHintInputPasswordAgain',
      desc: '',
      args: [],
    );
  }

  /// `please enter your phone number`
  String get fieldHintInputPhone {
    return Intl.message(
      'please enter your phone number',
      name: 'fieldHintInputPhone',
      desc: '',
      args: [],
    );
  }

  /// `please enter the referral code`
  String get fieldHintInputReferralCode {
    return Intl.message(
      'please enter the referral code',
      name: 'fieldHintInputReferralCode',
      desc: '',
      args: [],
    );
  }

  /// `please enter the phone verification code`
  String get fieldHintMobileVerifyCode {
    return Intl.message(
      'please enter the phone verification code',
      name: 'fieldHintMobileVerifyCode',
      desc: '',
      args: [],
    );
  }

  /// `please enter a new password`
  String get fieldHintPasswordNew {
    return Intl.message(
      'please enter a new password',
      name: 'fieldHintPasswordNew',
      desc: '',
      args: [],
    );
  }

  /// `enter the new password again`
  String get fieldHintPasswordNewConfirm {
    return Intl.message(
      'enter the new password again',
      name: 'fieldHintPasswordNewConfirm',
      desc: '',
      args: [],
    );
  }

  /// `please enter your old password`
  String get fieldHintPasswordOld {
    return Intl.message(
      'please enter your old password',
      name: 'fieldHintPasswordOld',
      desc: '',
      args: [],
    );
  }

  /// `Bind mobile phone number to protect account security`
  String get fieldHintPhone {
    return Intl.message(
      'Bind mobile phone number to protect account security',
      name: 'fieldHintPhone',
      desc: '',
      args: [],
    );
  }

  /// `please enter a name`
  String get fieldHintSearchGame {
    return Intl.message(
      'please enter a name',
      name: 'fieldHintSearchGame',
      desc: '',
      args: [],
    );
  }

  /// `please enter verification code`
  String get fieldHintVerifyCode {
    return Intl.message(
      'please enter verification code',
      name: 'fieldHintVerifyCode',
      desc: '',
      args: [],
    );
  }

  /// `Only one set of verification codes can be obtained within 24 hours`
  String get fieldHintVerifyCodeFetch {
    return Intl.message(
      'Only one set of verification codes can be obtained within 24 hours',
      name: 'fieldHintVerifyCodeFetch',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get fieldOptionDateAll {
    return Intl.message(
      'All',
      name: 'fieldOptionDateAll',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get fieldOptionDateCustom {
    return Intl.message(
      'Custom',
      name: 'fieldOptionDateCustom',
      desc: '',
      args: [],
    );
  }

  /// `Within a month`
  String get fieldOptionDateMonth {
    return Intl.message(
      'Within a month',
      name: 'fieldOptionDateMonth',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get fieldOptionDateToday {
    return Intl.message(
      'Today',
      name: 'fieldOptionDateToday',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get fieldOptionDateYesterday {
    return Intl.message(
      'Yesterday',
      name: 'fieldOptionDateYesterday',
      desc: '',
      args: [],
    );
  }

  /// `ATM Transfer`
  String get fieldOptionDepositTypeAtm {
    return Intl.message(
      'ATM Transfer',
      name: 'fieldOptionDepositTypeAtm',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get fieldOptionDepositTypeTransfer {
    return Intl.message(
      'Transfer',
      name: 'fieldOptionDepositTypeTransfer',
      desc: '',
      args: [],
    );
  }

  /// `{sex, select, male{Male} female{Female} other{Other}}`
  String fieldOptionGender(String sex) {
    return Intl.gender(
      sex,
      male: 'Male',
      female: 'Female',
      other: 'Other',
      name: 'fieldOptionGender',
      desc: 'Member\'s gender options',
      args: [sex],
    );
  }

  /// `All platforms`
  String get fieldOptionPlatformAll {
    return Intl.message(
      'All platforms',
      name: 'fieldOptionPlatformAll',
      desc: '',
      args: [],
    );
  }

  /// `Give up the offer`
  String get fieldOptionPromoNone {
    return Intl.message(
      'Give up the offer',
      name: 'fieldOptionPromoNone',
      desc: '',
      args: [],
    );
  }

  /// `success`
  String get fieldOptionStatus1 {
    return Intl.message(
      'success',
      name: 'fieldOptionStatus1',
      desc: '',
      args: [],
    );
  }

  /// `failure`
  String get fieldOptionStatus2 {
    return Intl.message(
      'failure',
      name: 'fieldOptionStatus2',
      desc: '',
      args: [],
    );
  }

  /// `processing`
  String get fieldOptionStatus3 {
    return Intl.message(
      'processing',
      name: 'fieldOptionStatus3',
      desc: '',
      args: [],
    );
  }

  /// `new`
  String get fieldOptionStatus4 {
    return Intl.message(
      'new',
      name: 'fieldOptionStatus4',
      desc: '',
      args: [],
    );
  }

  /// `All state`
  String get fieldOptionStatusAll {
    return Intl.message(
      'All state',
      name: 'fieldOptionStatusAll',
      desc: '',
      args: [],
    );
  }

  /// `Bet time`
  String get fieldOptionTitleBetDate {
    return Intl.message(
      'Bet time',
      name: 'fieldOptionTitleBetDate',
      desc: '',
      args: [],
    );
  }

  /// `Payer bank`
  String get fieldOptionTitleDepositBank {
    return Intl.message(
      'Payer bank',
      name: 'fieldOptionTitleDepositBank',
      desc: '',
      args: [],
    );
  }

  /// `Deposit Method`
  String get fieldOptionTitleDepositType {
    return Intl.message(
      'Deposit Method',
      name: 'fieldOptionTitleDepositType',
      desc: '',
      args: [],
    );
  }

  /// `Payment bank`
  String get fieldOptionTitlePaymentBank {
    return Intl.message(
      'Payment bank',
      name: 'fieldOptionTitlePaymentBank',
      desc: '',
      args: [],
    );
  }

  /// `Platform`
  String get fieldOptionTitlePlatform {
    return Intl.message(
      'Platform',
      name: 'fieldOptionTitlePlatform',
      desc: '',
      args: [],
    );
  }

  /// `Select Promo`
  String get fieldOptionTitlePromo {
    return Intl.message(
      'Select Promo',
      name: 'fieldOptionTitlePromo',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get fieldOptionTitleShow {
    return Intl.message(
      'Show',
      name: 'fieldOptionTitleShow',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get fieldOptionTitleShowItem {
    return Intl.message(
      'Items',
      name: 'fieldOptionTitleShowItem',
      desc: '',
      args: [],
    );
  }

  /// `Transfer time`
  String get fieldOptionTitleTransferDate {
    return Intl.message(
      'Transfer time',
      name: 'fieldOptionTitleTransferDate',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get fieldOptionType1 {
    return Intl.message(
      'Deposit',
      name: 'fieldOptionType1',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get fieldOptionType2 {
    return Intl.message(
      'Withdraw',
      name: 'fieldOptionType2',
      desc: '',
      args: [],
    );
  }

  /// `Bonus`
  String get fieldOptionType3 {
    return Intl.message(
      'Bonus',
      name: 'fieldOptionType3',
      desc: '',
      args: [],
    );
  }

  /// `All types`
  String get fieldOptionTypeAll {
    return Intl.message(
      'All types',
      name: 'fieldOptionTypeAll',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get fieldTitleAccount {
    return Intl.message(
      'Account',
      name: 'fieldTitleAccount',
      desc: '',
      args: [],
    );
  }

  /// `Account holder`
  String get fieldTitleAccountHolder {
    return Intl.message(
      'Account holder',
      name: 'fieldTitleAccountHolder',
      desc: '',
      args: [],
    );
  }

  /// `Account name`
  String get fieldTitleAccountName {
    return Intl.message(
      'Account name',
      name: 'fieldTitleAccountName',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get fieldTitleBank {
    return Intl.message(
      'Bank',
      name: 'fieldTitleBank',
      desc: '',
      args: [],
    );
  }

  /// `Account (card) number`
  String get fieldTitleBankAccount {
    return Intl.message(
      'Account (card) number',
      name: 'fieldTitleBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Bank Location`
  String get fieldTitleBankArea {
    return Intl.message(
      'Bank Location',
      name: 'fieldTitleBankArea',
      desc: '',
      args: [],
    );
  }

  /// `Bank Branch`
  String get fieldTitleBankBranch {
    return Intl.message(
      'Bank Branch',
      name: 'fieldTitleBankBranch',
      desc: '',
      args: [],
    );
  }

  /// `Bank name`
  String get fieldTitleBankName {
    return Intl.message(
      'Bank name',
      name: 'fieldTitleBankName',
      desc: '',
      args: [],
    );
  }

  /// `Bank Province`
  String get fieldTitleBankProvince {
    return Intl.message(
      'Bank Province',
      name: 'fieldTitleBankProvince',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get fieldTitleBirthday {
    return Intl.message(
      'Birthday',
      name: 'fieldTitleBirthday',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get fieldTitleConfirm {
    return Intl.message(
      'Confirm Password',
      name: 'fieldTitleConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get fieldTitleCreditAmount {
    return Intl.message(
      'Amount',
      name: 'fieldTitleCreditAmount',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get fieldTitleDateEnd {
    return Intl.message(
      'End Time',
      name: 'fieldTitleDateEnd',
      desc: '',
      args: [],
    );
  }

  /// `Starting time`
  String get fieldTitleDateStart {
    return Intl.message(
      'Starting time',
      name: 'fieldTitleDateStart',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get fieldTitleDepositAmount {
    return Intl.message(
      'Amount',
      name: 'fieldTitleDepositAmount',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get fieldTitleDepositBankAccount {
    return Intl.message(
      'Account',
      name: 'fieldTitleDepositBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Transaction code`
  String get fieldTitleDepositCode {
    return Intl.message(
      'Transaction code',
      name: 'fieldTitleDepositCode',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get fieldTitleDepositName {
    return Intl.message(
      'Name',
      name: 'fieldTitleDepositName',
      desc: '',
      args: [],
    );
  }

  /// `E-Mail`
  String get fieldTitleEmail {
    return Intl.message(
      'E-Mail',
      name: 'fieldTitleEmail',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get fieldTitleFacebook {
    return Intl.message(
      'Facebook',
      name: 'fieldTitleFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Line`
  String get fieldTitleLine {
    return Intl.message(
      'Line',
      name: 'fieldTitleLine',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get fieldTitleMemberAccount {
    return Intl.message(
      'Username',
      name: 'fieldTitleMemberAccount',
      desc: '',
      args: [],
    );
  }

  /// `Real name`
  String get fieldTitleMemberName {
    return Intl.message(
      'Real name',
      name: 'fieldTitleMemberName',
      desc: '',
      args: [],
    );
  }

  /// `Mobile verification code`
  String get fieldTitleMobileVerifyCode {
    return Intl.message(
      'Mobile verification code',
      name: 'fieldTitleMobileVerifyCode',
      desc: '',
      args: [],
    );
  }

  /// `Remarks`
  String get fieldTitleNote {
    return Intl.message(
      'Remarks',
      name: 'fieldTitleNote',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get fieldTitlePassword {
    return Intl.message(
      'Password',
      name: 'fieldTitlePassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get fieldTitlePasswordNew {
    return Intl.message(
      'New Password',
      name: 'fieldTitlePasswordNew',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get fieldTitlePasswordNewConfirm {
    return Intl.message(
      'Confirm New Password',
      name: 'fieldTitlePasswordNewConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get fieldTitlePasswordOld {
    return Intl.message(
      'Old Password',
      name: 'fieldTitlePasswordOld',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get fieldTitlePhone {
    return Intl.message(
      'Mobile',
      name: 'fieldTitlePhone',
      desc: '',
      args: [],
    );
  }

  /// `QQ`
  String get fieldTitleQQ {
    return Intl.message(
      'QQ',
      name: 'fieldTitleQQ',
      desc: '',
      args: [],
    );
  }

  /// `Referral code`
  String get fieldTitleReferralCode {
    return Intl.message(
      'Referral code',
      name: 'fieldTitleReferralCode',
      desc: '',
      args: [],
    );
  }

  /// `Remarks`
  String get fieldTitleRemark {
    return Intl.message(
      'Remarks',
      name: 'fieldTitleRemark',
      desc: '',
      args: [],
    );
  }

  /// `Skype`
  String get fieldTitleSkype {
    return Intl.message(
      'Skype',
      name: 'fieldTitleSkype',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get fieldTitleVerifyCode {
    return Intl.message(
      'Verification code',
      name: 'fieldTitleVerifyCode',
      desc: '',
      args: [],
    );
  }

  /// `Wechat ID`
  String get fieldTitleWechat {
    return Intl.message(
      'Wechat ID',
      name: 'fieldTitleWechat',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Amount`
  String get fieldTitleWithdrawAmount {
    return Intl.message(
      'Withdrawal Amount',
      name: 'fieldTitleWithdrawAmount',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Password`
  String get fieldTitleWithdrawPassword {
    return Intl.message(
      'Withdrawal Password',
      name: 'fieldTitleWithdrawPassword',
      desc: '',
      args: [],
    );
  }

  /// `Zalo`
  String get fieldTitleZalo {
    return Intl.message(
      'Zalo',
      name: 'fieldTitleZalo',
      desc: '',
      args: [],
    );
  }

  /// `Back to Homepage`
  String get gameToolBtnBackHome {
    return Intl.message(
      'Back to Homepage',
      name: 'gameToolBtnBackHome',
      desc: '',
      args: [],
    );
  }

  /// `Lock screen direction`
  String get gameToolBtnLockRotate {
    return Intl.message(
      'Lock screen direction',
      name: 'gameToolBtnLockRotate',
      desc: '',
      args: [],
    );
  }

  /// `Rotate the screen`
  String get gameToolBtnRotate {
    return Intl.message(
      'Rotate the screen',
      name: 'gameToolBtnRotate',
      desc: '',
      args: [],
    );
  }

  /// `Double click to restore from hide`
  String get gameToolHintRestore {
    return Intl.message(
      'Double click to restore from hide',
      name: 'gameToolHintRestore',
      desc: '',
      args: [],
    );
  }

  /// `Click to show, long press to hide ↗`
  String get gameToolHintUsage {
    return Intl.message(
      'Click to show, long press to hide ↗',
      name: 'gameToolHintUsage',
      desc: '',
      args: [],
    );
  }

  /// `Please login first`
  String get hintActionLogin {
    return Intl.message(
      'Please login first',
      name: 'hintActionLogin',
      desc: '',
      args: [],
    );
  }

  /// `Add a bank card`
  String get hintAddBankcard {
    return Intl.message(
      'Add a bank card',
      name: 'hintAddBankcard',
      desc: '',
      args: [],
    );
  }

  /// `Please bind a bank card to receive payment`
  String get hintAddBankcardDesc {
    return Intl.message(
      'Please bind a bank card to receive payment',
      name: 'hintAddBankcardDesc',
      desc: '',
      args: [],
    );
  }

  /// `Notices`
  String get hintAttentionNotice {
    return Intl.message(
      'Notices',
      name: 'hintAttentionNotice',
      desc: '',
      args: [],
    );
  }

  /// `Click to log in/register`
  String get hintClickToLoginRegister {
    return Intl.message(
      'Click to log in/register',
      name: 'hintClickToLoginRegister',
      desc: '',
      args: [],
    );
  }

  /// `Total balance`
  String get hintCreditRemain {
    return Intl.message(
      'Total balance',
      name: 'hintCreditRemain',
      desc: '',
      args: [],
    );
  }

  /// `Free to use`
  String get hintFreeUsage {
    return Intl.message(
      'Free to use',
      name: 'hintFreeUsage',
      desc: '',
      args: [],
    );
  }

  /// `Hello!`
  String get hintHello {
    return Intl.message(
      'Hello!',
      name: 'hintHello',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Please log in as a member`
  String get hintHelloLogin {
    return Intl.message(
      'Hello! Please log in as a member',
      name: 'hintHelloLogin',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Please login/register first`
  String get hintHelloLoginRegister {
    return Intl.message(
      'Hello! Please login/register first',
      name: 'hintHelloLoginRegister',
      desc: '',
      args: [],
    );
  }

  /// `Under Maintenance`
  String get hintMaintenance {
    return Intl.message(
      'Under Maintenance',
      name: 'hintMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `No information found`
  String get hintNoHistoryData {
    return Intl.message(
      'No information found',
      name: 'hintNoHistoryData',
      desc: '',
      args: [],
    );
  }

  /// `There is currently no information on the site`
  String get hintNoMessages {
    return Intl.message(
      'There is currently no information on the site',
      name: 'hintNoMessages',
      desc: '',
      args: [],
    );
  }

  /// `If the platform amount has not changed after the transfer is successful, please select the platform to refresh the amount again or contact customer service`
  String get hintRefreshCreditAfterTransfer {
    return Intl.message(
      'If the platform amount has not changed after the transfer is successful, please select the platform to refresh the amount again or contact customer service',
      name: 'hintRefreshCreditAfterTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get hintSelect {
    return Intl.message(
      'Select',
      name: 'hintSelect',
      desc: '',
      args: [],
    );
  }

  /// `Please select the amount`
  String get hintSelectAmount {
    return Intl.message(
      'Please select the amount',
      name: 'hintSelectAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a platform`
  String get hintSelectPlatform {
    return Intl.message(
      'Please choose a platform',
      name: 'hintSelectPlatform',
      desc: '',
      args: [],
    );
  }

  /// `If you have any questions, please click this icon!`
  String get hintServiceIcon {
    return Intl.message(
      'If you have any questions, please click this icon!',
      name: 'hintServiceIcon',
      desc: '',
      args: [],
    );
  }

  /// `Tips`
  String get hintTips {
    return Intl.message(
      'Tips',
      name: 'hintTips',
      desc: '',
      args: [],
    );
  }

  /// `Wallet balance`
  String get hintWalletRemain {
    return Intl.message(
      'Wallet balance',
      name: 'hintWalletRemain',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get hintWelcome {
    return Intl.message(
      'Welcome',
      name: 'hintWelcome',
      desc: '',
      args: [],
    );
  }

  /// `Hello {name}!`
  String hintWelcomeMember(Object name) {
    return Intl.message(
      'Hello $name!',
      name: 'hintWelcomeMember',
      desc: '',
      args: [name],
    );
  }

  /// `Please read and tick to agree to the betting rules`
  String get msgActionCheckTerms {
    return Intl.message(
      'Please read and tick to agree to the betting rules',
      name: 'msgActionCheckTerms',
      desc: '',
      args: [],
    );
  }

  /// `Data error, please log in manually`
  String get msgAutoLoginError {
    return Intl.message(
      'Data error, please log in manually',
      name: 'msgAutoLoginError',
      desc: '',
      args: [],
    );
  }

  /// `Some platforms transfer failed`
  String get msgBalanceToMainPartFailed {
    return Intl.message(
      'Some platforms transfer failed',
      name: 'msgBalanceToMainPartFailed',
      desc: '',
      args: [],
    );
  }

  /// `Copied to clipboard`
  String get msgCopyToClipboard {
    return Intl.message(
      'Copied to clipboard',
      name: 'msgCopyToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Copy failed`
  String get msgCopyToClipboardError {
    return Intl.message(
      'Copy failed',
      name: 'msgCopyToClipboardError',
      desc: '',
      args: [],
    );
  }

  /// `The operation failed, please try again later`
  String get msgFailed {
    return Intl.message(
      'The operation failed, please try again later',
      name: 'msgFailed',
      desc: '',
      args: [],
    );
  }

  /// `Data error, please select again`
  String get msgFormError {
    return Intl.message(
      'Data error, please select again',
      name: 'msgFormError',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm the field information and complete it`
  String get msgFormNotFilled {
    return Intl.message(
      'Please confirm the field information and complete it',
      name: 'msgFormNotFilled',
      desc: '',
      args: [],
    );
  }

  /// `Loading game, please wait...`
  String get msgLoadingGame {
    return Intl.message(
      'Loading game, please wait...',
      name: 'msgLoadingGame',
      desc: '',
      args: [],
    );
  }

  /// `Verification code sent`
  String get msgMobileVerifySent {
    return Intl.message(
      'Verification code sent',
      name: 'msgMobileVerifySent',
      desc: '',
      args: [],
    );
  }

  /// `Detected network status changed. Do you want to refresh the page?`
  String get msgNetworkChanged {
    return Intl.message(
      'Detected network status changed. Do you want to refresh the page?',
      name: 'msgNetworkChanged',
      desc: '',
      args: [],
    );
  }

  /// `Please check the network status`
  String get msgNetworkError {
    return Intl.message(
      'Please check the network status',
      name: 'msgNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `This service is not available in your network area`
  String get msgNetworkLocationNoService {
    return Intl.message(
      'This service is not available in your network area',
      name: 'msgNetworkLocationNoService',
      desc: '',
      args: [],
    );
  }

  /// `You are using a mobile network, and network charges may be incurred according to your usage rate`
  String get msgNetworkUsingCellular {
    return Intl.message(
      'You are using a mobile network, and network charges may be incurred according to your usage rate',
      name: 'msgNetworkUsingCellular',
      desc: '',
      args: [],
    );
  }

  /// `There is currently no activity`
  String get msgNoEvent {
    return Intl.message(
      'There is currently no activity',
      name: 'msgNoEvent',
      desc: '',
      args: [],
    );
  }

  /// `Please enable "Save" permission`
  String get msgNoStoragePermission {
    return Intl.message(
      'Please enable "Save" permission',
      name: 'msgNoStoragePermission',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient balance`
  String get msgNotEnoughCredit {
    return Intl.message(
      'Insufficient balance',
      name: 'msgNotEnoughCredit',
      desc: '',
      args: [],
    );
  }

  /// `Unable to get {wallet} wallet binding URL`
  String msgNoWalletBindUrl(Object wallet) {
    return Intl.message(
      'Unable to get $wallet wallet binding URL',
      name: 'msgNoWalletBindUrl',
      desc: '',
      args: [wallet],
    );
  }

  /// `Please bind the bank card first!`
  String get msgPleaseBindBankcard {
    return Intl.message(
      'Please bind the bank card first!',
      name: 'msgPleaseBindBankcard',
      desc: '',
      args: [],
    );
  }

  /// `Please wait…`
  String get msgPleaseWait {
    return Intl.message(
      'Please wait…',
      name: 'msgPleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Processing request, please wait...`
  String get msgProcessing {
    return Intl.message(
      'Processing request, please wait...',
      name: 'msgProcessing',
      desc: '',
      args: [],
    );
  }

  /// `Successful operation`
  String get msgSuccess {
    return Intl.message(
      'Successful operation',
      name: 'msgSuccess',
      desc: '',
      args: [],
    );
  }

  /// `{Task} cancelled`
  String msgTaskCanceled(Object task, Object Task) {
    return Intl.message(
      '$Task cancelled',
      name: 'msgTaskCanceled',
      desc: '',
      args: [task, Task],
    );
  }

  /// `{task} succeeded`
  String msgTaskSuccess(Object task) {
    return Intl.message(
      '$task succeeded',
      name: 'msgTaskSuccess',
      desc: '',
      args: [task],
    );
  }

  /// `{from} to {to}`
  String msgTransferFromTo(Object from, Object to) {
    return Intl.message(
      '$from to $to',
      name: 'msgTransferFromTo',
      desc: '',
      args: [from, to],
    );
  }

  /// `Unable to open web link: {url}`
  String msgUrlLaunchError(Object url) {
    return Intl.message(
      'Unable to open web link: $url',
      name: 'msgUrlLaunchError',
      desc: '',
      args: [url],
    );
  }

  /// `Unable to jump to the destination URL`
  String get msgUrlNavNotSupported {
    return Intl.message(
      'Unable to jump to the destination URL',
      name: 'msgUrlNavNotSupported',
      desc: '',
      args: [],
    );
  }

  /// `{name}, please log in again`
  String msgUserLogout(Object name) {
    return Intl.message(
      '$name, please log in again',
      name: 'msgUserLogout',
      desc: '',
      args: [name],
    );
  }

  /// `Verified successfully`
  String get msgVerifySuccess {
    return Intl.message(
      'Verified successfully',
      name: 'msgVerifySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Signing in, please wait...`
  String get msgWaitLogin {
    return Intl.message(
      'Signing in, please wait...',
      name: 'msgWaitLogin',
      desc: '',
      args: [],
    );
  }

  /// `Please do not log out while processing the request`
  String get msgWaitProcessComplete {
    return Intl.message(
      'Please do not log out while processing the request',
      name: 'msgWaitProcessComplete',
      desc: '',
      args: [],
    );
  }

  /// `Welcome, {name}`
  String msgWelcomeUser(Object name) {
    return Intl.message(
      'Welcome, $name',
      name: 'msgWelcomeUser',
      desc: '',
      args: [name],
    );
  }

  /// `Features will be online soon!`
  String get msgWorkInProgress {
    return Intl.message(
      'Features will be online soon!',
      name: 'msgWorkInProgress',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get noticeTabGeneral {
    return Intl.message(
      'General',
      name: 'noticeTabGeneral',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance`
  String get noticeTabMaintenance {
    return Intl.message(
      'Maintenance',
      name: 'noticeTabMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get pageBtnChangePassword {
    return Intl.message(
      'Change Password',
      name: 'pageBtnChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Contact Customer Service`
  String get pageBtnContactCs {
    return Intl.message(
      'Contact Customer Service',
      name: 'pageBtnContactCs',
      desc: '',
      args: [],
    );
  }

  /// `Tutorials`
  String get pageBtnHelp {
    return Intl.message(
      'Tutorials',
      name: 'pageBtnHelp',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get pageBtnLogin {
    return Intl.message(
      'Sign in',
      name: 'pageBtnLogin',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get pageBtnLogout {
    return Intl.message(
      'Sign out',
      name: 'pageBtnLogout',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get pageBtnMenu {
    return Intl.message(
      'Menu',
      name: 'pageBtnMenu',
      desc: '',
      args: [],
    );
  }

  /// `Notice`
  String get pageBtnNotify {
    return Intl.message(
      'Notice',
      name: 'pageBtnNotify',
      desc: '',
      args: [],
    );
  }

  /// `Online Service`
  String get pageBtnOnlineCs {
    return Intl.message(
      'Online Service',
      name: 'pageBtnOnlineCs',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get pageBtnRegister {
    return Intl.message(
      'Register',
      name: 'pageBtnRegister',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get pageBtnSetting {
    return Intl.message(
      'Settings',
      name: 'pageBtnSetting',
      desc: '',
      args: [],
    );
  }

  /// `prize redemption, bonus record`
  String get pageHintExchangeRecord {
    return Intl.message(
      'prize redemption, bonus record',
      name: 'pageHintExchangeRecord',
      desc: '',
      args: [],
    );
  }

  /// `If you have any questions about deposits, withdrawals and betting, please see here`
  String get pageHintHelpCenter {
    return Intl.message(
      'If you have any questions about deposits, withdrawals and betting, please see here',
      name: 'pageHintHelpCenter',
      desc: '',
      args: [],
    );
  }

  /// `Invite friends to share tens of millions of cash`
  String get pageHintInvite {
    return Intl.message(
      'Invite friends to share tens of millions of cash',
      name: 'pageHintInvite',
      desc: '',
      args: [],
    );
  }

  /// `Joint venture plan`
  String get pageHintJoinUs {
    return Intl.message(
      'Joint venture plan',
      name: 'pageHintJoinUs',
      desc: '',
      args: [],
    );
  }

  /// `Open Website`
  String get pageHintWebsite {
    return Intl.message(
      'Open Website',
      name: 'pageHintWebsite',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get pageTitleAboutUs {
    return Intl.message(
      'About us',
      name: 'pageTitleAboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Center`
  String get pageTitleCenter {
    return Intl.message(
      'Center',
      name: 'pageTitleCenter',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get pageTitleDeposit {
    return Intl.message(
      'Deposit',
      name: 'pageTitleDeposit',
      desc: '',
      args: [],
    );
  }

  /// `Prize Record`
  String get pageTitleExchangeRecord {
    return Intl.message(
      'Prize Record',
      name: 'pageTitleExchangeRecord',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get pageTitleHelpCenter {
    return Intl.message(
      'Help Center',
      name: 'pageTitleHelpCenter',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get pageTitleHome {
    return Intl.message(
      'Home',
      name: 'pageTitleHome',
      desc: '',
      args: [],
    );
  }

  /// `Invite friends`
  String get pageTitleInvite {
    return Intl.message(
      'Invite friends',
      name: 'pageTitleInvite',
      desc: '',
      args: [],
    );
  }

  /// `Join us`
  String get pageTitleJoinUs {
    return Intl.message(
      'Join us',
      name: 'pageTitleJoinUs',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get pageTitleLogin {
    return Intl.message(
      'Sign in',
      name: 'pageTitleLogin',
      desc: '',
      args: [],
    );
  }

  /// `MY`
  String get pageTitleMember {
    return Intl.message(
      'MY',
      name: 'pageTitleMember',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get pageTitleMemberBalance {
    return Intl.message(
      'Balance',
      name: 'pageTitleMemberBalance',
      desc: '',
      args: [],
    );
  }

  /// `Betting Record`
  String get pageTitleMemberBets {
    return Intl.message(
      'Betting Record',
      name: 'pageTitleMemberBets',
      desc: '',
      args: [],
    );
  }

  /// `Bank card`
  String get pageTitleMemberCard {
    return Intl.message(
      'Bank card',
      name: 'pageTitleMemberCard',
      desc: '',
      args: [],
    );
  }

  /// `Account Center`
  String get pageTitleMemberCenter {
    return Intl.message(
      'Account Center',
      name: 'pageTitleMemberCenter',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Record`
  String get pageTitleMemberDeals {
    return Intl.message(
      'Transaction Record',
      name: 'pageTitleMemberDeals',
      desc: '',
      args: [],
    );
  }

  /// `Flow record`
  String get pageTitleMemberFlow {
    return Intl.message(
      'Flow record',
      name: 'pageTitleMemberFlow',
      desc: '',
      args: [],
    );
  }

  /// `Member Login`
  String get pageTitleMemberLogin {
    return Intl.message(
      'Member Login',
      name: 'pageTitleMemberLogin',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get pageTitleMemberMessage {
    return Intl.message(
      'Message',
      name: 'pageTitleMemberMessage',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Record`
  String get pageTitleMemberTransaction {
    return Intl.message(
      'Transfer Record',
      name: 'pageTitleMemberTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get pageTitleMemberTransfer {
    return Intl.message(
      'Transfer',
      name: 'pageTitleMemberTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get pageTitleMemberWallet {
    return Intl.message(
      'Wallet',
      name: 'pageTitleMemberWallet',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get pageTitleMemberWithdraw {
    return Intl.message(
      'Withdraw',
      name: 'pageTitleMemberWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Announcement`
  String get pageTitleNotice {
    return Intl.message(
      'Announcement',
      name: 'pageTitleNotice',
      desc: '',
      args: [],
    );
  }

  /// `Promo`
  String get pageTitlePromo {
    return Intl.message(
      'Promo',
      name: 'pageTitlePromo',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get pageTitleRegister {
    return Intl.message(
      'Register',
      name: 'pageTitleRegister',
      desc: '',
      args: [],
    );
  }

  /// `Sign up for free`
  String get pageTitleRegisterFree {
    return Intl.message(
      'Sign up for free',
      name: 'pageTitleRegisterFree',
      desc: '',
      args: [],
    );
  }

  /// `Register as member`
  String get pageTitleRegisterMember {
    return Intl.message(
      'Register as member',
      name: 'pageTitleRegisterMember',
      desc: '',
      args: [],
    );
  }

  /// `Customer Service`
  String get pageTitleService {
    return Intl.message(
      'Customer Service',
      name: 'pageTitleService',
      desc: '',
      args: [],
    );
  }

  /// `Sponsor`
  String get pageTitleSponsor {
    return Intl.message(
      'Sponsor',
      name: 'pageTitleSponsor',
      desc: '',
      args: [],
    );
  }

  /// `Yabo Mall`
  String get pageTitleStore {
    return Intl.message(
      'Yabo Mall',
      name: 'pageTitleStore',
      desc: '',
      args: [],
    );
  }

  /// `VIP`
  String get pageTitleVip {
    return Intl.message(
      'VIP',
      name: 'pageTitleVip',
      desc: '',
      args: [],
    );
  }

  /// `VIP Privileges`
  String get pageTitleVipAbout {
    return Intl.message(
      'VIP Privileges',
      name: 'pageTitleVipAbout',
      desc: '',
      args: [],
    );
  }

  /// `How to apply`
  String get promoDetailApply {
    return Intl.message(
      'How to apply',
      name: 'promoDetailApply',
      desc: '',
      args: [],
    );
  }

  /// `>>Promo Detail`
  String get promoDetailBtn {
    return Intl.message(
      '>>Promo Detail',
      name: 'promoDetailBtn',
      desc: '',
      args: [],
    );
  }

  /// `Activities`
  String get promoDetailContent {
    return Intl.message(
      'Activities',
      name: 'promoDetailContent',
      desc: '',
      args: [],
    );
  }

  /// `Applicable platform`
  String get promoDetailPlatform {
    return Intl.message(
      'Applicable platform',
      name: 'promoDetailPlatform',
      desc: '',
      args: [],
    );
  }

  /// `Activity Details`
  String get promoDetailRules {
    return Intl.message(
      'Activity Details',
      name: 'promoDetailRules',
      desc: '',
      args: [],
    );
  }

  /// `No promo information`
  String get promoNoInfo {
    return Intl.message(
      'No promo information',
      name: 'promoNoInfo',
      desc: '',
      args: [],
    );
  }

  /// `No promo`
  String get promoNotFound {
    return Intl.message(
      'No promo',
      name: 'promoNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Deposit`
  String get rollbackIndexDeposit {
    return Intl.message(
      'Deposit',
      name: 'rollbackIndexDeposit',
      desc: '',
      args: [],
    );
  }

  /// `Promo`
  String get rollbackIndexPromo {
    return Intl.message(
      'Promo',
      name: 'rollbackIndexPromo',
      desc: '',
      args: [],
    );
  }

  /// `Rollback`
  String get rollbackIndexRollback {
    return Intl.message(
      'Rollback',
      name: 'rollbackIndexRollback',
      desc: '',
      args: [],
    );
  }

  /// `24 hours service`
  String get serviceDescCustomerService {
    return Intl.message(
      '24 hours service',
      name: 'serviceDescCustomerService',
      desc: '',
      args: [],
    );
  }

  /// `Need help or contact us`
  String get serviceRouteHint {
    return Intl.message(
      'Need help or contact us',
      name: 'serviceRouteHint',
      desc: '',
      args: [],
    );
  }

  /// `APP QRCode`
  String get serviceTitleAppQr {
    return Intl.message(
      'APP QRCode',
      name: 'serviceTitleAppQr',
      desc: '',
      args: [],
    );
  }

  /// `Online customer service`
  String get serviceTitleCustomerService {
    return Intl.message(
      'Online customer service',
      name: 'serviceTitleCustomerService',
      desc: '',
      args: [],
    );
  }

  /// `Zalo QRCode`
  String get serviceTitleZaloQr {
    return Intl.message(
      'Zalo QRCode',
      name: 'serviceTitleZaloQr',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get tableHeaderAmount {
    return Intl.message(
      'Amount',
      name: 'tableHeaderAmount',
      desc: '',
      args: [],
    );
  }

  /// `Bet amount`
  String get tableHeaderBetAmount {
    return Intl.message(
      'Bet amount',
      name: 'tableHeaderBetAmount',
      desc: '',
      args: [],
    );
  }

  /// `Current bet`
  String get tableHeaderBetsCurrent {
    return Intl.message(
      'Current bet',
      name: 'tableHeaderBetsCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Need`
  String get tableHeaderBetsNeed {
    return Intl.message(
      'Need',
      name: 'tableHeaderBetsNeed',
      desc: '',
      args: [],
    );
  }

  /// `Required Bets`
  String get tableHeaderBetsRequire {
    return Intl.message(
      'Required Bets',
      name: 'tableHeaderBetsRequire',
      desc: '',
      args: [],
    );
  }

  /// `Payout amount`
  String get tableHeaderBonus {
    return Intl.message(
      'Payout amount',
      name: 'tableHeaderBonus',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get tableHeaderDate {
    return Intl.message(
      'Date',
      name: 'tableHeaderDate',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get tableHeaderDesc {
    return Intl.message(
      'Description',
      name: 'tableHeaderDesc',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get tableHeaderDetail {
    return Intl.message(
      'Detail',
      name: 'tableHeaderDetail',
      desc: '',
      args: [],
    );
  }

  /// `Game`
  String get tableHeaderGame {
    return Intl.message(
      'Game',
      name: 'tableHeaderGame',
      desc: '',
      args: [],
    );
  }

  /// `Bet No.`
  String get tableHeaderId {
    return Intl.message(
      'Bet No.',
      name: 'tableHeaderId',
      desc: '',
      args: [],
    );
  }

  /// `Multiply`
  String get tableHeaderMultiple {
    return Intl.message(
      'Multiply',
      name: 'tableHeaderMultiple',
      desc: '',
      args: [],
    );
  }

  /// `Object`
  String get tableHeaderObject {
    return Intl.message(
      'Object',
      name: 'tableHeaderObject',
      desc: '',
      args: [],
    );
  }

  /// `Platform`
  String get tableHeaderPlatform {
    return Intl.message(
      'Platform',
      name: 'tableHeaderPlatform',
      desc: '',
      args: [],
    );
  }

  /// `Promo`
  String get tableHeaderPromo {
    return Intl.message(
      'Promo',
      name: 'tableHeaderPromo',
      desc: '',
      args: [],
    );
  }

  /// `No.`
  String get tableHeaderSerial {
    return Intl.message(
      'No.',
      name: 'tableHeaderSerial',
      desc: '',
      args: [],
    );
  }

  /// `No.`
  String get tableHeaderSheetNo {
    return Intl.message(
      'No.',
      name: 'tableHeaderSheetNo',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get tableHeaderStatus {
    return Intl.message(
      'Status',
      name: 'tableHeaderStatus',
      desc: '',
      args: [],
    );
  }

  /// `Sum`
  String get tableHeaderSum {
    return Intl.message(
      'Sum',
      name: 'tableHeaderSum',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get tableHeaderTime {
    return Intl.message(
      'Time',
      name: 'tableHeaderTime',
      desc: '',
      args: [],
    );
  }

  /// `Time interval`
  String get tableHeaderTimeRange {
    return Intl.message(
      'Time interval',
      name: 'tableHeaderTimeRange',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get tableHeaderTotal {
    return Intl.message(
      'Total',
      name: 'tableHeaderTotal',
      desc: '',
      args: [],
    );
  }

  /// `Transaction code`
  String get tableHeaderTransferCode {
    return Intl.message(
      'Transaction code',
      name: 'tableHeaderTransferCode',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get tableHeaderType {
    return Intl.message(
      'Type',
      name: 'tableHeaderType',
      desc: '',
      args: [],
    );
  }

  /// `Valid bet`
  String get tableHeaderValidBet {
    return Intl.message(
      'Valid bet',
      name: 'tableHeaderValidBet',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get textCategoryAbout {
    return Intl.message(
      'About us',
      name: 'textCategoryAbout',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get textCategoryAll {
    return Intl.message(
      'All',
      name: 'textCategoryAll',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get textCategoryCard {
    return Intl.message(
      'Card',
      name: 'textCategoryCard',
      desc: '',
      args: [],
    );
  }

  /// `Card Games`
  String get textCategoryCardFull {
    return Intl.message(
      'Card Games',
      name: 'textCategoryCardFull',
      desc: '',
      args: [],
    );
  }

  /// `Real person`
  String get textCategoryCasino {
    return Intl.message(
      'Real person',
      name: 'textCategoryCasino',
      desc: '',
      args: [],
    );
  }

  /// `Live entertainment`
  String get textCategoryCasinoFull {
    return Intl.message(
      'Live entertainment',
      name: 'textCategoryCasinoFull',
      desc: '',
      args: [],
    );
  }

  /// `Cockfighting`
  String get textCategoryCockFighting {
    return Intl.message(
      'Cockfighting',
      name: 'textCategoryCockFighting',
      desc: '',
      args: [],
    );
  }

  /// `E-Sport`
  String get textCategoryEsport {
    return Intl.message(
      'E-Sport',
      name: 'textCategoryEsport',
      desc: '',
      args: [],
    );
  }

  /// `E-Sport Games`
  String get textCategoryEsportFull {
    return Intl.message(
      'E-Sport Games',
      name: 'textCategoryEsportFull',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get textCategoryFavorite {
    return Intl.message(
      'Favorite',
      name: 'textCategoryFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Fishing`
  String get textCategoryFish {
    return Intl.message(
      'Fishing',
      name: 'textCategoryFish',
      desc: '',
      args: [],
    );
  }

  /// `Fishing Games`
  String get textCategoryFishFull {
    return Intl.message(
      'Fishing Games',
      name: 'textCategoryFishFull',
      desc: '',
      args: [],
    );
  }

  /// `Game`
  String get textCategoryGames {
    return Intl.message(
      'Game',
      name: 'textCategoryGames',
      desc: '',
      args: [],
    );
  }

  /// `Gift`
  String get textCategoryGift {
    return Intl.message(
      'Gift',
      name: 'textCategoryGift',
      desc: '',
      args: [],
    );
  }

  /// `Lottery`
  String get textCategoryLottery {
    return Intl.message(
      'Lottery',
      name: 'textCategoryLottery',
      desc: '',
      args: [],
    );
  }

  /// `Lottery Games`
  String get textCategoryLotteryFull {
    return Intl.message(
      'Lottery Games',
      name: 'textCategoryLotteryFull',
      desc: '',
      args: [],
    );
  }

  /// `Cinema`
  String get textCategoryMovie {
    return Intl.message(
      'Cinema',
      name: 'textCategoryMovie',
      desc: '',
      args: [],
    );
  }

  /// `Movies`
  String get textCategoryMovieWeb {
    return Intl.message(
      'Movies',
      name: 'textCategoryMovieWeb',
      desc: '',
      args: [],
    );
  }

  /// `Click me to watch the movie`
  String get textCategoryMovieWebHint {
    return Intl.message(
      'Click me to watch the movie',
      name: 'textCategoryMovieWebHint',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get textCategoryOther {
    return Intl.message(
      'Other',
      name: 'textCategoryOther',
      desc: '',
      args: [],
    );
  }

  /// `Webmaster Recommended`
  String get textCategoryRecommend {
    return Intl.message(
      'Webmaster Recommended',
      name: 'textCategoryRecommend',
      desc: '',
      args: [],
    );
  }

  /// `Slot`
  String get textCategorySlot {
    return Intl.message(
      'Slot',
      name: 'textCategorySlot',
      desc: '',
      args: [],
    );
  }

  /// `Slot Games`
  String get textCategorySlotFull {
    return Intl.message(
      'Slot Games',
      name: 'textCategorySlotFull',
      desc: '',
      args: [],
    );
  }

  /// `Sport`
  String get textCategorySport {
    return Intl.message(
      'Sport',
      name: 'textCategorySport',
      desc: '',
      args: [],
    );
  }

  /// `Sport Games`
  String get textCategorySportFull {
    return Intl.message(
      'Sport Games',
      name: 'textCategorySportFull',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get textCategoryWeb {
    return Intl.message(
      'Website',
      name: 'textCategoryWeb',
      desc: '',
      args: [],
    );
  }

  /// `Click me to open the {site} website`
  String textCategoryWebHint(Object site) {
    return Intl.message(
      'Click me to open the $site website',
      name: 'textCategoryWebHint',
      desc: '',
      args: [site],
    );
  }

  /// `Hello, dear member! If you have any questions about use, please use the online customer service system.`
  String get textDefaultMarquee {
    return Intl.message(
      'Hello, dear member! If you have any questions about use, please use the online customer service system.',
      name: 'textDefaultMarquee',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get textLanguage {
    return Intl.message(
      'Language',
      name: 'textLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Total: {value}`
  String textTotalCredit(Object value) {
    return Intl.message(
      'Total: $value',
      name: 'textTotalCredit',
      desc: '',
      args: [value],
    );
  }

  /// `1. Please exit the game or game betting interface before transferring money.`
  String get textTransferHint1 {
    return Intl.message(
      '1. Please exit the game or game betting interface before transferring money.',
      name: 'textTransferHint1',
      desc: '',
      args: [],
    );
  }

  /// `2. When not participating in the activity, the amount of the account transfer cannot be less than 1 yuan, and there is no handling fee for the account transfer.`
  String get textTransferHint2 {
    return Intl.message(
      '2. When not participating in the activity, the amount of the account transfer cannot be less than 1 yuan, and there is no handling fee for the account transfer.',
      name: 'textTransferHint2',
      desc: '',
      args: [],
    );
  }

  /// `3. In case of slow internet speed, please wait patiently for a while instead of submitting it repeatedly.`
  String get textTransferHint3 {
    return Intl.message(
      '3. In case of slow internet speed, please wait patiently for a while instead of submitting it repeatedly.',
      name: 'textTransferHint3',
      desc: '',
      args: [],
    );
  }

  /// `4. If the platform amount has not changed after the transfer is successful, please refresh the platform manually or contact customer service`
  String get textTransferHint4 {
    return Intl.message(
      '4. If the platform amount has not changed after the transfer is successful, please refresh the platform manually or contact customer service',
      name: 'textTransferHint4',
      desc: '',
      args: [],
    );
  }

  /// `Unable to get the download URL, please contact customer service!!`
  String get textUpdateErrorUrl {
    return Intl.message(
      'Unable to get the download URL, please contact customer service!!',
      name: 'textUpdateErrorUrl',
      desc: '',
      args: [],
    );
  }

  /// `If a new version is found, please click the "Update" button to download and install.\nCurrent version number: {version}\nNew version number: {value}`
  String textUpdateMessage(Object value, Object version) {
    return Intl.message(
      'If a new version is found, please click the "Update" button to download and install.\nCurrent version number: $version\nNew version number: $value',
      name: 'textUpdateMessage',
      desc: '',
      args: [value, version],
    );
  }

  /// `All platform credits are transferred to the main wallet`
  String get walletBtnHintOneClickTransfer {
    return Intl.message(
      'All platform credits are transferred to the main wallet',
      name: 'walletBtnHintOneClickTransfer',
      desc: '',
      args: [],
    );
  }

  /// `One-click transfer all`
  String get walletBtnOneClickTransfer {
    return Intl.message(
      'One-click transfer all',
      name: 'walletBtnOneClickTransfer',
      desc: '',
      args: [],
    );
  }

  /// `*Need to manually transfer the quota to the game platform`
  String get walletHintWalletMulti {
    return Intl.message(
      '*Need to manually transfer the quota to the game platform',
      name: 'walletHintWalletMulti',
      desc: '',
      args: [],
    );
  }

  /// `*By default, the credit will be automatically transferred to the open game platform`
  String get walletHintWalletSingle {
    return Intl.message(
      '*By default, the credit will be automatically transferred to the open game platform',
      name: 'walletHintWalletSingle',
      desc: '',
      args: [],
    );
  }

  /// `*When the setting is turned on, the wallet limit will be automatically transferred to the opened game platform\n(Each change needs to wait 30 seconds for the setting to take effect)`
  String get walletHintWalletType {
    return Intl.message(
      '*When the setting is turned on, the wallet limit will be automatically transferred to the opened game platform\n(Each change needs to wait 30 seconds for the setting to take effect)',
      name: 'walletHintWalletType',
      desc: '',
      args: [],
    );
  }

  /// `Multi wallet`
  String get walletOptionMulti {
    return Intl.message(
      'Multi wallet',
      name: 'walletOptionMulti',
      desc: '',
      args: [],
    );
  }

  /// `Single wallet`
  String get walletOptionSingle {
    return Intl.message(
      'Single wallet',
      name: 'walletOptionSingle',
      desc: '',
      args: [],
    );
  }

  /// `Change wallet settings`
  String get walletTextChangeType {
    return Intl.message(
      'Change wallet settings',
      name: 'walletTextChangeType',
      desc: '',
      args: [],
    );
  }

  /// `Returning, please wait...`
  String get walletTextWaitTransfer {
    return Intl.message(
      'Returning, please wait...',
      name: 'walletTextWaitTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Central Wallet`
  String get walletTitleCenter {
    return Intl.message(
      'Central Wallet',
      name: 'walletTitleCenter',
      desc: '',
      args: [],
    );
  }

  /// `My`
  String get walletTitleMy {
    return Intl.message(
      'My',
      name: 'walletTitleMy',
      desc: '',
      args: [],
    );
  }

  /// `If you want to change the membership of the bank card bound to the network during withdrawal, please contact the online customer service for instructions.`
  String get withdrawHintChangeCard {
    return Intl.message(
      'If you want to change the membership of the bank card bound to the network during withdrawal, please contact the online customer service for instructions.',
      name: 'withdrawHintChangeCard',
      desc: '',
      args: [],
    );
  }

  /// `Each member account can only withdraw up to 3 withdrawals per day, if more than 3 withdrawals will be added 5% service charge.`
  String get withdrawHintFee {
    return Intl.message(
      'Each member account can only withdraw up to 3 withdrawals per day, if more than 3 withdrawals will be added 5% service charge.',
      name: 'withdrawHintFee',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}