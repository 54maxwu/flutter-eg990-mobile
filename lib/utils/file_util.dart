import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<String> _createFileFromString(
    String base64EncodeStr, String fileName) async {
  final encodedStr = base64EncodeStr;
  Uint8List bytes = base64.decode(encodedStr);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File("$dir/$fileName");
  await file.writeAsBytes(bytes);
  return file.path;
}
