import 'package:json_annotation/json_annotation.dart';

part 'get_user_goals_details_params.g.dart';

@JsonSerializable()
class GetUserGoalsDetailsParams {
  @JsonKey(name: 'user_id')
  final int userId;

  GetUserGoalsDetailsParams({
    required this.userId,
  });

  factory GetUserGoalsDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$GetUserGoalsDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserGoalsDetailsParamsToJson(this);
}
