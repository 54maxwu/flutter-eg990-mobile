import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/domain/core/exceptions.dart';
import 'package:flutter_eg990_mobile/domain/core/failures.dart';
import 'package:flutter_eg990_mobile/infrastructure/core/network_info.dart';
import 'package:flutter_eg990_mobile/infrastructure/core/task_extension.dart';
import 'package:flutter_eg990_mobile/injection_container.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:meta/meta.dart' show required;

///
/// Catch exceptions and throws [Failure], which will be mapped to Left by [runTask]
///
/// Catch [TokenException], which is thrown when server response contains token error message.
/// Catch [ResponseException] and exceptions from dio service as [ServerException].
/// Catch [FormatException] on error data type.
/// Catch other [Exception] caused by the call.
///
Future<dynamic> _exceptionHandler(Function func, String tag) async {
  try {
    return await Future.microtask(func);
  } on TokenException {
    MyLogger.warn(msg: 'Request Failed: Token Exception', tag: tag);
    throw Failure.token(FailureType.TOKEN);
  } on RequestTypeErrorException catch (e, s) {
    MyLogger.wtf(
        msg: 'Request type error, please check api GET/POST usage',
        tag: tag,
        error: e,
        stackTrace: s);
    throw Failure.internal(FailureCode(type: FailureType.TASK, code: 1));
  } on ServerException {
    MyLogger.warn(msg: 'Request Failed: Server Exception', tag: tag);
    throw Failure.server();
  } on FormatException catch (e, s) {
    MyLogger.wtf(msg: 'Data format error!!', tag: tag, error: e, stackTrace: s);
    throw e;
  } on Exception catch (e, s) {
    MyLogger.error(
        msg: 'Something went wrong!!', tag: tag, error: e, stackTrace: s);
    throw Failure.internal(FailureCode(type: FailureType.TASK, code: 2));
  }
}

Future _makeRequest({
  @required Future<Response> request,
  String tag = 'remote-DATA',
}) async {
  // check if network is connected
  final connected = await sl.get<NetworkInfo>()?.isConnected ?? false;
//  debugPrint('network connected: $connected');
  if (!connected) return Failure.network();
  // request data with exception handler
  final result = await _exceptionHandler(() async {
    final response = await request;
    if (response == null ||
        response.statusCode == null ||
        response.statusCode != 200) {
      throw ResponseException();
    }
    final String resp = '${response.data}';
    if (resp.startsWith('<!DOCTYPE html>')) {
      throw RequestTypeErrorException();
    } else if (resp.contains('Repeat token') || resp.contains('RepeatToken')) {
      throw TokenException();
    }
    return response.data;
  }, tag);
  // MyLogger.debug(msg: 'remote data result: $result', tag: tag);
  return result;
}

Future _makeHeaderRequest({
  @required Future<Response> request,
  String tag = 'remote-HEADER',
}) async {
  // check if network is connected
  final connected = await sl.get<NetworkInfo>()?.isConnected ?? false;
//  debugPrint('network connected: $connected');
  if (!connected) return Failure.network();
  // request data with exception handler
  final result = await _exceptionHandler(() async {
    final response = await request;
    if (response == null ||
        response.statusCode == null ||
        response.statusCode != 200) throw ResponseException();
    return [response.headers, response.data];
  }, tag);
//  MyLogger.debug(msg: 'remote header result: $result', tag: tag);
  return result;
}

///
/// Request server data and return response data as string
///
Future<Either<Failure, String>> requestDataString({
  @required Future<Response<dynamic>> request,
  bool allowJsonString = false,
  String tag = 'remote-STRING',
}) async {
  return await runTask(_makeRequest(request: request, tag: tag)).then((result) {
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (!allowJsonString && (data.startsWith('{') || data.startsWith('[')))
          return Left(Failure.jsonFormat());
        if (data is Map)
          return Right('${jsonEncode(data)}');
        else
          return Right('$data');
      },
    );
  });
}

///
/// Request server data and return response data
///
Future<Either<Failure, dynamic>> requestData({
  @required Future<Response<dynamic>> request,
  String tag = 'remote-DATA',
}) async {
  return await runTask(_makeRequest(request: request, tag: tag)).then((result) {
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  });
}

///
/// Request server data and return response data as required model data
/// call example:
///
///   Future<Either<Failure, DataModel>> getData() async {
///     final result = await requestModel<DataModel>(
///        request: dioApiService.get(
///          DataApi.GET_DATA,
///          userToken: jwtInterface.token,
///        ),
///        parseJson: DataModel.parseJson,
///     );
///     debugPrint('test response type: ${result.runtimeType}, data: $result');
///     return result.fold(
///       (failure) => Left(failure),
///       (model) => Right(model),
///     );
///  }
///
Future<Either<Failure, T>> requestModel<T>({
  @required Future<Response<dynamic>> request,
  @required Function(Map<String, dynamic> jsonMap) parseJson,
  bool trim = false,
  String tag = 'remote-MODEL',
}) async {
  return await runTask(_makeRequest(request: request, tag: tag)).then((result) {
    return result.fold((failure) => Left(failure), (data) {
      try {
        return Right(
            JsonUtil.decodeToModel<T>(data, parseJson, trim: trim, tag: tag));
      } on TokenException {
        return Left(Failure.token(FailureType.TOKEN));
      }
    });
  });
}

///
/// Request server data and return response data as data model list
///
Future<Either<Failure, List<T>>> requestModelList<T>({
  @required Future<Response<dynamic>> request,
  @required Function(Map<String, dynamic> jsonMap) parseJson,
  bool trim = false,
  bool addKey = true,
  String tag = 'remote-MODEL_LIST',
}) async {
  return await runTask(_makeRequest(request: request, tag: tag)).then((result) {
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data.toString() == '[]') return Right([]);
        try {
          final model = (data.toString().startsWith('['))
              ? JsonUtil.decodeArrayToModel<T>(
                  data,
                  parseJson,
                  trim: trim,
                  tag: tag,
                )
              : JsonUtil.decodeMapToModelList<T>(
                  (data is Map) ? data : jsonDecode(data),
                  parseJson,
                  trim: trim,
                  addKey: addKey,
                  tag: tag,
                );
          return Right(model);
        } catch (e, s) {
          MyLogger.error(
              msg: 'map data to model list has exception: $e\n$s',
              tag: tag,
              stackTrace: s);
          MyLogger.debug(
              msg: 'type:${data.runtimeType}, data: $data', tag: tag);
          return Left(Failure.jsonFormat());
        }
      },
    );
  });
}

///
/// Request server data and return response header
/// [header] is the key of header map
///
Future<Either<Failure, dynamic>> requestHeader({
  @required Future<Response<dynamic>> request,
  @required String header,
  String tag = 'remote-Header',
}) async {
  return await runTask(_makeHeaderRequest(request: request)).then((result) {
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (data[0] is Headers) {
          String headerRequested = data[0].value(header);
          debugPrint('test header cookie: $headerRequested');
          return Right(headerRequested ?? data[1]);
        }
        return Left(
            Failure.internal(FailureCode(type: FailureType.TASK, code: 3)));
      },
    );
  });
}
