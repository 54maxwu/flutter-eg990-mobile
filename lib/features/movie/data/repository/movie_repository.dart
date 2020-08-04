import 'package:dio/dio.dart';
import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/member/data/repository/member_jwt_interface.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';

import '../models/movie_category_model.dart';
import '../models/movie_hot_model.dart';
import '../models/movie_model.dart';
import '../models/movie_post_model.dart';

class MovieApi {
  static const String EG_MOVIE_CATEGORY = "api/movieCate_2";
  static const String EG_MOVIE_LIST = "api/movieList_2";
  static const String EG_MOVIE_COLLECT = "api/movieCollect_2";
  static const String EG_MOVIE_OWN = "api/movieOwn_2";
  static const String EG_MOVIE_POST = "api/moviePost_2";
  static const String EG_MOVIE_HOT = "api/movieHot_2";
  static const String EG_MOVIE_FAVORITE = "api/movieFavorite_2";
  static const String EG_MOVIE_HOBBY = "api/movieHobby_2";
  static const String EG_MOVIE_BUY = "api/movieBuy_2";
  static const String EG_MOVIE_BUY_FREE = "api/movieFree_2";

  static const String NEW_MOVIE_CATEGORY = "api/movieCate_3";
  static const String NEW_MOVIE_LIST = "api/movieList_3";
  static const String NEW_MOVIE_COLLECT = "api/movieCollect_3";
  static const String NEW_MOVIE_OWN = "api/movieOwn_3";
  static const String NEW_MOVIE_POST = "api/moviePost_3";
  static const String NEW_MOVIE_HOT = "api/movieHot_3";
  static const String NEW_MOVIE_FAVORITE = "api/movieFavorite_3";
  static const String NEW_MOVIE_HOBBY = "api/movieHobby_3";
  static const String NEW_MOVIE_BUY = "api/movieBuy_3";
  static const String NEW_MOVIE_BUY_FREE = "api/movieFree_3";

  static const String POST_VERIFY_REQUEST = "api/sendMessage";
  static const String POST_VERIFY = "api/checkVerifyCode";
}

abstract class MovieRepository {
  Future<Either<Failure, List<MovieCategoryModel>>> getEgCategory();

  Future<Either<Failure, List<MovieModel>>> getEgMovieList(
      {int page = 1, @required dynamic tid});

  Future<Either<Failure, MoviePostModel>> getEgMoviePost(
      {@required dynamic tid, @required int mid});

  Future<Either<Failure, List<MovieHotModel>>> getEgHotMovies(
      {@required dynamic tid});

  Future<Either<Failure, bool>> postEgMovieFavorite(
      {@required int mid, @required bool isFavorite});

  Future<Either<Failure, bool>> postEgMovieHobby(
      {@required int mid, @required int hobby});

  Future<Either<Failure, RequestCodeModel>> postEgMovieBuy({@required int mid});

  Future<Either<Failure, RequestCodeModel>> postEgMovieFree(
      {@required int mid});

  Future<Either<Failure, RequestCodeModel>> requestPhoneVerifyCode(
      String mobile);

  Future<Either<Failure, RequestCodeModel>> postPhoneVerifyCode(
      String mobile, String code);

  void cancelLastMovieListRequest();
}

