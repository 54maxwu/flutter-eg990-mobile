// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserInfoStore on _UserInfoStore, Store {
  final _$userNameAtom = Atom(name: '_UserInfoStore.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$userCreditAtom = Atom(name: '_UserInfoStore.userCredit');

  @override
  String get userCredit {
    _$userCreditAtom.reportRead();
    return super.userCredit;
  }

  @override
  set userCredit(String value) {
    _$userCreditAtom.reportWrite(value, super.userCredit, () {
      super.userCredit = value;
    });
  }

  final _$hasNewMessageAtom = Atom(name: '_UserInfoStore.hasNewMessage');

  @override
  bool get hasNewMessage {
    _$hasNewMessageAtom.reportRead();
    return super.hasNewMessage;
  }

  @override
  set hasNewMessage(bool value) {
    _$hasNewMessageAtom.reportWrite(value, super.hasNewMessage, () {
      super.hasNewMessage = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_UserInfoStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$getUserCreditAsyncAction =
      AsyncAction('_UserInfoStore.getUserCredit');

  @override
  Future<void> getUserCredit() {
    return _$getUserCreditAsyncAction.run(() => super.getUserCredit());
  }

  final _$getNewMessageCountAsyncAction =
      AsyncAction('_UserInfoStore.getNewMessageCount');

  @override
  Future<void> getNewMessageCount() {
    return _$getNewMessageCountAsyncAction
        .run(() => super.getNewMessageCount());
  }

  final _$logoutAsyncAction = AsyncAction('_UserInfoStore.logout');

  @override
  Future<void> logout({bool clean = false, bool navToLogin = true}) {
    return _$logoutAsyncAction
        .run(() => super.logout(clean: clean, navToLogin: navToLogin));
  }

  @override
  String toString() {
    return '''
userName: ${userName},
userCredit: ${userCredit},
hasNewMessage: ${hasNewMessage},
errorMessage: ${errorMessage}
    ''';
  }
}
