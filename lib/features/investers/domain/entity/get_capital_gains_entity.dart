class GetCapitalGainsEntity {
  final List<CapitalGainEntity>? result;
  final String? excelDownloadLink;
  final CapitalGainMetaEntity? meta;

  GetCapitalGainsEntity({
    this.result,
    this.excelDownloadLink,
    this.meta,
  });
}

class CapitalGainEntity {
  final String? folioNumber;
  final String? isin;
  final String? schemeName;
  final String? type;
  final num? amount;
  final String? units;
  final String? tradedOn;
  final String? tradedAt;
  final String? sourceDaysHeld;
  final DateTime? sourcePurchasedOn;
  final String? sourcePurchasedAt;
  final String? sourceActualGain;
  final String? sourceTaxableGain;
  final bool? grandFathering;
  final num? grandFatheringNav;
  final String? indexedCostOfAcquisition;
  final String? indexedCapitalGains;
  final CapitalGainUserEntity? user;

  CapitalGainEntity({
    this.folioNumber,
    this.isin,
    this.schemeName,
    this.type,
    this.amount,
    this.units,
    this.tradedOn,
    this.tradedAt,
    this.sourceDaysHeld,
    this.sourcePurchasedOn,
    this.sourcePurchasedAt,
    this.sourceActualGain,
    this.sourceTaxableGain,
    this.grandFathering,
    this.grandFatheringNav,
    this.indexedCostOfAcquisition,
    this.indexedCapitalGains,
    this.user,
  });
}

class CapitalGainUserEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? role;

  CapitalGainUserEntity({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.role,
  });
}

class CapitalGainMetaEntity {
  final int? total;
  final int? totalPages;
  final String? currentPage;

  CapitalGainMetaEntity({
    this.total,
    this.totalPages,
    this.currentPage,
  });
}
