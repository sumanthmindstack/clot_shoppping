import '../../domain/entity/portfolio_analysis_entity.dart';

class PortfolioAnalysisResponseModel extends PortfolioAnalysisEntity {
  PortfolioAnalysisResponseModel({
    required super.id,
    required super.folios,
    required super.status,
    required super.data,
  });

  factory PortfolioAnalysisResponseModel.fromJson(Map<String, dynamic> json) =>
      PortfolioAnalysisResponseModel(
        id: json['id'],
        folios: List<Folio>.from(json['folios'].map((x) => Folio.fromJson(x))),
        status: json['status'],
        data: DataDetails.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'folios': folios.map((x) => x).toList(),
        'status': status,
        'data': data,
      };
}

class Folio extends FolioEntity {
  Folio({
    required super.folioNumber,
    required super.schemes,
    required super.total,
  });

  factory Folio.fromJson(Map<String, dynamic> json) => Folio(
        folioNumber: json['folio_number'],
        schemes:
            List<Scheme>.from(json['schemes'].map((x) => Scheme.fromJson(x))),
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'folio_number': folioNumber,
        'schemes': schemes.map((x) => x).toList(),
        'total': total,
      };
}

class Scheme extends SchemeEntity {
  Scheme({
    required super.isin,
    required super.name,
    required super.type,
    required super.holdings,
    required super.marketValue,
    required super.investedValue,
    required super.payout,
    required super.nav,
    required super.amcId,
    required super.planId,
    required super.logoUrl,
    required super.userDetail,
  });

  factory Scheme.fromJson(Map<String, dynamic> json) => Scheme(
        isin: json['isin'],
        name: json['name'],
        type: json['type'],
        holdings: Holdings.fromJson(json['holdings']),
        marketValue: MarketValue.fromJson(json['market_value']),
        investedValue: InvestedValue.fromJson(json['invested_value']),
        payout: Payout.fromJson(json['payout']),
        nav: Nav.fromJson(json['nav']),
        amcId: json['amc_id'],
        planId: json['plan_id'],
        logoUrl: json['logo_url'],
        userDetail: UserDetail.fromJson(json['user_detail']),
      );

  Map<String, dynamic> toJson() => {
        'isin': isin,
        'name': name,
        'type': type,
        'holdings': holdings,
        'market_value': marketValue,
        'invested_value': investedValue,
        'payout': payout,
        'nav': nav,
        'amc_id': amcId,
        'plan_id': planId,
        'logo_url': logoUrl,
        'user_detail': userDetail,
      };
}

class Holdings extends HoldingsEntity {
  Holdings({
    required super.asOn,
    required super.units,
    required super.redeemableUnits,
  });

  factory Holdings.fromJson(Map<String, dynamic> json) => Holdings(
        asOn: json['as_on'],
        units: (json['units'] as num).toDouble(),
        redeemableUnits: (json['redeemable_units'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'as_on': asOn,
        'units': units,
        'redeemable_units': redeemableUnits,
      };
}

class MarketValue extends MarketValueEntity {
  MarketValue({
    required super.asOn,
    required super.amount,
    required super.redeemableAmount,
  });

  factory MarketValue.fromJson(Map<String, dynamic> json) => MarketValue(
        asOn: json['as_on'],
        amount: (json['amount'] as num).toDouble(),
        redeemableAmount: (json['redeemable_amount'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'as_on': asOn,
        'amount': amount,
        'redeemable_amount': redeemableAmount,
      };
}

class InvestedValue extends InvestedValueEntity {
  InvestedValue({
    required super.asOn,
    required super.amount,
  });

  factory InvestedValue.fromJson(Map<String, dynamic> json) => InvestedValue(
        asOn: json['as_on'],
        amount: (json['amount'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'as_on': asOn,
        'amount': amount,
      };
}

class Payout extends PayoutEntity {
  Payout({
    required super.asOn,
    required super.amount,
  });

  factory Payout.fromJson(Map<String, dynamic> json) => Payout(
        asOn: json['as_on'],
        amount: (json['amount'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'as_on': asOn,
        'amount': amount,
      };
}

class Nav extends NavEntity {
  Nav({
    required super.asOn,
    required super.value,
  });

  factory Nav.fromJson(Map<String, dynamic> json) => Nav(
        asOn: json['as_on'],
        value: (json['value'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'as_on': asOn,
        'value': value,
      };
}

class UserDetail extends UserDetailEntity {
  UserDetail({
    required super.id,
    required super.name,
    required super.email,
    required super.mobile,
    required super.role,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        mobile: json['mobile'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'mobile': mobile,
        'role': role,
      };
}

class DataDetails extends DataDetailsEntity {
  DataDetails({
    required super.totalInvestments,
    required super.totalAbsoluteReturn,
    required super.fundAnalysisVariables,
    required super.categoryBaseAllocation,
    required super.sectorBaseAllocation,
    required super.capBaseAllocation,
    required super.stockBaseAllocation,
  });

  factory DataDetails.fromJson(Map<String, dynamic> json) => DataDetails(
        totalInvestments: (json['total_investments'] as num).toDouble(),
        totalAbsoluteReturn: (json['total_absolute_return'] as num).toDouble(),
        fundAnalysisVariables: Map<String, double>.from(
            (json['fund_analysis_variables'] as Map).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        )),
        categoryBaseAllocation: Map<String, double>.from(
            (json['category_base_allocation'] as Map).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        )),
        sectorBaseAllocation:
            Map<String, double>.from((json['sector_base_alloction'] as Map).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        )),
        capBaseAllocation:
            Map<String, double>.from((json['cap_base_allocation'] as Map).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        )),
        stockBaseAllocation:
            Map<String, double>.from((json['stock_base_allocation'] as Map).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        )),
      );

  Map<String, dynamic> toJson() => {
        'total_investments': totalInvestments,
        'total_absolute_return': totalAbsoluteReturn,
        'fund_analysis_variables': fundAnalysisVariables,
        'category_base_allocation': categoryBaseAllocation,
        'sector_base_alloction': sectorBaseAllocation,
        'cap_base_allocation': capBaseAllocation,
        'stock_base_allocation': stockBaseAllocation,
      };
}
