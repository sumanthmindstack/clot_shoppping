import 'package:json_annotation/json_annotation.dart';

part 'edit_invester_details_params.g.dart';

@JsonSerializable()
class EditInvesterDetailsParams {
  @JsonKey(name: 'user_id')
  final int userId;

  EditInvesterDetailsParams({
    required this.userId,
  });

  factory EditInvesterDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$EditInvesterDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$EditInvesterDetailsParamsToJson(this);
}
