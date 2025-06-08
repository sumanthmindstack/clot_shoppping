class GetSipDataEntity {
  final List<SipDataEntity> data;
  final MetaEntity? meta;

  GetSipDataEntity({
    required this.data,
    this.meta,
  });
}

class SipDataEntity {
  final String id;
  final String? state;
  final String? mfInvestmentAccount;
  final String? folioNumber;
  final bool systematic;
  final String? frequency;
  final String? scheme;
  final bool autoGenerateInstallments;
  final int? installmentDay;
  final String? startDate;
  final String? endDate;
  final String? requestedActivationDate;
  final int? numberOfInstallments;
  final String? nextInstallmentDate;
  final String? previousInstallmentDate;
  final int? remainingInstallments;
  final String? amount;
  final String? paymentMethod;
  final String? paymentSource;
  final String? purpose;
  final String? sourceRefId;
  final String? euin;
  final String? partner;
  final String? createdAt;
  final String? updatedAt;
  final String? activatedAt;
  final String? cancelledAt;
  final String? completedAt;
  final String? failedAt;
  final String? cancellationScheduledOn;
  final String? cancellationCode;
  final String? reason;
  final String? gateway;
  final String? userIp;
  final String? serverIp;
  final String? initiatedBy;
  final String? initiatedVia;
  final int? userId;
  final int? transactionBasketItemId;
  final SipUserEntity user;
  final String? fundName;
  final String? logoUrl;

  SipDataEntity({
    required this.id,
    this.state,
    this.mfInvestmentAccount,
    this.folioNumber,
    required this.systematic,
    this.frequency,
    this.scheme,
    required this.autoGenerateInstallments,
    this.installmentDay,
    this.startDate,
    this.endDate,
    this.requestedActivationDate,
    this.numberOfInstallments,
    this.nextInstallmentDate,
    this.previousInstallmentDate,
    this.remainingInstallments,
    this.amount,
    this.paymentMethod,
    this.paymentSource,
    this.purpose,
    this.sourceRefId,
    this.euin,
    this.partner,
    this.createdAt,
    this.updatedAt,
    this.activatedAt,
    this.cancelledAt,
    this.completedAt,
    this.failedAt,
    this.cancellationScheduledOn,
    this.cancellationCode,
    this.reason,
    this.gateway,
    this.userIp,
    this.serverIp,
    this.initiatedBy,
    this.initiatedVia,
    this.userId,
    this.transactionBasketItemId,
    required this.user,
    this.fundName,
    this.logoUrl,
  });
}

class SipUserEntity {
  final int id;
  final String fullName;
  final String email;
  final String mobile;
  final String role;
  final bool isBulkUploaded;
  final String? bulkUserFileId;
  final String? password;
  final String? createdAt;
  final String? updatedAt;

  SipUserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.role,
    required this.isBulkUploaded,
    this.bulkUserFileId,
    this.password,
    this.createdAt,
    this.updatedAt,
  });
}

class MetaEntity {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  MetaEntity({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });
}
