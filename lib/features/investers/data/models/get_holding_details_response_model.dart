import '../../domain/entity/get_holding_details_entity.dart';

class GetHoldingDetailsResponseModel extends GetHoldingDetailsEntity {
  GetHoldingDetailsResponseModel({
    required HoldingDetailsModel super.data,
    required PaginationModel super.pagination,
    required super.excelDownloadLink,
  });

  factory GetHoldingDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetHoldingDetailsResponseModel(
      data: HoldingDetailsModel.fromJson(json['data']),
      pagination: PaginationModel.fromJson(json['pagination']),
      excelDownloadLink: json['excelDownloadLink'],
    );
  }
}

class HoldingDetailsModel extends HoldingDetailsEntity {
  HoldingDetailsModel({
    required super.id,
    required List<FolioModel> super.folios,
  });

  factory HoldingDetailsModel.fromJson(Map<String, dynamic> json) {
    return HoldingDetailsModel(
      id: json['id'],
      folios:
          (json['folios'] as List).map((e) => FolioModel.fromJson(e)).toList(),
    );
  }
}

class FolioModel extends FolioEntity {
  FolioModel({
    required super.folioNumber,
    required List<SchemeModel> super.schemes,
  });

  factory FolioModel.fromJson(Map<String, dynamic> json) {
    return FolioModel(
      folioNumber: json['folio_number'],
      schemes: (json['schemes'] as List)
          .map((e) => SchemeModel.fromJson(e))
          .toList(),
    );
  }
}

class SchemeModel extends SchemeEntity {
  SchemeModel({
    required super.isin,
    required super.name,
    required super.type,
    required HoldingDetailModel super.holdings,
    required MarketValueModel super.marketValue,
    required AmountValueModel super.investedValue,
    required AmountValueModel super.payout,
    required NavValueModel super.nav,
    required super.amcId,
    required super.planId,
    required super.logoUrl,
    required UserDetailModel super.userDetail,
  });

  factory SchemeModel.fromJson(Map<String, dynamic> json) {
    return SchemeModel(
      isin: json['isin'],
      name: json['name'],
      type: json['type'],
      holdings: HoldingDetailModel.fromJson(json['holdings']),
      marketValue: MarketValueModel.fromJson(json['market_value']),
      investedValue: AmountValueModel.fromJson(json['invested_value']),
      payout: AmountValueModel.fromJson(json['payout']),
      nav: NavValueModel.fromJson(json['nav']),
      amcId: json['amc_id'],
      planId: json['plan_id'],
      logoUrl: json['logo_url'],
      userDetail: UserDetailModel.fromJson(json['user_detail']),
    );
  }
}

class HoldingDetailModel extends HoldingDetailEntity {
  HoldingDetailModel({
    required String asOn,
    required double units,
    required double redeemableUnits,
  }) : super(asOn: asOn, units: units, redeemableUnits: redeemableUnits);

  factory HoldingDetailModel.fromJson(Map<String, dynamic> json) {
    return HoldingDetailModel(
      asOn: json['as_on'],
      units: (json['units'] as num).toDouble(),
      redeemableUnits: (json['redeemable_units'] as num).toDouble(),
    );
  }
}

class MarketValueModel extends MarketValueEntity {
  MarketValueModel({
    required super.asOn,
    required super.amount,
    required super.redeemableAmount,
  });

  factory MarketValueModel.fromJson(Map<String, dynamic> json) {
    return MarketValueModel(
      asOn: json['as_on'],
      amount: (json['amount'] as num).toDouble(),
      redeemableAmount: (json['redeemable_amount'] as num).toDouble(),
    );
  }
}

class AmountValueModel extends AmountValueEntity {
  AmountValueModel({
    required super.asOn,
    required super.amount,
  });

  factory AmountValueModel.fromJson(Map<String, dynamic> json) {
    return AmountValueModel(
      asOn: json['as_on'],
      amount: (json['amount'] as num).toDouble(),
    );
  }
}

class NavValueModel extends NavValueEntity {
  NavValueModel({
    required super.asOn,
    required super.value,
  });

  factory NavValueModel.fromJson(Map<String, dynamic> json) {
    return NavValueModel(
      asOn: json['as_on'],
      value: (json['value'] as num).toDouble(),
    );
  }
}

class UserDetailModel extends UserDetailEntity {
  UserDetailModel({
    required int id,
    required String name,
    required String email,
    required String mobile,
    required String role,
  }) : super(id: id, name: name, email: email, mobile: mobile, role: role);

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      role: json['role'],
    );
  }
}

class PaginationModel extends PaginationEntity {
  PaginationModel({
    required int currentPage,
    required int totalPages,
    required int totalItems,
    required int itemsPerPage,
    required int excelRecords,
  }) : super(
          currentPage: currentPage,
          totalPages: totalPages,
          totalItems: totalItems,
          itemsPerPage: itemsPerPage,
          excelRecords: excelRecords,
        );

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      itemsPerPage: json['itemsPerPage'],
      excelRecords: json['excelRecords'],
    );
  }
}
