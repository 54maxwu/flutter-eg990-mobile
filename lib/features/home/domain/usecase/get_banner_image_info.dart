import 'package:dartz/dartz.dart';
import 'package:flutter_ty_mobile/core/data/cached_image_file.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/features/home/domain/entity/banner_entity.dart';
import 'package:flutter_ty_mobile/features/home/domain/usecase/usecase_export.dart';

class GetHomeBannerImage implements UseCase<List<dynamic>, DataParams> {
  final tag = 'GetHomeBannerImage';

  GetHomeBannerImage();

  @override
  Future<Either<Failure, List<dynamic>>> call(DataParams params) async {
    MyLogger.print(msg: 'called banner image usecase...', tag: tag);
    var data = params.props.first;
    if (!(data is List) || (data as List).isEmpty) {
      MyLogger.warn(msg: 'banner state data: $data', tag: tag);
      return Left(DataTypeFailure());
    } else {
      try {
        final list = data as List<BannerEntity>;
        final prefixUrl = Global.TEST_BASE_URL;
        List<dynamic> images = new List();
        // check each banner for cached image file
        await Future.forEach(list, (banner) async {
          final url = (banner as BannerEntity).picMobile;
          await checkCachedImage('$prefixUrl$url')
              .then((item) => images.add(item));
        });
        print('banner bloc images: $images');
        return Right(images);
      } on Exception catch (e) {
        MyLogger.error(msg: 'banner image exception', tag: tag, error: e);
        return Left(CheckCachedFileFailure());
      }
    }
  }
}
