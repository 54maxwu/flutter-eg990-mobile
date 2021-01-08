import 'dart:async';

import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/domain/sector/member_center/form/password_form.dart';
import 'package:flutter_eg990_mobile/domain/sector/member_center/member_detail_model.dart';
import 'package:flutter_eg990_mobile/domain/sector/member_center/member_detail.dart';
import 'package:flutter_eg990_mobile/domain/sector/member_center/vip/member_vip_data.dart';
import 'package:flutter_eg990_mobile/domain/sector/member_center/member_center_repository.dart';
import 'package:flutter_eg990_mobile/domain/user/login/login_form_hive.dart';
import 'package:flutter_eg990_mobile/infrastructure/hive/hive_actions.dart';
import 'package:flutter_eg990_mobile/presentation/mobx_store_export.dart';

import 'member_center_store_action_result.dart';

part 'member_center_store.g.dart';

class MemberCenterStore = _MemberCenterStore with _$MemberCenterStore;

enum MemberCenterStoreState { initial, loading, loaded, error }

abstract class _MemberCenterStore with Store {
  final MemberCenterRepository _repository;

  _MemberCenterStore(this._repository);

  // final StreamController<T> _dataController = StreamController<T>();
  //
  // Stream<List<T>> get dataStream => _dataController.stream;

  @observable
  ObservableFuture<Either<Failure, MemberDetailModel>> _initDataFuture;

  @observable
  bool waitForInitComplete = true;

  @observable
  MemberDetail memberDetail;

  @observable
  MemberVipData memberVipData;

  @observable
  MemberCenterStoreActionResult storeActionResult;

  @observable
  String errorMessage;

  bool _errorState = false;

  void setErrorMsg(
          {String msg, bool showOnce = false, FailureType type, int code}) =>
      errorMessage = getErrorMsg(
          from: FailureType.MEMBER,
          msg: msg,
          showOnce: showOnce,
          type: type,
          code: code);

  @computed
  MemberCenterStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_initDataFuture == null ||
        _initDataFuture.status == FutureStatus.rejected) {
      return MemberCenterStoreState.initial;
    }
    if (_errorState) {
      return MemberCenterStoreState.error;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _initDataFuture.status == FutureStatus.pending || waitForInitComplete
        ? MemberCenterStoreState.loading
        : MemberCenterStoreState.loaded;
  }

  @action
  Future<void> initialize() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch first data from the repository and wrap the regular Future into an observable.
      // This _initDataFuture triggers widget updates to the computed state property.
      _initDataFuture = ObservableFuture(_repository.getAccount());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _initDataFuture.then((result) => result.fold(
            (failure) {
              setErrorMsg(msg: failure.message, showOnce: true);
              _errorState = true;
            },
            (model) {
              Future.microtask(() {
                memberDetail = model.wrapAccountData;
                memberVipData = model.wrapVipData;
              }).whenComplete(() => waitForInitComplete = false);
            },
          ));
    } catch (e) {
      setErrorMsg(code: 1);
      debugPrint('MemberCenterStore Error: $errorMessage, Exception: $e');
    }
  }

  @action
  Future<void> sendRequest(MemberCenterStoreAction action, dynamic data) {
    switch (action) {
      case MemberCenterStoreAction.PASSWORD:
        if (data is PasswordForm) {
          _changePassword(data);
        } else {
          setErrorMsg(msg: Failure.dataType().message);
        }
        break;
      case MemberCenterStoreAction.BIRTH:
        break;
      case MemberCenterStoreAction.EMAIL:
        break;
      case MemberCenterStoreAction.WECHAT:
        break;
      case MemberCenterStoreAction.ZALO:
        break;
      case MemberCenterStoreAction.VERIFY_REQUEST:
        break;
      case MemberCenterStoreAction.VERIFY:
        break;
    }
    return Future<void>.value();
  }

  @action
  Future<void> _changePassword(PasswordForm form) async {
    final MemberCenterStoreActionResult actionResult =
        MemberCenterStoreActionResult(action: MemberCenterStoreAction.PASSWORD);
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.postPassword(form).then((result) {
//        debugPrint('center password result: $result');
        return result.fold(
          (failure) {
            storeActionResult = actionResult.copyWith(
              success: false,
              msg: failure.message,
            );
          },
          (data) async {
            if (data.isSuccess) {
              await _resetSavedLoginPassword();
            }
            storeActionResult = actionResult.copyWith(
              success: data.isSuccess,
              msg: data.msg,
            );
          },
        );
      });
    } on Exception {
      setErrorMsg(code: 2);
      storeActionResult = actionResult.copyWith(success: false, msg: '');
    }
  }

  @action
  Future<void> _resetSavedLoginPassword() async {
    // Reset the possible previous error message.
    errorMessage = null;
    // Fetch from the repository and wrap the regular Future into an observable.
    // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
    await getHiveBox(Global.CACHE_LOGIN_FORM).then((value) {
      final _box = value;
      if (_box != null && _box.isNotEmpty) {
        final LoginFormHive hiveForm = _box.values?.last;
        if (memberDetail.accountCode == hiveForm.username) {
          final LoginFormHive newForm = hiveForm.copyWith(password: '');
          Future.sync(() {
            _box
                .putAt(0, newForm)
                .whenComplete(() => debugPrint('Login Hive - data updated'))
                .catchError((e) => MyLogger.error(
                    msg: 'Save error: $_box',
                    error: e,
                    tag: 'MemberCenterStore'));
          });
        }
      }
    });
  }
}
