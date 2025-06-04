import 'package:json_annotation/json_annotation.dart';

part 'change_primary_bank_params.g.dart';

@JsonSerializable()
class ChangePrimaryBankParams {
  @JsonKey(name: 'bank_id')
  final int bankId;

  @JsonKey(name: 'user_id')
  final int userId;

  ChangePrimaryBankParams({
    required this.bankId,
    required this.userId,
  });

  factory ChangePrimaryBankParams.fromJson(Map<String, dynamic> json) =>
      _$ChangePrimaryBankParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePrimaryBankParamsToJson(this);
}
