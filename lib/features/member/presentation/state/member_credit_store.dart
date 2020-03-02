import 'package:flutter_ty_mobile/core/base/usecase_export.dart';
import 'package:flutter_ty_mobile/features/general/data/user/user_data.dart';
import 'package:flutter_ty_mobile/features/router/router_navigate.dart'
    show getRouteUserStreams;
import 'package:flutter_ty_mobile/features/users/domain/entity/user_entity.dart';
import 'package:flutter_ty_mobile/utils/string_util.dart'
    show ValueStringExtension;
import 'package:mobx/mobx.dart';

import '../../data/repository/member_repository.dart';

part 'member_credit_store.g.dart';

class MemberCreditStore = _MemberCreditStore with _$MemberCreditStore;

enum MemberCreditStoreState { initial, loading, loaded }

abstract class _MemberCreditStore with Store {
  final MemberRepository _repository;

  _MemberCreditStore(this._repository) {
    user = getRouteUserStreams.currentUser.user;
    print('member store user: $user');
  }

  @observable
  ObservableFuture<UserData> _userFuture;

  @observable
  UserEntity user;

  @observable
  ObservableFuture<String> _creditFuture;

  @observable
  String credit = '';

  @computed
  MemberCreditStoreState get state {
    if (_creditFuture == null ||
        _creditFuture.status == FutureStatus.rejected) {
      return MemberCreditStoreState.initial;
    }
    return _creditFuture.status == FutureStatus.pending
        ? MemberCreditStoreState.loading
        : MemberCreditStoreState.loaded;
  }

  @action
  Future<UserEntity> getUser() async {
    try {
      _userFuture = ObservableFuture(getRouteUserStreams.userStream.last);
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      user = await _userFuture.then((value) => value.user);
      print('member-store user: $user');
    } on Exception catch (e) {
      MyLogger.error(msg: 'member user has exception', error: e);
    }
    return user;
  }

  @action
  Future getCredit() async {
    try {
      if (user == null) return;
      _creditFuture = ObservableFuture(_repository.updateCredit(user.account));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      credit = await _creditFuture
          .then((value) => value.trimValue(floorIfInt: true, creditSign: true));
      print('member-store credit: $credit');
    } on Exception catch (e) {
      MyLogger.error(msg: 'member credit has exception', error: e);
    }
  }
}
