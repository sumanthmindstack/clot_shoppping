class GetSchemeWiseEntity {
  final List<SchemeWiseEntity>? result;
  final String? excelDownloadLink;
  final SchemeWiseMetaEntity? meta;

  GetSchemeWiseEntity({
    this.result,
    this.excelDownloadLink,
    this.meta,
  });
}

class SchemeWiseEntity {
  final String? folioNumber;
  final String? isin;
  final String? schemeName;
  final String? planType;
  final String? investmentOption;
  final String? tradedOn;
  final String? asOn;
  final double? nav;
  final String? investedAmount;
  final String? currentValue;
  final String? unrealizedGain;
  final String? absoluteReturn;
  final String? averageBuyingValue;
  final String? units;
  final SchemeWiseUserEntity? userDetails;

  SchemeWiseEntity({
    this.folioNumber,
    this.isin,
    this.schemeName,
    this.planType,
    this.investmentOption,
    this.tradedOn,
    this.asOn,
    this.nav,
    this.investedAmount,
    this.currentValue,
    this.unrealizedGain,
    this.absoluteReturn,
    this.averageBuyingValue,
    this.units,
    this.userDetails,
  });
}

class SchemeWiseUserEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? role;

  SchemeWiseUserEntity({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.role,
  });
}

class SchemeWiseMetaEntity {
  final int? total;
  final int? totalPages;
  final String? currentPage;

  SchemeWiseMetaEntity({
    this.total,
    this.totalPages,
    this.currentPage,
  });
}
