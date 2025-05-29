import 'package:json_annotation/json_annotation.dart';

part 'ria_bank_params.g.dart';

@JsonSerializable()
class RiaBankParams {
  @JsonKey(name: 'ria_id')
  final int riaId;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'bank_details')
  final List<BankDetail> bankDetails;

  const RiaBankParams({
    required this.riaId,
    required this.userId,
    required this.bankDetails,
  });

  factory RiaBankParams.fromJson(Map<String, dynamic> json) =>
      _$RiaBankParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RiaBankParamsToJson(this);
}

@JsonSerializable()
class BankDetail {
  @JsonKey(name: 'account_number')
  final String accountNumber;

  @JsonKey(name: 'account_type')
  final String accountType;

  @JsonKey(name: 'bank_name')
  final String bankName;

  @JsonKey(name: 'bank_proof')
  final String bankProof;

  @JsonKey(name: 'benificiary_name')
  final String benificiaryName;

  @JsonKey(name: 'branch_name')
  final String branchName;

  @JsonKey(name: 'fund_transfer_notification_email')
  final String fundTransferNotificationEmail;

  @JsonKey(name: 'ifsc_code')
  final String ifscCode;

  @JsonKey(name: 'micr_code')
  final String micrCode;

  const BankDetail({
    required this.accountNumber,
    required this.accountType,
    required this.bankName,
    required this.bankProof,
    required this.benificiaryName,
    required this.branchName,
    required this.fundTransferNotificationEmail,
    required this.ifscCode,
    required this.micrCode,
  });

  factory BankDetail.fromJson(Map<String, dynamic> json) =>
      _$BankDetailFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailToJson(this);
}
