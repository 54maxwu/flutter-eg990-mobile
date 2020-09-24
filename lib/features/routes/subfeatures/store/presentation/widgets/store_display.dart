import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';

import '../state/point_store.dart';
import 'store_display_banner.dart';
import 'store_display_tabs.dart';

class StoreDisplay extends StatefulWidget {
  final PointStore store;

  StoreDisplay(this.store);

  @override
  _StoreDisplayState createState() => _StoreDisplayState();
}

class _StoreDisplayState extends State<StoreDisplay> {
  double availableHeight;
  double imageHeight;
  double contentHeight;

  @override
  void initState() {
    double imageContainerScale = 1920 / Global.device.width;
    // origin pic size is w1920*h530
    imageHeight = 530 / imageContainerScale;
    print('store banner height: $imageHeight');

    availableHeight = Global.device.featureContentHeight - 4.0;
    contentHeight = availableHeight - imageHeight;
    print('store content height: $contentHeight');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: Global.device.width,
            maxWidth: Global.device.width,
            minHeight: imageHeight,
            maxHeight: imageHeight,
          ),
          child: StoreDisplayBanner(images: widget.store.banners),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: Global.device.width,
            maxWidth: Global.device.width,
            minHeight: contentHeight,
            maxHeight: contentHeight,
          ),
          child: StoreDisplayTabs(
            store: widget.store,
            parentHeight: contentHeight,
          ),
        ),
      ],
    );
  }
}
