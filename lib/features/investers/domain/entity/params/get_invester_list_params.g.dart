// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_invester_list_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInvesterListParams _$GetInvesterListParamsFromJson(
        Map<String, dynamic> json) =>
    GetInvesterListParams(
      searchData: json['query'] as String,
      limit: (json['limit'] as num).toInt(),
      page: (json['page'] as num).toInt(),
    );

Map<String, dynamic> _$GetInvesterListParamsToJson(
        GetInvesterListParams instance) =>
    <String, dynamic>{
      'query': instance.searchData,
      'limit': instance.limit,
      'page': instance.page,
    };
