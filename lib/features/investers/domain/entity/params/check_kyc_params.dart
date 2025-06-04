import 'package:json_annotation/json_annotation.dart';

part 'check_kyc_params.g.dart';

@JsonSerializable()
class CheckKycParams {
  @JsonKey(name: 'pan')
  final String pan;

  @JsonKey(name: 'user_id')
  final int userId;

  CheckKycParams({
    required this.pan,
    required this.userId,
  });

  factory CheckKycParams.fromJson(Map<String, dynamic> json) =>
      _$CheckKycParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CheckKycParamsToJson(this);
}
