import 'package:flutter_eg990_mobile/infrastructure/repository_export.dart';

import 'notice_data.dart';
import 'notice_type.dart';

class NoticeApi {
  static const String POST_REMIND = "api/getRemind";
}

abstract class NoticeRepository {
  Future<Either<Failure, Map<String, List<NoticeData>>>> getRemind();
}

class NoticeRepositoryImpl implements NoticeRepository {
  final DioApiService dioApiService;
  final tag = 'NoticeRepository';

  NoticeRepositoryImpl({@required this.dioApiService});

  @override
  Future<Either<Failure, Map<String, List<NoticeData>>>> getRemind() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(NoticeApi.POST_REMIND),
      parseJson: RequestCodeModel.parseJson,
      tag: 'remote-NOTICE',
    );
//    debugPrint('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (response) {
        if (response.isSuccess) {
          if (response.data is Map) {
            Map raw = response.data;
            try {
              Map<String, List<NoticeData>> listMap = raw.map((key, value) {
                NoticeType type = NoticeType('$key');
                return MapEntry<String, List<NoticeData>>(
                  '$key',
                  noticeDataArrayToList(value, type.id)
                    ..sort((a, b) => a.sort.compareTo(b.sort)),
                );
              });
              return Right(listMap);
            } on Exception {
              return Right(Map());
            }
          }
          return Right(Map());
        } else {
          return Left(Failure.errorCode(response));
        }
      },
    );
  }
}
