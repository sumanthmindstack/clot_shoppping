class GetLumpsumDataEntity {
  final List<LumpsumDataEntity>? data;
  final MetaEntity? meta;
  GetLumpsumDataEntity({this.data, this.meta});
}

class LumpsumDataEntity {
  final int? id;
  final String? oldId;
  final String? fpId;
  final String? plan;
  final String? state;
  final String? folioNumber;
  final String? systematic;
  final String? frequency;
  final String? scheme;
  final bool? autoGenerateInstalments;
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
  final String? activatedAt;
  final String? cancelledAt;
  final String? completedAt;
  final String? failedAt;
  final String? cancellationScheduledOn;
  final String? reason;
  final String? gateway;
  final String? userIp;
  final String? serverIp;
  final String? initiatedBy;
  final String? initiatedVia;
  final String? reversedAt;
  final String? submittedAt;
  final String? succeededAt;
  final String? scheduledOn;
  final String? tradedOn;
  final String? allottedUnits;
  final String? purchasedPrice;
  final String? retriedAt;
  final String? confirmedAt;
  final String? failureCode;
  final String? updatedAt;
  final int? userId;
  final int? transactionBasketItemId;
  final LumpsumUserEntity? user;
  final String? fundName;
  final String? logoUrl;

  LumpsumDataEntity({
    this.id,
    this.oldId,
    this.fpId,
    this.plan,
    this.state,
    this.folioNumber,
    this.systematic,
    this.frequency,
    this.scheme,
    this.autoGenerateInstalments,
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
    this.activatedAt,
    this.cancelledAt,
    this.completedAt,
    this.failedAt,
    this.cancellationScheduledOn,
    this.reason,
    this.gateway,
    this.userIp,
    this.serverIp,
    this.initiatedBy,
    this.initiatedVia,
    this.reversedAt,
    this.submittedAt,
    this.succeededAt,
    this.scheduledOn,
    this.tradedOn,
    this.allottedUnits,
    this.purchasedPrice,
    this.retriedAt,
    this.confirmedAt,
    this.failureCode,
    this.updatedAt,
    this.userId,
    this.transactionBasketItemId,
    this.user,
    this.fundName,
    this.logoUrl,
  });
}

class LumpsumUserEntity {
  final int? id;
  final String? fullName;
  final String? email;
  final String? mobile;
  final String? role;
  final bool? isBulkUploaded;
  final String? bulkUserFileId;
  final String? createdAt;
  final String? updatedAt;

  LumpsumUserEntity({
    this.id,
    this.fullName,
    this.email,
    this.mobile,
    this.role,
    this.isBulkUploaded,
    this.bulkUserFileId,
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
