import '../../domain/entities/ria_bank_entity.dart';

class RiaBankResponseModel extends RiaBankEntity {
  const RiaBankResponseModel({
    required super.id,
    required super.userId,
    required super.riaId,
    required super.accountNumber,
    required super.accountType,
    required super.micrCode,
    required super.ifscCode,
    required super.bankName,
    required super.branchName,
    required super.bankProof,
    required super.fundTransferNotificationEmail,
    required super.benificiaryName,
    required super.createdAt,
    required super.updatedAt,
  });

  factory RiaBankResponseModel.fromJson(Map<String, dynamic> json) {
    return RiaBankResponseModel(
      id: json['id'],
      userId: json['user_id'],
      riaId: json['ria_id'],
      accountNumber: json['account_number'],
      accountType: json['account_type'],
      micrCode: json['micr_code'],
      ifscCode: json['ifsc_code'],
      bankName: json['bank_name'],
      branchName: json['branch_name'],
      bankProof: json['bank_proof'],
      fundTransferNotificationEmail: json['fund_transfer_notification_email'],
      benificiaryName: json['benificiary_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'ria_id': riaId,
      'account_number': accountNumber,
      'account_type': accountType,
      'micr_code': micrCode,
      'ifsc_code': ifscCode,
      'bank_name': bankName,
      'branch_name': branchName,
      'bank_proof': bankProof,
      'fund_transfer_notification_email': fundTransferNotificationEmail,
      'benificiary_name': benificiaryName,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
