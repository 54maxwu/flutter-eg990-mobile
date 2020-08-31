import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_product_model.freezed.dart';

@freezed
abstract class StoreProductModel with _$StoreProductModel {
  const factory StoreProductModel({
    @JsonKey(name: 'productid', defaultValue: -1) int productId,
    @JsonKey(name: 'productname', defaultValue: '?') String productName,
    num point,
    @JsonKey(name: 'sequence') int remain,
    int pic,
    @JsonKey(name: 'new') String isNew,
  }) = _StoreProductModel;

  static StoreProductModel jsonToStoreProductModel(
          Map<String, dynamic> jsonMap) =>
      _$_StoreProductModel(
        productId: jsonMap['productid'] as int ?? -1,
        productName: jsonMap['productname'] as String ?? '?',
        point: jsonMap['point'] as num,
        remain: jsonMap['sequence'] as int,
        pic: jsonMap['pic'] as int,
        isNew: jsonMap['new'] as String,
      );
}

extension StoreProductModelExtension on StoreProductModel {
  bool get isNewProduct => isNew == '1';
}
