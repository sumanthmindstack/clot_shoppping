// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mfd_patch_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MfdPatchParams _$MfdPatchParamsFromJson(Map<String, dynamic> json) =>
    MfdPatchParams(
      id: json['id'] as String,
      arnCode: json['arn_code'] as String,
      arnStartDate: json['arn_start_date'] as String,
      arnEndDate: json['arn_end_date'] as String,
      equityName: json['equity_name'] as String,
      pan: json['pan'] as String,
      sipDemat: json['sip_demat'] as bool,
      tanCode: json['tan_code'] as String,
      website: json['website'] as String,
    );

Map<String, dynamic> _$MfdPatchParamsToJson(MfdPatchParams instance) =>
    <String, dynamic>{
      'id': instance.id,
      'arn_code': instance.arnCode,
      'arn_start_date': instance.arnStartDate,
      'arn_end_date': instance.arnEndDate,
      'equity_name': instance.equityName,
      'pan': instance.pan,
      'sip_demat': instance.sipDemat,
      'tan_code': instance.tanCode,
      'website': instance.website,
    };
