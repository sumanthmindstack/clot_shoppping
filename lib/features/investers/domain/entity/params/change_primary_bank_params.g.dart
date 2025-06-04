// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_primary_bank_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePrimaryBankParams _$ChangePrimaryBankParamsFromJson(
        Map<String, dynamic> json) =>
    ChangePrimaryBankParams(
      bankId: (json['bank_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$ChangePrimaryBankParamsToJson(
        ChangePrimaryBankParams instance) =>
    <String, dynamic>{
      'bank_id': instance.bankId,
      'user_id': instance.userId,
    };
