// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_bank_mandates_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostBankMandatesParams _$PostBankMandatesParamsFromJson(
        Map<String, dynamic> json) =>
    PostBankMandatesParams(
      bankId: (json['bank_id'] as num).toInt(),
      mandateLimit: (json['mandate_limit'] as num).toInt(),
      mandateType: json['mandate_type'] as String,
    );

Map<String, dynamic> _$PostBankMandatesParamsToJson(
        PostBankMandatesParams instance) =>
    <String, dynamic>{
      'bank_id': instance.bankId,
      'mandate_limit': instance.mandateLimit,
      'mandate_type': instance.mandateType,
    };
