// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_holding_details_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHoldingDetailsParams _$GetHoldingDetailsParamsFromJson(
        Map<String, dynamic> json) =>
    GetHoldingDetailsParams(
      page: (json['page'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$GetHoldingDetailsParamsToJson(
        GetHoldingDetailsParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'user_id': instance.userId,
      'limit': instance.limit,
    };
