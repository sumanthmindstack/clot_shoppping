// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_kyc_user_list_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetKycUserListParams _$GetKycUserListParamsFromJson(
        Map<String, dynamic> json) =>
    GetKycUserListParams(
      fields: json['fields'] as String,
      limit: (json['limit'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      join: json['join'] as String,
      searchData: json['s'] as String,
    );

Map<String, dynamic> _$GetKycUserListParamsToJson(
        GetKycUserListParams instance) =>
    <String, dynamic>{
      'fields': instance.fields,
      'limit': instance.limit,
      'page': instance.page,
      'join': instance.join,
      's': instance.searchData,
    };
