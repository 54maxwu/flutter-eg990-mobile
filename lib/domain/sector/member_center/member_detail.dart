import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_detail.freezed.dart';

@freezed
abstract class MemberDetail with _$MemberDetail {
  const factory MemberDetail({
    String accountCode,
    int accountId,
    String birthDate,
    String phone,
    String gender,
    String email,
    String wechat,
    String zalo,
    String firstName,
    String autoTransfer,
  }) = _MemberDetail;
}

extension MemberDetailExtension on MemberDetail {
  bool get canBindCard => firstName.isEmpty;

  bool get canBindBirthDate => birthDate.isEmpty;

  bool get canVerifyPhone =>
      phone != null && phone.isNotEmpty && phone.contains('未');

  bool get canBindMail => email.isEmpty;

  bool get canBindWechat => wechat.isEmpty;

  bool get canBindZalo => zalo.isEmpty;

  List<String> get getInitInput =>
      [accountCode, firstName, birthDate, phone, email, wechat, zalo];
}
