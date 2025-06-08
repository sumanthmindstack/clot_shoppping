import 'package:json_annotation/json_annotation.dart';

part 'post_bank_mandates_params.g.dart';

@JsonSerializable()
class PostBankMandatesParams {
  @JsonKey(name: 'bank_id')
  final int bankId;

  @JsonKey(name: 'mandate_limit')
  final int mandateLimit;

  @JsonKey(name: 'mandate_type')
  final String mandateType;

  PostBankMandatesParams({
    required this.bankId,
    required this.mandateLimit,
    required this.mandateType,
  });

  factory PostBankMandatesParams.fromJson(Map<String, dynamic> json) =>
      _$PostBankMandatesParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PostBankMandatesParamsToJson(this);
}
