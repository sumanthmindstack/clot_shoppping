import 'package:json_annotation/json_annotation.dart';

part 'mfd_params.g.dart';

@JsonSerializable()
class MfdParams {
  @JsonKey(name: 'user_id')
  final String userId;

  MfdParams({
    required this.userId,
  });

  factory MfdParams.fromJson(Map<String, dynamic> json) =>
      _$MfdParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MfdParamsToJson(this);
}
