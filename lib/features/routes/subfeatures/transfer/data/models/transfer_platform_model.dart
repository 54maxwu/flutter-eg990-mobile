import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_platform_model.freezed.dart';

@freezed
abstract class TransferPlatformModel with _$TransferPlatformModel {
  const factory TransferPlatformModel({
    String site,
    @JsonKey(name: 'site_name') String name,
  }) = _TransferPlatformModel;

  static TransferPlatformModel jsonToTransferPlatformModel(
          Map<String, dynamic> jsonMap) =>
      _$_TransferPlatformModel(
        site: jsonMap['site'] as String,
        name: jsonMap['site_name'] as String,
      );
}

@freezed
abstract class TransferPlatformList with _$TransferPlatformList {
  const factory TransferPlatformList({
    List<TransferPlatformModel> list,
  }) = _TransferPlatformList;
}