class MovieRepositoryImpl implements MovieRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'MovieRepository';
  bool jwtChecked = false;
  CancelToken _cancelToken;

  MovieRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    _cancelToken = new CancelToken();
    Future.value(jwtInterface.checkJwt('/'))
        .then((value) => jwtChecked = value.isSuccess);
  }

  @override
  Future<Either<Failure, List<MovieCategoryModel>>> getEgCategory() async {
    final result = await requestData(
      request: dioApiService.get(
        MovieApi.NEW_MOVIE_CATEGORY,
        userToken: jwtInterface.token,
      ),
      tag: 'remote-NEW_MOVIE',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data is List)
          return Right(JsonUtil.decodeArrayToModel(
            data,
            (jsonMap) => MovieCategoryModel.jsonToModel(jsonMap),
          ));
        else
          return Left(Failure.jsonFormat());
      },
    );
  }

  @override
  void cancelLastMovieListRequest() {
    try {
      dioApiService.cancelRequests(_cancelToken);
    } catch (e) {
      MyLogger.warn(msg: 'cancel last movie list failed!! $e', tag: tag);
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getEgMovieList({
    int page = 1,
    @required dynamic tid,
  }) async {
    String api;
    switch (tid) {
      case 'love':
        api = MovieApi.NEW_MOVIE_COLLECT;
        break;
      case 'buy':
        api = MovieApi.NEW_MOVIE_OWN;
        break;
      default:
        api = MovieApi.NEW_MOVIE_LIST;
        break;
    }
    final result = await requestData(
      request: dioApiService.post(
        api,
        userToken: jwtInterface.token,
        cancelToken: _cancelToken,
        data: {'page': page, 'tid': tid},
      ),
      tag: 'remote-NEW_MOVIE',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data is List)
          return Right(JsonUtil.decodeArrayToModel(
            data,
            (jsonMap) => MovieModel.jsonToModel(jsonMap),
          ));
        else
          return Left(Failure.jsonFormat());
      },
    );
  }

  @override
  Future<Either<Failure, MoviePostModel>> getEgMoviePost({tid, int mid}) async {
    final result = await requestModel<MoviePostModel>(
      request: dioApiService.post(
        MovieApi.NEW_MOVIE_POST,
        userToken: jwtInterface.token,
        data: {'tid': tid, 'mid': mid},
      ),
      jsonToModel: MoviePostModel.jsonToModel,
      tag: 'remote-NEW_MOVIE',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }

  @override
  Future<Either<Failure, List<MovieHotModel>>> getEgHotMovies({tid}) async {
    String api;
    switch (tid) {
      case 'love':
        api = MovieApi.NEW_MOVIE_COLLECT;
        break;
      case 'buy':
        api = MovieApi.NEW_MOVIE_OWN;
        break;
      default:
        api = MovieApi.NEW_MOVIE_HOT;
        break;
    }
    final result = await requestData(
      request: dioApiService.post(
        api,
        userToken: jwtInterface.token,
        data: {'tid': tid},
      ),
      tag: 'remote-NEW_MOVIE',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data is List)
          return Right(JsonUtil.decodeArrayToModel(
            data,
            (jsonMap) => MovieHotModel.jsonToModel(jsonMap),
          ));
        else
          return Left(Failure.jsonFormat());
      },
    );
  }

  @override
  Future<Either<Failure, bool>> postEgMovieFavorite({
    int mid,
    bool isFavorite,
  }) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        MovieApi.NEW_MOVIE_FAVORITE,
        userToken: jwtInterface.token,
        data: {'mid': mid, 'status': (isFavorite) ? 1 : -1},
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-NEW_MOVIE',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data.isSuccess),
    );
  }

  @override
  Future<Either<Failure, bool>> postEgMovieHobby({
    int mid,
    int hobby,
  }) async {
    if ([-1, 0, 1].contains(hobby) == false)
      return Left(Failure.internal(FailureCode()));
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        MovieApi.NEW_MOVIE_HOBBY,
        userToken: jwtInterface.token,
        data: {'mid': mid, 'status': (hobby == 0) ? 'c' : hobby},
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-NEW_MOVIE',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data.isSuccess),
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> postEgMovieBuy({int mid}) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        MovieApi.NEW_MOVIE_BUY,
        userToken: jwtInterface.token,
        data: {'mid': mid},
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-NEW_MOVIE',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> postEgMovieFree({int mid}) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        MovieApi.NEW_MOVIE_BUY_FREE,
        userToken: jwtInterface.token,
        data: {'mid': mid},
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-NEW_MOVIE',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> requestPhoneVerifyCode(
      String mobile) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        MovieApi.POST_VERIFY_REQUEST,
        data: {'phone': mobile},
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-CENTER_VERIFY',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> postPhoneVerifyCode(
      String mobile, String code) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(
        MovieApi.POST_VERIFY,
        data: {'phone': mobile, 'code': code},
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-CENTER_VERIFY',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }
}
