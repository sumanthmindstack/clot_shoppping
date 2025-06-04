import 'package:json_annotation/json_annotation.dart';

part 'get_lumpsum_data_params.g.dart';

@JsonSerializable()
class GetLumpsumDataParams {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'limit')
  final int limit;
  @JsonKey(name: 'type')
  final String type;

  GetLumpsumDataParams({
    required this.userId,
    required this.page,
    required this.limit,
    required this.type,
  });

  factory GetLumpsumDataParams.fromJson(Map<String, dynamic> json) =>
      _$GetLumpsumDataParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetLumpsumDataParamsToJson(this);
}
