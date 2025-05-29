import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_params.g.dart';

@JsonSerializable()
class VerifyOtpParams {
  @JsonKey(name: 'mobile')
  final String mobileNumber;
  @JsonKey(name: 'otp')
  final String otp;

  VerifyOtpParams({
    required this.mobileNumber,
    required this.otp,
  });

  factory VerifyOtpParams.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpParamsFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpParamsToJson(this);
}
