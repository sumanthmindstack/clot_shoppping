// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_summary_data_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountSummaryDataParams _$AccountSummaryDataParamsFromJson(
        Map<String, dynamic> json) =>
    AccountSummaryDataParams(
      page: (json['page'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$AccountSummaryDataParamsToJson(
        AccountSummaryDataParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'user_id': instance.userId,
      'limit': instance.limit,
    };
