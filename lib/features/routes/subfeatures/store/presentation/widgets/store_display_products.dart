import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/res.dart';

import '../../data/models/store_product_model.dart';
import '../state/point_store.dart';
import 'point_store_inherit_widget.dart';
import 'store_product_dialog.dart';

class StoreDisplayProducts extends StatefulWidget {
  @override
  _StoreDisplayProductsState createState() => _StoreDisplayProductsState();
}

class _StoreDisplayProductsState extends State<StoreDisplayProducts> {
  PointStore _store;
  List<StoreProductModel> products;
  int rowItemCount;
  Widget _pointWidget;

  final double expectItemHeight = 284;
  double _gridRatio;
  double _productImageSize;

  @override
  void initState() {
    rowItemCount = (Global.device.widthScale > 1.5)
        ? (2 * Global.device.widthScale).floor()
        : 2;
    double itemWidth =
        (Global.device.width - 8 * (rowItemCount + 1) - 24) / rowItemCount;
    _gridRatio = itemWidth / expectItemHeight;
    debugPrint('grid item width: $itemWidth, gridRatio: $_gridRatio');
    _productImageSize = itemWidth - 12;
    debugPrint('product image size: $_productImageSize');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= PointStoreInheritedWidget.of(context).store;
    _pointWidget ??= PointStoreInheritedWidget.of(context).pointWidget;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
        ),
      );
    }

    products ??= _store.products;
    if (products == null || products.isEmpty) return SizedBox.shrink();

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: _pointWidget,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowItemCount,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: _gridRatio,
            ),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (_, index) {
              StoreProductModel product = products[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(12.0)),
                  color: themeColor.storeProductBgColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints.tight(
                            Size(_productImageSize, _productImageSize)),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin:
                                  const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0),
                              child: networkImageBuilder(
                                  'images/mall_product/${product.pic}.jpg',
                                  fit: BoxFit.fill,
                                  roundCorner: true,
                                  roundParam: 12.0),
                            ),
                            // if (product.isNewProduct)
                            //   Image.asset(
                            //     Res.storeProductNewIcon,
                            //     alignment: Alignment.topLeft,
                            //     fit: BoxFit.none,
                            //   ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(product.productName,
                            textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          localeStr.storeTextItemHint,
                          style: TextStyle(
                              color: themeColor.defaultHintColor,
                              fontSize: FontSize.SMALLER.value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          localeStr.storeTextItemPoint(
                              '${formatAsCreditNum(product.point)} '),
                          style: TextStyle(
                              color: themeColor.storeHighlightTextColor,
                              fontSize: FontSize.SUBTITLE.value,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                visualDensity: VisualDensity.compact,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(36.0),
                                ),
                                onPressed: () => showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) => new StoreProductDialog(
                                    store: _store,
                                    product: product,
                                    memberPoints: _store.memberPoints,
                                  ),
                                ),
                                child: Text(localeStr.storeTextItemButton),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
