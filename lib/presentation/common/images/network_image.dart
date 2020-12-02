import 'dart:io' show File;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_interface.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

class NetworkImageBuilder extends StatefulWidget {
  final String url;
  final BoxFit fit;
  final double scale;
  final Color color;
  final bool roundCorner;
  final double roundParam;
  final bool addLoadingIcon;

  NetworkImageBuilder(
    this.url, {
    this.fit = BoxFit.contain,
    this.scale = 1.0,
    this.color,
    this.roundCorner = false,
    this.roundParam = 6.0,
    this.addLoadingIcon = false,
  });

  @override
  _NetworkImageBuilderState createState() => _NetworkImageBuilderState();
}

class _NetworkImageBuilderState extends State<NetworkImageBuilder> {
  Future<Widget> _imageFuture;

  @override
  void didChangeDependencies() {
    _imageFuture = null;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _imageFuture ??= networkImageWidget(
      widget.url,
      fit: widget.fit,
      scale: widget.scale,
      color: widget.color,
      addLoadingIcon: widget.addLoadingIcon,
    );
    return FutureBuilder(
      future: _imageFuture,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return (widget.roundCorner)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(widget.roundParam),
                  child: snapshot.data,
                )
              : snapshot.data;
        } else if (snapshot.hasError) {
          MyLogger.warn(
              msg: 'network image builder error: ${snapshot.error}',
              error: snapshot.error);
          return Icon(Icons.broken_image, color: themeColor.iconSubColor1);
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

/// Check if image [url] has cached file.
/// If url image has been cached, return image's [File] else return url.
Future<dynamic> checkCachedImage(String url) async {
//    debugPrint('checking cached image: $url');
  return await getCachedImageFile(url).then((file) async {
    if (file == null) return url;
    return await file.exists().then((exist) => (exist) ? file : url);
  });
}

Future<Widget> networkImageWidget(
  String url, {
  BoxFit fit = BoxFit.contain,
  double scale = 1.0,
  Color color,
  bool addLoadingIcon = true,
}) async {
  String imageUrl = (url.isUrl)
      ? url
      : '${Global.CURRENT_BASE}$url'.replaceAll('//images/', '/images/');
  final image = await Future.value(checkCachedImage(imageUrl)).then((item) {
//    debugPrint('image: $imageUrl, item: ${item.runtimeType}');
    if (item is File) {
//      debugPrint('file state: ${item.statSync()}, length: ${item.lengthSync()}');
      return Image.file(item, fit: fit, scale: scale, color: color);
    } else {
      try {
        return ExtendedImage.network(
          imageUrl,
          fit: fit,
          scale: scale,
          color: color,
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return (addLoadingIcon) ? Image.asset(Res.refresh_2) : null;
              case LoadState.completed:
                return state.completedWidget;
              case LoadState.failed:
                MyLogger.warn(msg: 'load image failed: $imageUrl');
                Future.microtask(() => clearDiskCachedImage(imageUrl));
                return Icon(
                  Icons.broken_image,
                  color: themeColor.iconSubColor1,
                );
              default:
                return null;
            }
          },
        );
      } catch (e) {
        MyLogger.warn(msg: 'load image error: $imageUrl');
        debugPrint(e);
      }
    }
  });
  return image;
}
