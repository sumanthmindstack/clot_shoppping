import 'package:json_annotation/json_annotation.dart';

part 'find_one_params.g.dart';

@JsonSerializable()
class FindOneParams {
  @JsonKey(name: 'id')
  final String id;

  FindOneParams({
    required this.id,
  });

  factory FindOneParams.fromJson(Map<String, dynamic> json) =>
      _$FindOneParamsFromJson(json);

  Map<String, dynamic> toJson() => _$FindOneParamsToJson(this);
}
