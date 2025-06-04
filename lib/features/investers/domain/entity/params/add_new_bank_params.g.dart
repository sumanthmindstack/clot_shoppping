// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_bank_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewBankParams _$AddNewBankParamsFromJson(Map<String, dynamic> json) =>
    AddNewBankParams(
      accountHolderName: json['account_holder_name'] as String,
      accountNumber: json['account_number'] as String,
      bankName: json['bank_name'] as String,
      ifscCode: json['ifsc_code'] as String,
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$AddNewBankParamsToJson(AddNewBankParams instance) =>
    <String, dynamic>{
      'account_holder_name': instance.accountHolderName,
      'account_number': instance.accountNumber,
      'bank_name': instance.bankName,
      'ifsc_code': instance.ifscCode,
      'user_id': instance.userId,
    };
