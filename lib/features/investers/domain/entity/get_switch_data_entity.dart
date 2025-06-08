class GetSwitchDataEntity {
  final List<SwitchDataEntity> data;
  final MetaEntity? meta;

  GetSwitchDataEntity({
    required this.data,
    required this.meta,
  });
}

class SwitchDataEntity {
  final int id;
  final dynamic fpId;
  final dynamic oldId;
  final dynamic mfInvestmentAccount;
  final String folioNumber;
  final String state;
  final String amount;
  final dynamic units;
  final String switchOutScheme;
  final String switchInScheme;
  final dynamic plan;
  final dynamic switchedOutUnits;
  final dynamic switchedOutAmount;
  final dynamic switchedOutPrice;
  final dynamic switchedInUnits;
  final dynamic switchedInAmount;
  final dynamic switchedInPrice;
  final String gateway;
  final dynamic tradedOn;
  final dynamic scheduledOn;
  final dynamic createdAt;
  final dynamic succeededAt;
  final dynamic submittedAt;
  final dynamic reversedAt;
  final dynamic failedAt;
  final dynamic confirmedAt;
  final dynamic sourceRefId;
  final String userIp;
  final String serverIp;
  final String initiatedBy;
  final String initiatedVia;
  final dynamic euin;
  final dynamic partner;
  final dynamic failureCode;
  final String? updatedAt;
  final int userId;
  final int transactionBasketItemId;
  final SwitchUserEntity user;
  final String switchOutFundName;
  final String switchOutLogoUrl;
  final String switchInFundName;
  final String switchInLogoUrl;

  SwitchDataEntity({
    required this.id,
    required this.fpId,
    required this.oldId,
    required this.mfInvestmentAccount,
    required this.folioNumber,
    required this.state,
    required this.amount,
    required this.units,
    required this.switchOutScheme,
    required this.switchInScheme,
    required this.plan,
    required this.switchedOutUnits,
    required this.switchedOutAmount,
    required this.switchedOutPrice,
    required this.switchedInUnits,
    required this.switchedInAmount,
    required this.switchedInPrice,
    required this.gateway,
    required this.tradedOn,
    required this.scheduledOn,
    required this.createdAt,
    required this.succeededAt,
    required this.submittedAt,
    required this.reversedAt,
    required this.failedAt,
    required this.confirmedAt,
    required this.sourceRefId,
    required this.userIp,
    required this.serverIp,
    required this.initiatedBy,
    required this.initiatedVia,
    required this.euin,
    required this.partner,
    required this.failureCode,
    required this.updatedAt,
    required this.userId,
    required this.transactionBasketItemId,
    required this.user,
    required this.switchOutFundName,
    required this.switchOutLogoUrl,
    required this.switchInFundName,
    required this.switchInLogoUrl,
  });
}

class SwitchUserEntity {
  final int id;
  final String fullName;
  final String email;
  final String mobile;
  final String role;
  final bool isBulkUploaded;
  final dynamic bulkUserFileId;
  final dynamic password;
  final String createdAt;
  final String updatedAt;

  SwitchUserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.role,
    required this.isBulkUploaded,
    required this.bulkUserFileId,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
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
