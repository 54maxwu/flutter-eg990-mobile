import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_eg990_mobile/domain/core/exceptions.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

class JsonUtil {
  static const String debugTag = 'JsonDecodeUtil';

  static String getRawJson(dynamic jsonStr) =>
      (jsonStr != null) ? '$jsonStr' : '';

  /// trim json [str] to prevent data error while decoding
  static String trimJson(dynamic str) {
    final trimRegex = RegExp(r"\s+\b|\b\s|\n|\r\n|\r|\s|\t");
    final trimRegexSimple = RegExp('r"\n|\r\n|\r|\t"');
    final tagRegex = RegExp('>\\s*<');
    String jsonStr = """$str""";
    bool hasHtmlTag = jsonStr.contains(tagRegex);
    String strBody = (hasHtmlTag)
        ? jsonStr.replaceAll(trimRegexSimple, "").replaceAll('> <', "><")
        : jsonStr.replaceAll(trimRegex, "");
//    debugPrint("trimmed: $strBody");
    if (strBody.isHtmlFormat) throw LocationException();
    return strBody;
  }

  static List encodeToJsonArray(List<dynamic> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(jsonEncode(item))).toList();
    return jsonList;
  }

  ///
  /// Decode json into data [T]
  ///
  /// [str] = json string
  /// [parseJson] = function that transforms the mapped json to model
  /// [tag] = logger tag
  ///
  static T decodeToModel<T>(
    dynamic str,
    Function(Map<String, dynamic> jsonMap) parseJson, {
    bool trim = false,
    Map<String, dynamic> defaultData,
    String tag = debugTag,
  }) {
    // debugPrint('start decoding ${str.runtimeType} to model $T...');
    // transfer decoded data to model data
    Map<String, dynamic> map;
    try {
      if (str is Map) {
        map = str;
      } else if (str is String) {
        var trimmed = (trim) ? trimJson(str) : str;
        map = jsonDecode(trimmed);
      } else if (str is List && str.isEmpty) {
        MyLogger.warn(msg: 'model data is empty!!', tag: tag);
        map = defaultData ?? {};
      } else {
        if (defaultData != null) throw UnexpectedTypeException(str);
        map = defaultData;
      }
      return parseJson(map) as T;
    } catch (e, s) {
      MyLogger.error(
          msg: 'mapped model error!! $e\ndata: $str\nmapped json: $map',
          stackTrace: s,
          tag: tag);
      throw JsonDecodeException(str);
    }
  }

  /// Decode json array [str] into [dynamic] List
  static List decodeArray(
    dynamic str, {
    bool returnNullOnError = false,
    bool trim = false,
    String tag = debugTag,
  }) {
    if (str is List) return str;
    if (str is Map) throw UnexpectedTypeException(str);

    final trimmed = (trim) ? trimJson(str) : str;
    if (trimmed.isEmpty) return [];

    try {
      List decoded = jsonDecode(trimmed);
//      debugPrint("decoded type: ${decoded.runtimeType} Json: $decoded");
      if (decoded.isEmpty && trimmed.isNotEmpty) {
        MyLogger.warn(msg: 'decoded data list is empty!!', tag: tag);
      }
      return decoded;
    } catch (e, s) {
      debugPrint('exception: $e');
      if (returnNullOnError) {
        MyLogger.error(msg: 'decode json array error!!', tag: tag);
        return null;
      } else {
        MyLogger.error(
            msg: 'decode json array error!!', stackTrace: s, tag: tag);
        throw JsonDecodeException('decodeArray: $str');
      }
    }
  }

  ///
  /// Decode json array into list of [T]
  ///
  /// [data] = json data, can be a decoded list or json string
  /// [parseJson] = function that transforms the mapped json to model
  /// [tag] = logger tag
  ///
  static List<T> decodeArrayToModel<T>(
    dynamic data,
    Function(Map<String, dynamic> jsonMap) parseJson, {
    bool trim = false,
    String tag = debugTag,
  }) {
    // debugPrint('start decoding array data to $T...');
    // debugPrint('data type: ${data.runtimeType}, data is List: ${data is List}');
    List<dynamic> list;
    if (data is List) {
      list = data;
    } else if (data is String) {
      list = decodeArray(data, trim: trim, tag: tag);
    } else {
      throw UnexpectedTypeException(data);
    }

    // mapped decoded data to model data list
    final dataList = (list.isEmpty)
        ? new List<T>()
        : list.map((model) => parseJson(model) as T).toList();

    if (dataList.isEmpty && list.isNotEmpty) {
      MyLogger.error(
          msg: 'mapped model array error!!'
              '\ndata: $data\nmapped json: $list',
          tag: tag);
      throw JsonDecodeException(list);
    } else {
//      for (int index = 0; index < dataList.length; index++) {
//        debugPrint('mapped data $index: ${dataList[index]}');
//      }
      return dataList;
    }
  }

  ///
  /// Decode json array into list of [T]
  ///
  /// [data] = json data, can be a decoded list or json string
  /// [parseJson] = function that transforms the mapped json to model
  /// [tag] = logger tag
  ///
  static List<T> decodeMapToModelList<T>(
    dynamic map,
    Function(Map<String, dynamic> jsonMap) parseJson, {
    bool trim = false,
    bool addKey = true,
    String tag = debugTag,
  }) {
    // debugPrint('decodeMapToModelList: $map, type: ${map.runtimeType}');
    if (map == null || (map is List && map.isEmpty)) return [];
    if (map is Map == false) throw UnexpectedTypeException(map);

    // debugPrint('start decoding map to $T list...');
    List<T> dataList = new List();
    map.forEach((key, value) {
      dataList.add(
          (addKey) ? parseJson(value).copyWith(key: key) : parseJson(value));
    });

    if (dataList.isEmpty) {
      MyLogger.error(
          msg: 'mapped model list error!! \nmapped json: $map', tag: tag);
      throw JsonDecodeException(map);
    } else {
//      for (int index = 0; index < dataList.length; index++) {
//        debugPrint('mapped data $index: ${dataList[index]}');
//      }
      return dataList;
    }
  }
}
