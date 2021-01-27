import 'package:flutter_test/flutter_test.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() {
  final String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJqd3QiLCJhdWQiOjEyLCJhdWRsZXZlbCI6Mywic3ViIjoiNWY3YTkzNTIyN2NiZiIsImlhdCI6MTYwMTg2ODYyNiwiZXhwIjoxNjAyNDczNDI2fQ.zdLDWzispW1x63e8YrEHK5RYJGR6kEwlfjiiJpcMvDQ, __cfduid: d26cc5cb72dd30bfa15d1accd91ac64601601868451';

  test('test token decode', () {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print('decoded token:\n$decodedToken');
  });
}
