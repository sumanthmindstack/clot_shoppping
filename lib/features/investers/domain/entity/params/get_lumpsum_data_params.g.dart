// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_lumpsum_data_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLumpsumDataParams _$GetLumpsumDataParamsFromJson(
        Map<String, dynamic> json) =>
    GetLumpsumDataParams(
      userId: (json['user_id'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$GetLumpsumDataParamsToJson(
        GetLumpsumDataParams instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'page': instance.page,
      'limit': instance.limit,
      'type': instance.type,
    };
