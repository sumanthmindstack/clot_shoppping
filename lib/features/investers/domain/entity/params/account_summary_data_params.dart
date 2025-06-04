import 'package:json_annotation/json_annotation.dart';

part 'account_summary_data_params.g.dart';

@JsonSerializable()
class AccountSummaryDataParams {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'limit')
  final int limit;

  AccountSummaryDataParams({
    required this.page,
    required this.userId,
    required this.limit,
  });

  factory AccountSummaryDataParams.fromJson(Map<String, dynamic> json) =>
      _$AccountSummaryDataParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AccountSummaryDataParamsToJson(this);
}
