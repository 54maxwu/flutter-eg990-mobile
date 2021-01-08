import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';

import 'member_detail_model.dart';
import 'form/password_form.dart';

class MemberCenterApi {
  static const String GET_ACCOUNT = "api/center";
  static const String GET_CGP_URL = "api/bindcgp";
  static const String GET_CPW_URL = "api/bindcpw";
  static const String POST_PASSWORD = "api/edit_password";
  static const String POST_BIRTH = "api/edit_dob";
  static const String POST_EMAIL = "api/edit_email";
  static const String POST_WECHAT = "api/edit_wechat";
  static const String POST_ZALO = "api/edit_zalo";
  static const String POST_LUCKY = "api/edit_lucky";
  static const String POST_VERIFY_REQUEST = "api/sendMessage";
  static const String POST_VERIFY = "api/checkVerifyCode";
  static const String JWT_CHECK_HREF = "/center";
}

abstract class MemberCenterRepository {
  Future<Either<Failure, MemberDetailModel>> getAccount();

  Future<Either<Failure, RequestStatusModel>> postPassword(PasswordForm form);

  Future<Either<Failure, RequestStatusModel>> postBirth(String dateOfBirth);

  Future<Either<Failure, RequestStatusModel>> postEmail(String email);

  Future<Either<Failure, RequestStatusModel>> postWechat(String wechatId);

  Future<Either<Failure, RequestStatusModel>> postZalo(String zaloId);

  Future<Either<Failure, RequestStatusModel>> postLucky(List<int> numbers);

  Future<Either<Failure, RequestCodeModel>> postVerifyRequest(String mobile);

  Future<Either<Failure, RequestCodeModel>> postVerify(
      String mobile, String code);
}

class MemberCenterRepositoryImpl implements MemberCenterRepository {
  final DioApiService dioApiService;
  final JwtInterface jwtInterface;
  final tag = 'CenterRepository';

  MemberCenterRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<Either<Failure, MemberDetailModel>> getAccount() async {
    final result = await requestModel<MemberDetailModel>(
      request: dioApiService.get(
        MemberCenterApi.GET_ACCOUNT,
        userToken: jwtInterface.token,
      ),
      parseJson: MemberDetailModel.parseJson,
      tag: 'remote-MEMBER_ACCOUNT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => (model.accountCode != null)
          ? Right(model)
          : Left(Failure.token(FailureType.MEMBER)),
    );
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postPassword(
    PasswordForm form,
  ) async {
    final result = await requestModel<RequestStatusModel>(
      request: dioApiService.post(
        MemberCenterApi.POST_PASSWORD,
        data: form.toJson(),
        userToken: jwtInterface.token,
      ),
      parseJson: RequestStatusModel.parseJson,
      tag: 'remote-CENTER_PWD',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postBirth(
    String dateOfBirth,
  ) async {
    final result = await requestModel<RequestStatusModel>(
      request: dioApiService.post(
        MemberCenterApi.POST_BIRTH,
        data: {'dob': dateOfBirth},
        userToken: jwtInterface.token,
      ),
      parseJson: RequestStatusModel.parseJson,
      tag: 'remote-CENTER_BIRTH',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postEmail(String email) async {
    final result = await requestModel<RequestStatusModel>(
      request: dioApiService.post(
        MemberCenterApi.POST_EMAIL,
        data: {'email': email},
        userToken: jwtInterface.token,
      ),
      parseJson: RequestStatusModel.parseJson,
      tag: 'remote-CENTER_EMAIL',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postWechat(
    String wechatId,
  ) async {
    final result = await requestModel<RequestStatusModel>(
      request: dioApiService.post(
        MemberCenterApi.POST_WECHAT,
        data: {'wechat': wechatId},
        userToken: jwtInterface.token,
      ),
      parseJson: RequestStatusModel.parseJson,
      tag: 'remote-CENTER_WECHAT',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postZalo(
    String zaloId,
  ) async {
    final result = await requestModel<RequestStatusModel>(
      request: dioApiService.post(
        MemberCenterApi.POST_ZALO,
        data: {'zalo': zaloId},
        userToken: jwtInterface.token,
      ),
      parseJson: RequestStatusModel.parseJson,
      tag: 'remote-CENTER_ZALO',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postLucky(
    List<int> numbers,
  ) async {
    final result = await requestModel<RequestStatusModel>(
      request: dioApiService.post(
        MemberCenterApi.POST_LUCKY,
        data: {'lucky': JsonUtil.encodeToJsonArray(numbers)},
        userToken: jwtInterface.token,
      ),
      parseJson: RequestStatusModel.parseJson,
      tag: 'remote-CENTER_LUCKY',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> postVerifyRequest(
    String mobile,
  ) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        MemberCenterApi.POST_VERIFY_REQUEST,
        data: {'phone': mobile},
        userToken: jwtInterface.token,
      ),
      parseJson: RequestCodeModel.parseJson,
      tag: 'remote-CENTER_VERIFY',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> postVerify(
    String mobile,
    String code,
  ) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        MemberCenterApi.POST_VERIFY,
        data: {'phone': mobile, 'code': code},
        userToken: jwtInterface.token,
      ),
      parseJson: RequestCodeModel.parseJson,
      tag: 'remote-CENTER_VERIFY',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }
}
