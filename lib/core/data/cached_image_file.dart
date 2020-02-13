import 'package:extended_image/extended_image.dart';

/// Check if image [url] has cached file.
/// If url image has been cached, return image's [File] else return url.
Future<dynamic> checkCachedImage(String url) async {
//    print('checking cached image: $url');
  return await getCachedImageFile(url).then((file) async {
    if (file == null) return url;
    return await file.exists().then((exist) {
      if (exist)
        return file;
      else
        return url;
    });
  });
}
