import 'package:json_annotation/json_annotation.dart';

part 'generate_otp_params.g.dart';

@JsonSerializable()
class GenerateOtpParams {
  @JsonKey(name: 'mobile')
  final String mobileNumber;

  GenerateOtpParams({
    required this.mobileNumber,
  });

  factory GenerateOtpParams.fromJson(Map<String, dynamic> json) =>
      _$GenerateOtpParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateOtpParamsToJson(this);
}
