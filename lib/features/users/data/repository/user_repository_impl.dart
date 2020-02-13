import 'package:dartz/dartz.dart';
import 'package:flutter_ty_mobile/core/data/data_request_handler.dart'
    show handleResponse;
import 'package:flutter_ty_mobile/core/error/failures.dart';
import 'package:flutter_ty_mobile/core/network/util/network_info.dart';
import 'package:flutter_ty_mobile/features/home/domain/usecase/usecase_export.dart';
import 'package:flutter_ty_mobile/features/users/data/form/login_form.dart';
import 'package:flutter_ty_mobile/features/users/data/models/user_model.dart';
import 'package:flutter_ty_mobile/features/users/data/source/user_data_source.dart';
import 'package:flutter_ty_mobile/features/users/domain/entity/user_entity.dart';
import 'package:flutter_ty_mobile/features/users/domain/repository/user_repository.dart';
import 'package:meta/meta.dart' show required;

class UserRepositoryImpl implements UserRepository {
  final tag = 'UserRepository';
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> getAccount(UserLoginForm form) async {
    final connected = await networkInfo.isConnected;
    print('network connected: $connected');
    MyLogger.print(msg: 'login form: $form', tag: tag);
    if (connected) {
      final result =
          await handleResponse<UserModel>(remoteDataSource.getAccount(form));
      return result.fold(
        (failure) => Left(failure),
        (model) {
          print('test model parent caller: ${model.parent}');
          return Right(model.parent);
        },
      );
    }
    return Left(NetworkFailure());
  }
}
