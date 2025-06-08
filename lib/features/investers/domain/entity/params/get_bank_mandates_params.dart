import 'package:json_annotation/json_annotation.dart';

part 'get_bank_mandates_params.g.dart';

@JsonSerializable()
class GetBankMandatesParams {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'limit')
  final int limit;

  GetBankMandatesParams({
    required this.page,
    required this.userId,
    required this.limit,
  });

  factory GetBankMandatesParams.fromJson(Map<String, dynamic> json) =>
      _$GetBankMandatesParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetBankMandatesParamsToJson(this);
}
