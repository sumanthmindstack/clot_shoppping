// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpParams _$VerifyOtpParamsFromJson(Map<String, dynamic> json) =>
    VerifyOtpParams(
      mobileNumber: json['mobile'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$VerifyOtpParamsToJson(VerifyOtpParams instance) =>
    <String, dynamic>{
      'mobile': instance.mobileNumber,
      'otp': instance.otp,
    };
