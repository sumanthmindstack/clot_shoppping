// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ria_bank_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiaBankParams _$RiaBankParamsFromJson(Map<String, dynamic> json) =>
    RiaBankParams(
      riaId: (json['ria_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      bankDetails: (json['bank_details'] as List<dynamic>)
          .map((e) => BankDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RiaBankParamsToJson(RiaBankParams instance) =>
    <String, dynamic>{
      'ria_id': instance.riaId,
      'user_id': instance.userId,
      'bank_details': instance.bankDetails,
    };

BankDetail _$BankDetailFromJson(Map<String, dynamic> json) => BankDetail(
      accountNumber: json['account_number'] as String,
      accountType: json['account_type'] as String,
      bankName: json['bank_name'] as String,
      bankProof: json['bank_proof'] as String,
      benificiaryName: json['benificiary_name'] as String,
      branchName: json['branch_name'] as String,
      fundTransferNotificationEmail:
          json['fund_transfer_notification_email'] as String,
      ifscCode: json['ifsc_code'] as String,
      micrCode: json['micr_code'] as String,
    );

Map<String, dynamic> _$BankDetailToJson(BankDetail instance) =>
    <String, dynamic>{
      'account_number': instance.accountNumber,
      'account_type': instance.accountType,
      'bank_name': instance.bankName,
      'bank_proof': instance.bankProof,
      'benificiary_name': instance.benificiaryName,
      'branch_name': instance.branchName,
      'fund_transfer_notification_email':
          instance.fundTransferNotificationEmail,
      'ifsc_code': instance.ifscCode,
      'micr_code': instance.micrCode,
    };
