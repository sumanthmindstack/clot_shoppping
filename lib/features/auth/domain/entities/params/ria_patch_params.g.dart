// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ria_patch_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiaPatchParams _$RiaPatchParamsFromJson(Map<String, dynamic> json) =>
    RiaPatchParams(
      id: json['id'] as String,
      equityName: json['equity_name'] as String,
      equityShortCode: json['equity_short_code'] as String,
      pan: json['pan'] as String,
      riaCode: json['ria_code'] as String,
      sipDemat: json['sip_demat'] as bool,
      tanCode: json['tan_code'] as String,
      website: json['website'] as String,
    );

Map<String, dynamic> _$RiaPatchParamsToJson(RiaPatchParams instance) =>
    <String, dynamic>{
      'id': instance.id,
      'equity_name': instance.equityName,
      'equity_short_code': instance.equityShortCode,
      'pan': instance.pan,
      'ria_code': instance.riaCode,
      'sip_demat': instance.sipDemat,
      'tan_code': instance.tanCode,
      'website': instance.website,
    };
