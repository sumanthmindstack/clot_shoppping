import 'package:json_annotation/json_annotation.dart';

part 'add_new_bank_params.g.dart';

@JsonSerializable()
class AddNewBankParams {
  @JsonKey(name: 'account_holder_name')
  final String accountHolderName;

  @JsonKey(name: 'account_number')
  final String accountNumber;

  @JsonKey(name: 'bank_name')
  final String bankName;

  @JsonKey(name: 'ifsc_code')
  final String ifscCode;

  @JsonKey(name: 'user_id')
  final int userId;

  AddNewBankParams({
    required this.accountHolderName,
    required this.accountNumber,
    required this.bankName,
    required this.ifscCode,
    required this.userId,
  });

  factory AddNewBankParams.fromJson(Map<String, dynamic> json) =>
      _$AddNewBankParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddNewBankParamsToJson(this);
}
