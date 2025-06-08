class GetRedeemptionDataEntity {
  final int? status;
  final List<RedeemptionDataEntity>? data;
  final MetaEntity? meta;

  GetRedeemptionDataEntity({
    this.status,
    this.data,
    this.meta,
  });
}

class RedeemptionDataEntity {
  final dynamic id;
  final dynamic fpId;
  final dynamic oldId;
  final dynamic mfInvestmentAccount;
  final String? folioNumber;
  final String? state;
  final String? amount;
  final String? scheme;
  final dynamic redemptionMode;
  final dynamic tradedOn;
  final dynamic failedAt;
  final dynamic plan;
  final dynamic euin;
  final dynamic partner;
  final dynamic distributorId;
  final dynamic units;
  final dynamic redeemedPrice;
  final dynamic redeemedUnits;
  final dynamic redeemedAmount;
  final dynamic redemptionBankAccountNumber;
  final dynamic redemptionBankAccountIfscCode;
  final dynamic scheduledOn;
  final dynamic createdAt;
  final dynamic confirmedAt;
  final dynamic succeededAt;
  final dynamic submittedAt;
  final dynamic reversedAt;
  final String? gateway;
  final String? initiatedBy;
  final dynamic initiatedVia;
  final dynamic sourceRefId;
  final String? userIp;
  final String? serverIp;
  final int? userId;
  final int? transactionBasketItemId;
  final dynamic failureCode;
  final String? updatedAt;
  final UserEntity? user;
  final String? fundName;
  final String? logoUrl;

  RedeemptionDataEntity({
    this.id,
    this.fpId,
    this.oldId,
    this.mfInvestmentAccount,
    this.folioNumber,
    this.state,
    this.amount,
    this.scheme,
    this.redemptionMode,
    this.tradedOn,
    this.failedAt,
    this.plan,
    this.euin,
    this.partner,
    this.distributorId,
    this.units,
    this.redeemedPrice,
    this.redeemedUnits,
    this.redeemedAmount,
    this.redemptionBankAccountNumber,
    this.redemptionBankAccountIfscCode,
    this.scheduledOn,
    this.createdAt,
    this.confirmedAt,
    this.succeededAt,
    this.submittedAt,
    this.reversedAt,
    this.gateway,
    this.initiatedBy,
    this.initiatedVia,
    this.sourceRefId,
    this.userIp,
    this.serverIp,
    this.userId,
    this.transactionBasketItemId,
    this.failureCode,
    this.updatedAt,
    this.user,
    this.fundName,
    this.logoUrl,
  });
}

class UserEntity {
  final int? id;
  final String? fullName;
  final String? email;
  final String? mobile;
  final String? role;
  final bool? isBulkUploaded;
  final dynamic bulkUserFileId;
  final dynamic password;
  final String? createdAt;
  final String? updatedAt;

  UserEntity({
    this.id,
    this.fullName,
    this.email,
    this.mobile,
    this.role,
    this.isBulkUploaded,
    this.bulkUserFileId,
    this.password,
    this.createdAt,
    this.updatedAt,
  });
}

class MetaEntity {
  final String? page;
  final String? limit;
  final int? total;
  final int? totalPages;

  MetaEntity({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });
}
