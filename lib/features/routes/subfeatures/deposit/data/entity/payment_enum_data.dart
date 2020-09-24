import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_enum_data.freezed.dart';

enum TutorialItemType { Desc, Image, Button }

@freezed
abstract class PaymentTutorialItem with _$PaymentTutorialItem {
  const factory PaymentTutorialItem({
    @required int sortId,
    @required String value,
    String link,
    @required TutorialItemType type,
  }) = _PaymentTutorialItem;
}
