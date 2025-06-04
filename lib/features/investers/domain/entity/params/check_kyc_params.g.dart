// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_kyc_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckKycParams _$CheckKycParamsFromJson(Map<String, dynamic> json) =>
    CheckKycParams(
      pan: json['pan'] as String,
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$CheckKycParamsToJson(CheckKycParams instance) =>
    <String, dynamic>{
      'pan': instance.pan,
      'user_id': instance.userId,
    };
