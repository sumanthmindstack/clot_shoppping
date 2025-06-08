// domain/entity/get_stp_data_entity.dart

class GetStpDataEntity {
  final List<StpDataEntity>? data;
  final MetaEntity? meta;

  GetStpDataEntity({
    this.data,
    this.meta,
  });
}

class StpDataEntity {
  final dynamic id;
  final String? state;
  final bool? systematic;
  final String? mfInvestmentAccount;
  final String? folioNumber;
  final String? frequency;
  final String? switchInScheme;
  final String? switchOutScheme;
  final int? installmentDay;
  final String? startDate;
  final String? endDate;
  final int? numberOfInstallments;
  final bool? autoGenerateInstallments;
  final String? nextInstallmentDate;
  final String? previousInstallmentDate;
  final int? remainingInstallments;
  final String? amount;
  final String? sourceRefId;
  final String? euin;
  final String? partner;
  final String? createdAt;
  final String? activatedAt;
  final String? requestedActivationDate;
  final String? cancelledAt;
  final String? completedAt;
  final String? failedAt;
  final String? cancellationScheduledOn;
  final String? gateway;
  final String? userIp;
  final String? serverIp;
  final String? initiatedBy;
  final String? initiatedVia;
  final String? reason;
  final int? userId;
  final int? transactionBasketItemId;
  final String? updatedAt;
  final StpUserEntity? user;
  final String? switchOutFundName;
  final String? switchOutLogoUrl;
  final String? switchInFundName;
  final String? switchInLogoUrl;

  StpDataEntity({
    this.id,
    this.state,
    this.systematic,
    this.mfInvestmentAccount,
    this.folioNumber,
    this.frequency,
    this.switchInScheme,
    this.switchOutScheme,
    this.installmentDay,
    this.startDate,
    this.endDate,
    this.numberOfInstallments,
    this.autoGenerateInstallments,
    this.nextInstallmentDate,
    this.previousInstallmentDate,
    this.remainingInstallments,
    this.amount,
    this.sourceRefId,
    this.euin,
    this.partner,
    this.createdAt,
    this.activatedAt,
    this.requestedActivationDate,
    this.cancelledAt,
    this.completedAt,
    this.failedAt,
    this.cancellationScheduledOn,
    this.gateway,
    this.userIp,
    this.serverIp,
    this.initiatedBy,
    this.initiatedVia,
    this.reason,
    this.userId,
    this.transactionBasketItemId,
    this.updatedAt,
    this.user,
    this.switchOutFundName,
    this.switchOutLogoUrl,
    this.switchInFundName,
    this.switchInLogoUrl,
  });
}

class StpUserEntity {
  final int? id;
  final String? fullName;
  final String? email;
  final String? mobile;
  final String? role;
  final bool? isBulkUploaded;
  final int? bulkUserFileId;
  final String? createdAt;
  final String? updatedAt;

  StpUserEntity({
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
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;

  MetaEntity({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });
}
