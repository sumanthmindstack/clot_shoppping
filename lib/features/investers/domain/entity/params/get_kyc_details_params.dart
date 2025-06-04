import 'package:json_annotation/json_annotation.dart';

part 'get_kyc_details_params.g.dart';

@JsonSerializable()
class GetKycDetailsParams {
  @JsonKey(name: 'user_id')
  final int userId;

  GetKycDetailsParams({
    required this.userId,
  });

  factory GetKycDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$GetKycDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetKycDetailsParamsToJson(this);
}
