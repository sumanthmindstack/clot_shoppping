// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bank_mandates_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBankMandatesParams _$GetBankMandatesParamsFromJson(
        Map<String, dynamic> json) =>
    GetBankMandatesParams(
      page: (json['page'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$GetBankMandatesParamsToJson(
        GetBankMandatesParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'user_id': instance.userId,
      'limit': instance.limit,
    };
