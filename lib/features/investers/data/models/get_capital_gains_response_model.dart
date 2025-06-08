import '../../domain/entity/get_capital_gains_entity.dart';

class GetCapitalGainsResponseModel extends GetCapitalGainsEntity {
  GetCapitalGainsResponseModel({
    super.result,
    super.excelDownloadLink,
    super.meta,
  });

  factory GetCapitalGainsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetCapitalGainsResponseModel(
      result: (json['result'] as List?)
          ?.map((e) => CapitalGainModel.fromJson(e))
          .toList(),
      excelDownloadLink: json['excelDownloadLink'],
      meta: json['meta'] != null
          ? CapitalGainMetaModel.fromJson(json['meta'])
          : null,
    );
  }
}

class CapitalGainModel extends CapitalGainEntity {
  CapitalGainModel({
    super.folioNumber,
    super.isin,
    super.schemeName,
    super.type,
    super.amount,
    super.units,
    super.tradedOn,
    super.tradedAt,
    super.sourceDaysHeld,
    super.sourcePurchasedOn,
    super.sourcePurchasedAt,
    super.sourceActualGain,
    super.sourceTaxableGain,
    super.grandFathering,
    super.grandFatheringNav,
    super.indexedCostOfAcquisition,
    super.indexedCapitalGains,
    super.user,
  });

  factory CapitalGainModel.fromJson(Map<String, dynamic> json) {
    return CapitalGainModel(
      folioNumber: json['folio_number'],
      isin: json['isin'],
      schemeName: json['scheme_name'],
      type: json['type'],
      amount: (json['amount'] as num?)?.toDouble(),
      units: json['units'],
      tradedOn: json['traded_on'],
      tradedAt: json['traded_at'],
      sourceDaysHeld: json['source_days_held'],
      sourcePurchasedOn: json['source_purchased_on'] != null
          ? DateTime.tryParse(json['source_purchased_on'])
          : null,
      sourcePurchasedAt: json['source_purchased_at'],
      sourceActualGain: json['source_actual_gain'],
      sourceTaxableGain: json['source_taxable_gain'],
      grandFathering: json['grand_fathering'],
      grandFatheringNav: json['grand_fathering_nav'],
      indexedCostOfAcquisition: json['indexed_cost_of_acquisition'],
      indexedCapitalGains: json['indexed_capital_gains'],
      user: json['user'] != null
          ? CapitalGainUserModel.fromJson(json['user'])
          : null,
    );
  }
}

class CapitalGainUserModel extends CapitalGainUserEntity {
  CapitalGainUserModel({
    super.id,
    super.name,
    super.email,
    super.mobile,
    super.role,
  });

  factory CapitalGainUserModel.fromJson(Map<String, dynamic> json) {
    return CapitalGainUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      role: json['role'],
    );
  }
}

class CapitalGainMetaModel extends CapitalGainMetaEntity {
  CapitalGainMetaModel({
    super.total,
    super.totalPages,
    super.currentPage,
  });

  factory CapitalGainMetaModel.fromJson(Map<String, dynamic> json) {
    return CapitalGainMetaModel(
      total: json['total'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
    );
  }
}
