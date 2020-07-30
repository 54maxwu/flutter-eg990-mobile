import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/res.dart';

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
  int memberPoints;
  int rowItemCount;
  Widget pointWidget;

  double productImageSize;

  @override
  void initState() {
    rowItemCount = (Global.device.widthScale > 1.5)
        ? (2 * Global.device.widthScale).floor()
        : 2;
    double gridItemWidth =
        (Global.device.width - 8 * (rowItemCount + 1) - 24) / rowItemCount;
    productImageSize = gridItemWidth - 32;
    print('product image size: $productImageSize');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= PointStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.STORE)).message,
        ),
      );
    }

    products ??= _store.products;
    if (products == null || products.isEmpty) return SizedBox.shrink();

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                localeStr.storeTextTitlePoint,
                style: TextStyle(color: Themes.defaultHintColor),
              ),
              StreamBuilder<num>(
                stream: _store.pointStream,
                initialData: _store.memberPoints,
                builder: (_, snapshot) {
                  print('store point stream: ${snapshot?.data}');
                  if (snapshot == null || snapshot.data == null)
                    return SizedBox.shrink();
                  if (memberPoints != snapshot.data || pointWidget == null) {
                    memberPoints = snapshot.data;
                    pointWidget = Padding(
                      padding: const EdgeInsets.only(left: 3.0, top: 2.0),
                      child: Text(
                        '$memberPoints',
                        style:
                            TextStyle(color: Themes.hintHighlightOrangeStrong),
                      ),
                    );
                  }
                  return pointWidget;
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowItemCount,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.63,
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
                  color: Themes.iconColorGrey,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints.tight(
                            Size(productImageSize, productImageSize)),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(4.0),
                              child: networkImageBuilder(
                                'images/mall_product/${product.pic}.jpg',
                                fit: BoxFit.fill,
                                roundCorner: true,
                                roundParam: 12.0,
                              ),
                            ),
                            if (product.isNewProduct)
                              Image.asset(
                                Res.storeProductNewIcon,
                                alignment: Alignment.topLeft,
                                fit: BoxFit.none,
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(product.productName),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          localeStr.storeTextItemHint,
                          style: TextStyle(
                            color: Themes.defaultHintColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          localeStr.storeTextItemPoint(product.point),
                          style: TextStyle(
                            color: Themes.hintHighlightOrangeStrong,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                                    memberPoints: memberPoints,
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
