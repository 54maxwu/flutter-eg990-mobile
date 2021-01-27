import 'package:flutter_eg990_mobile/core/mobx_store_export.dart';
import 'package:flutter_eg990_mobile/core/network/handler/request_status_model.dart';
import 'package:flutter_eg990_mobile/features/user/data/form/login_form.dart';
import 'package:flutter_eg990_mobile/features/user/data/models/user_model.dart';
import 'package:flutter_eg990_mobile/features/user/data/repository/user_repository.dart';

import '../../../data/form/register_form.dart';
import '../../../data/repository/user_repository.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  final UserRepository _repository;
  final StreamController _loginController = StreamController.broadcast();

  _RegisterStore(this._repository);

  Stream get loginStream => _loginController.stream;

  @observable
  RequestStatusModel registerResult;

  @observable
  bool waitForRegister = false;

  @observable
  String errorMessage;

  @action
  Future<void> postRegister(RegisterForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      registerResult = null;
      waitForRegister = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postRegister(form)
          .then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (model) {
//                print('register result: $model');
                registerResult = model;
                if (model.isSuccess) {
                  Future.delayed(Duration(milliseconds: 500), () {
                    postLogin(LoginForm(
                      account: form.username,
                      password: form.confirmPassword,
                    ));
                  });
                }
              },
            ),
          )
          .whenComplete(() => waitForRegister = false);
    } on Exception {
      waitForRegister = false;
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.REGISTER, code: 1))
              .message;
    }
  }

  @action
  Future<void> postLogin(LoginForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.login(form).then(
            (result) => result.fold(
              (failure) {
                print('auto login failed: $failure');
                _loginController.sink.add('');
              },
              (UserModel model) {
                print('login result: $model');
                _loginController.sink.add(model.entity);
              },
            ),
          );
    } on Exception {
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.REGISTER, code: 2))
              .message;
    }
  }

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _loginController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close register stream error', error: e, tag: 'RegisterStore');
      return null;
    }
  }
}
