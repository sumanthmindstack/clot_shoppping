import '../../domain/entity/get_bank_mandates_entity.dart';

class GetBankMandatesResponseModel extends GetBankMandatesEntity {
  GetBankMandatesResponseModel({
    required super.data,
    required super.meta,
  });

  factory GetBankMandatesResponseModel.fromJson(Map<String, dynamic> json) {
    return GetBankMandatesResponseModel(
      data: (json['data'] as List)
          .map((e) => BankMandateModel.fromJson(e))
          .toList(),
      meta: MetaModel.fromJson(json['meta']),
    );
  }
}

class BankMandateModel extends BankMandateEntity {
  BankMandateModel({
    required super.id,
    required super.mandateType,
    required super.fpBankId,
    required super.bankId,
    required super.mandateLimit,
    required super.providerName,
    required super.validFrom,
    required super.mandateId,
    required super.tokenUrl,
    required super.paymentId,
    required super.status,
    required super.failureReason,
    required super.userId,
    required super.rejectedReason,
    required super.customerId,
    required super.rejectedAt,
    required super.receivedAt,
    required super.approvedAt,
    required super.submittedAt,
    required super.cancelledAt,
    required super.createdAt,
    required super.updatedAt,
    required super.userBankDetail,
    required super.logoUrl,
  });

  factory BankMandateModel.fromJson(Map<String, dynamic> json) {
    return BankMandateModel(
      id: json['id'],
      mandateType: json['mandate_type'],
      fpBankId: json['fp_bank_id'],
      bankId: json['bank_id'],
      mandateLimit: json['mandate_limit'],
      providerName: json['provider_name'],
      validFrom: json['valid_from'],
      mandateId: json['mandate_id'],
      tokenUrl: json['token_url'],
      paymentId: json['paymentId'],
      status: json['status'],
      failureReason: json['failureReason'],
      userId: json['user_id'],
      rejectedReason: json['rejected_reason'],
      customerId: json['customer_id'],
      rejectedAt: json['rejected_at'],
      receivedAt: json['received_at'],
      approvedAt: json['approved_at'],
      submittedAt: json['submitted_at'],
      cancelledAt: json['cancelled_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      userBankDetail: UserBankDetailModel.fromJson(json['user_bank_detail']),
      logoUrl: json['logo_url'],
    );
  }
}

class UserBankDetailModel extends UserBankDetailEntity {
  UserBankDetailModel({
    required super.id,
    required super.accountHolderName,
    required super.accountNumber,
    required super.ifscCode,
    required super.proof,
    required super.bankName,
    required super.isPennyDropSuccess,
    required super.isPennyDropAttempted,
    required super.isPrimary,
    required super.pennyDropRequestId,
    required super.userId,
    required super.accountType,
    required super.branchName,
    required super.bankCity,
    required super.bankState,
    required super.userOnboardingDetailId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserBankDetailModel.fromJson(Map<String, dynamic> json) {
    return UserBankDetailModel(
      id: json['id'],
      accountHolderName: json['account_holder_name'],
      accountNumber: json['account_number'],
      ifscCode: json['ifsc_code'],
      proof: json['proof'],
      bankName: json['bank_name'],
      isPennyDropSuccess: json['is_penny_drop_success'],
      isPennyDropAttempted: json['is_penny_drop_attempted'],
      isPrimary: json['is_primary'],
      pennyDropRequestId: json['penny_drop_request_id'],
      userId: json['user_id'],
      accountType: json['account_type'],
      branchName: json['branch_name'],
      bankCity: json['bank_city'],
      bankState: json['bank_state'],
      userOnboardingDetailId: json['user_onboarding_detail_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class MetaModel extends MetaEntity {
  MetaModel({
    required super.total,
    required super.page,
    required super.limit,
    required super.totalPages,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }
}
