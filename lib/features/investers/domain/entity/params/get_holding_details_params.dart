import 'package:json_annotation/json_annotation.dart';

part 'get_holding_details_params.g.dart';

@JsonSerializable()
class GetHoldingDetailsParams {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'limit')
  final int limit;

  GetHoldingDetailsParams({
    required this.page,
    required this.userId,
    required this.limit,
  });

  factory GetHoldingDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$GetHoldingDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetHoldingDetailsParamsToJson(this);
}
