import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:flutter_ty_mobile/utils/json_decode_util.dart';
import 'package:meta/meta.dart' show required;

import '../error/exceptions.dart';
import '../error/failures.dart';

/// This function should be used inside Data Source class.
/// Wrapped api request in [_handleRequest] to generalize the request action.
///
/// Takes in a [request] and wait for the response or throw failure if request failed.
/// Throws [ResponseException] if response code is not 200 which will be catch as [ServerException].
///
/// Takes in a [jsonToModel] function to transform the response json to desired model entity [T].
Future<List<T>> requestList<T>({
  @required Future<Response<dynamic>> request,
  @required Function(Map<String, dynamic> jsonMap) jsonToModel,
  String tag = 'remote-List',
}) async {
  final result = await _handleRequest(() async {
    final response = await request;
    if (response.statusCode != 200) throw ResponseException();
    if (response.data.toString().startsWith('['))
      return _jsonToList<T>(response.data, jsonToModel, tag);
    else {
      return [_jsonToData<T>(response.data, jsonToModel, tag)];
    }
  }, tag);
  MyLogger.debug(msg: 'remote list type: ${result.runtimeType}', tag: tag);
  return result;
}

Future<T> requestData<T>({
  @required Future<Response<dynamic>> request,
  @required Function(Map<String, dynamic> jsonMap) jsonToModel,
  String tag = 'remote-Data',
}) async {
  final result = await _handleRequest(() async {
    final response = await request;
    if (response.statusCode != 200) throw ResponseException();
    if (response.data.toString().startsWith('['))
      throw MapJsonDataException();
    else {
      return _jsonToData<T>(response.data, jsonToModel, tag);
    }
  }, tag);
  MyLogger.debug(msg: 'remote data type: ${result.runtimeType}', tag: tag);
  return result;
}

Future<List<String>> requestResponseHeader({
  @required Future<Response<dynamic>> request,
  @required String header,
  String tag = 'remote-Response',
}) async {
  final result = await _handleRequest(() async {
    final response = await request;
    if (response.statusCode != 200) throw ResponseException();
    return response.headers.map[header];
  }, tag);
  MyLogger.debug(
      msg: 'remote header value type: ${result.runtimeType}', tag: tag);
  return result;
}

/// Throws [JsonFormatException] if [JsonDecodeUtil] cannot decode the json data.
/// Throws [MapJsonDataException] if the decoded json cannot be mapped into model entity.
/// Throws [FormatException] if [jsonToModel] returns data different then [T].
Future<dynamic> _handleRequest(Function func, String tag) async {
  try {
    return await Future.microtask(func);
  } on ServerException catch (e) {
    MyLogger.warn(msg: 'Request Failed: $e', tag: tag);
    throw ServerException();
  } on LocationException {
    MyLogger.warn(msg: 'Network Location Exception', tag: tag);
    throw LocationException();
  } on JsonFormatException catch (e) {
    MyLogger.error(msg: 'Json Decode Failed!!', tag: tag, error: e);
    throw e;
  } on FormatException catch (e, s) {
    MyLogger.wtf(msg: 'Data format error!!', tag: tag, error: e, stackTrace: s);
    throw e;
  } on Exception catch (e, s) {
    MyLogger.error(
        msg: 'Something went wrong!!', tag: tag, error: e, stackTrace: s);
    throw e;
  }
}

List<T> _jsonToList<T>(dynamic str,
    Function(Map<String, dynamic> jsonMap) jsonToModel, String tag) {
  MyLogger.debug(msg: 'start decoding array data to $T...', tag: tag);
  List<dynamic> list = JsonDecodeUtil.decodeArray(str);
  // mapped decoded data to model data list
  final dataList = list.map((model) => jsonToModel(model) as T).toList();
  if (dataList.isEmpty) {
    MyLogger.error(
        msg: 'mapped model error!! data: $str\nmapped json: $list', tag: tag);
    throw MapJsonDataException();
  } else {
//      for (int index = 0; index < dataList.length; index++) {
//        print('mapped data $index: ${dataList[index]}');
//      }
    return dataList;
  }
}

T _jsonToData<T>(dynamic str,
    Function(Map<String, dynamic> jsonMap) jsonToModel, String tag) {
  var trimmed = JsonDecodeUtil.trimJson(str);

  MyLogger.debug(msg: 'start decoding data to $T...', tag: tag);
  Map<String, dynamic> map = jsonDecode(trimmed);
  // mapped decoded data to model data list
  try {
    return jsonToModel(map) as T;
  } catch (e) {
    MyLogger.error(
        msg: 'mapped model error!! data: $trimmed\nmapped json: $map',
        tag: tag);
    throw MapJsonDataException();
  }
}

/// This function should be used inside Repository class.
/// Wrapped remote data request in try-catch to generalize the data source action.
///
/// Takes in a data source's [future] method and wait for the data or throw failure if action has exception.
/// Catch [ServerException] if network request failed.
/// Catch [LocationException] if network request had been redirected to other .
/// Catch [MapJsonDataException] if json decode failed.
Future<Either<Failure, T>> handleResponse<T>(Future future) async {
  try {
    final data = await future;
    return Right(data);
  } on ServerException {
    return Left(ServerFailure());
  } on LocationException {
    return Left(NetworkFailure());
  } on MapJsonDataException {
    return Left(DataSourceFailure());
  } on Exception {
    return Left(InternalFailure());
  }
}
