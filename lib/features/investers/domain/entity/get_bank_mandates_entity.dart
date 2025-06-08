class GetBankMandatesEntity {
  final List<BankMandateEntity> data;
  final MetaEntity meta;

  GetBankMandatesEntity({
    required this.data,
    required this.meta,
  });
}

class BankMandateEntity {
  final int id;
  final String mandateType;
  final int? fpBankId;
  final int bankId;
  final num mandateLimit;
  final String providerName;
  final String? validFrom;
  final String mandateId;
  final String tokenUrl;
  final String? paymentId;
  final String status;
  final String? failureReason;
  final int userId;
  final String? rejectedReason;
  final String customerId;
  final String? rejectedAt;
  final String? receivedAt;
  final String? approvedAt;
  final String? submittedAt;
  final String? cancelledAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserBankDetailEntity userBankDetail;
  final String logoUrl;

  BankMandateEntity({
    required this.id,
    required this.mandateType,
    this.fpBankId,
    required this.bankId,
    required this.mandateLimit,
    required this.providerName,
    this.validFrom,
    required this.mandateId,
    required this.tokenUrl,
    this.paymentId,
    required this.status,
    this.failureReason,
    required this.userId,
    this.rejectedReason,
    required this.customerId,
    this.rejectedAt,
    this.receivedAt,
    this.approvedAt,
    this.submittedAt,
    this.cancelledAt,
    required this.createdAt,
    required this.updatedAt,
    required this.userBankDetail,
    required this.logoUrl,
  });
}

class UserBankDetailEntity {
  final int id;
  final String accountHolderName;
  final String accountNumber;
  final String ifscCode;
  final String proof;
  final String bankName;
  final bool isPennyDropSuccess;
  final bool isPennyDropAttempted;
  final bool isPrimary;
  final String? pennyDropRequestId;
  final int userId;
  final String? accountType;
  final String? branchName;
  final String? bankCity;
  final String? bankState;
  final int userOnboardingDetailId;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserBankDetailEntity({
    required this.id,
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
    required this.proof,
    required this.bankName,
    required this.isPennyDropSuccess,
    required this.isPennyDropAttempted,
    required this.isPrimary,
    this.pennyDropRequestId,
    required this.userId,
    this.accountType,
    this.branchName,
    this.bankCity,
    this.bankState,
    required this.userOnboardingDetailId,
    required this.createdAt,
    required this.updatedAt,
  });
}

class MetaEntity {
  final int total;
  final String page;
  final String limit;
  final int totalPages;

  MetaEntity({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });
}
