import 'package:flutter_ty_mobile/core/mobx_store_export.dart';
import 'package:flutter_ty_mobile/features/member/data/repository/member_repository.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart';
import 'package:flutter_ty_mobile/features/user/data/entity/login_status.dart';
import 'package:flutter_ty_mobile/features/user/data/entity/user_entity.dart';

part 'member_credit_store.g.dart';

class MemberCreditStore = _MemberCreditStore with _$MemberCreditStore;

abstract class _MemberCreditStore with Store {
  final MemberRepository _repository;

  _MemberCreditStore(this._repository) {
    _userStream = ObservableStream(getRouteUserStreams.userStream);
    _userStream.listen((event) {
      user = event.currentUser;
      credit = user?.credit ?? '';
      print('member store user: $user, credit: $credit');
    });
  }

  @observable
  ObservableStream<LoginStatus> _userStream;

  @observable
  UserEntity user;

  @observable
  bool hasNewMessage = false;

  @observable
  ObservableFuture<Either<Failure, String>> _creditFuture;

  @observable
  String credit = '';

  @observable
  String errorMessage;

  final String creditResetStr = '￥---';

  void getUser() {
    user = getRouteUserStreams.lastStatus.currentUser;
  }

  @action
  Future<void> getNewMessageCount() async {
    // Reset the possible previous error message.
    errorMessage = null;
    // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
    await _repository.checkNewMessage().then((result) {
      print('new message result: $result');
      result.fold(
        (failure) => errorMessage = failure.message,
        (value) => hasNewMessage = value,
      );
    });
  }

  @action
  Future<void> getCredit() async {
    try {
      if (user == null) return;
      credit = creditResetStr;
      _creditFuture = ObservableFuture(_repository.updateCredit(user.account));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _creditFuture.then(
        (result) => result.fold(
          (failure) => errorMessage = failure.message,
          (value) {
            getRouteUserStreams.lastStatus.currentUser.updateCredit(value);
            credit = value;
          },
        ),
      );
      print('member store credit: $credit');
    } on Exception catch (e) {
      MyLogger.error(msg: 'member credit has exception', error: e);
    }
  }
}
