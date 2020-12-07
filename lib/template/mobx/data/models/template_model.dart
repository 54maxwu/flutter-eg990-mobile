import 'package:meta/meta.dart' show immutable;

@immutable
class TemplateModel {
  final String vip1;
  final String vip2;
  final String vip3;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const TemplateModel({
    this.vip1 = '',
    this.vip2 = '',
    this.vip3 = '',
  });

  TemplateModel copyWith({
    String vip1,
    String vip2,
    String vip3,
  }) {
    if ((vip1 == null || identical(vip1, this.vip1)) &&
        (vip2 == null || identical(vip2, this.vip2)) &&
        (vip3 == null || identical(vip3, this.vip3))) {
      return this;
    }

    return new TemplateModel(
      vip1: vip1 ?? this.vip1,
      vip2: vip2 ?? this.vip2,
      vip3: vip3 ?? this.vip3,
    );
  }

  @override
  String toString() {
    return 'TemplateModel{vip1: $vip1, vip2: $vip2, vip3: $vip3}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemplateModel &&
          runtimeType == other.runtimeType &&
          vip1 == other.vip1 &&
          vip2 == other.vip2 &&
          vip3 == other.vip3);

  @override
  int get hashCode => vip1.hashCode ^ vip2.hashCode ^ vip3.hashCode;

  factory TemplateModel.fromMap(Map<String, dynamic> map) {
    return new TemplateModel(
      vip1: map['vip1'] as String,
      vip2: map['vip2'] as String,
      vip3: map['vip3'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'vip1': this.vip1,
      'vip2': this.vip2,
      'vip3': this.vip3,
    } as Map<String, dynamic>;
  }

//</editor-fold>

  static TemplateModel parseJson(Map<String, dynamic> jsonMap) =>
      TemplateModel.fromMap(jsonMap);
}
