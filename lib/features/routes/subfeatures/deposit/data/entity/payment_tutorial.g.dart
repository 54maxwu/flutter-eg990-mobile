// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_tutorial.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

abstract class _$PaymentTutorialData {
  const _$PaymentTutorialData();

  String get typeKey;
  String get key;
  String get tutorialButtonText;
  String get tutorialLinkDesc;
  List<PaymentTutorialItem> get tutorials;
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! PaymentTutorialData) return false;

    return true &&
        this.typeKey == other.typeKey &&
        this.key == other.key &&
        this.tutorialButtonText == other.tutorialButtonText &&
        this.tutorialLinkDesc == other.tutorialLinkDesc &&
        this.tutorials == other.tutorials;
  }

  int get hashCode {
    return mapPropsToHashCode(
        [typeKey, key, tutorialButtonText, tutorialLinkDesc, tutorials]);
  }

  String toString() {
    return 'PaymentTutorialData <\'typeKey\': ${this.typeKey},\'key\': ${this.key},\'tutorialButtonText\': ${this.tutorialButtonText},\'tutorialLinkDesc\': ${this.tutorialLinkDesc},\'tutorials\': ${this.tutorials},>';
  }

  PaymentTutorialData copyWith(
      {String typeKey,
      String key,
      String tutorialButtonText,
      String tutorialLinkDesc,
      List<PaymentTutorialItem> tutorials}) {
    return PaymentTutorialData(
      typeKey: typeKey ?? this.typeKey,
      key: key ?? this.key,
      tutorialButtonText: tutorialButtonText ?? this.tutorialButtonText,
      tutorialLinkDesc: tutorialLinkDesc ?? this.tutorialLinkDesc,
      tutorials: tutorials ?? this.tutorials,
    );
  }
}
