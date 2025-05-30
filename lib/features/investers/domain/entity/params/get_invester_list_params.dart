import 'package:json_annotation/json_annotation.dart';

part 'get_invester_list_params.g.dart';

@JsonSerializable()
class GetInvesterListParams {
  @JsonKey(name: 'query')
  final String searchData;
  @JsonKey(name: 'limit')
  final int limit;

  @JsonKey(name: 'page')
  final int page;

  GetInvesterListParams({
    required this.searchData,
    required this.limit,
    required this.page,
  });

  factory GetInvesterListParams.fromJson(Map<String, dynamic> json) =>
      _$GetInvesterListParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetInvesterListParamsToJson(this);
}
