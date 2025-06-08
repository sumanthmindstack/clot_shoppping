import '../../domain/entity/get_scheme_wise_entity.dart';

class GetSchemeWiseResponseModel extends GetSchemeWiseEntity {
  GetSchemeWiseResponseModel({
    super.result,
    super.excelDownloadLink,
    super.meta,
  });

  factory GetSchemeWiseResponseModel.fromJson(Map<String, dynamic> json) {
    return GetSchemeWiseResponseModel(
      result: (json['result'] as List?)
              ?.map((e) => SchemeWiseModel.fromJson(e))
              .toList() ??
          [],
      excelDownloadLink: json['excelDownloadLink'],
      meta: json['meta'] != null
          ? SchemeWiseMetaModel.fromJson(json['meta'])
          : null,
    );
  }
}

class SchemeWiseModel extends SchemeWiseEntity {
  SchemeWiseModel({
    super.folioNumber,
    super.isin,
    super.schemeName,
    super.planType,
    super.investmentOption,
    super.tradedOn,
    super.asOn,
    super.nav,
    super.investedAmount,
    super.currentValue,
    super.unrealizedGain,
    super.absoluteReturn,
    super.averageBuyingValue,
    super.units,
    super.userDetails,
  });

  factory SchemeWiseModel.fromJson(Map<String, dynamic> json) {
    return SchemeWiseModel(
      folioNumber: json['folio_number'],
      isin: json['isin'],
      schemeName: json['scheme_name'],
      planType: json['type'],
      investmentOption: json['investment_option'],
      tradedOn: json['traded_on'],
      asOn: json['as_on'],
      nav: (json['nav'] as num?)?.toDouble(),
      investedAmount: json['invested_amount'],
      currentValue: json['current_value'],
      unrealizedGain: json['unrealized_gain'],
      absoluteReturn: json['absolute_return'],
      averageBuyingValue: json['average_buying_value'],
      units: json['units'],
      userDetails: json['user_details'] != null
          ? SchemeWiseUserModel.fromJson(json['user_details'])
          : null,
    );
  }
}

class SchemeWiseUserModel extends SchemeWiseUserEntity {
  SchemeWiseUserModel({
    super.id,
    super.name,
    super.email,
    super.mobile,
    super.role,
  });

  factory SchemeWiseUserModel.fromJson(Map<String, dynamic> json) {
    return SchemeWiseUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      role: json['role'],
    );
  }
}

class SchemeWiseMetaModel extends SchemeWiseMetaEntity {
  SchemeWiseMetaModel({
    super.total,
    super.totalPages,
    super.currentPage,
  });

  factory SchemeWiseMetaModel.fromJson(Map<String, dynamic> json) {
    return SchemeWiseMetaModel(
      total: json['total'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
    );
  }
}
