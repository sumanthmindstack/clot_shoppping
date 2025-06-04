class PortfolioAnalysisEntity {
  final int id;
  final List<FolioEntity> folios;
  final int status;
  final DataDetailsEntity data;

  PortfolioAnalysisEntity({
    required this.id,
    required this.folios,
    required this.status,
    required this.data,
  });
}

class FolioEntity {
  final String folioNumber;
  final List<SchemeEntity> schemes;
  final int total;

  FolioEntity({
    required this.folioNumber,
    required this.schemes,
    required this.total,
  });
}

class SchemeEntity {
  final String isin;
  final String name;
  final String type;
  final HoldingsEntity holdings;
  final MarketValueEntity marketValue;
  final InvestedValueEntity investedValue;
  final PayoutEntity payout;
  final NavEntity nav;
  final int amcId;
  final int planId;
  final String logoUrl;
  final UserDetailEntity userDetail;

  SchemeEntity({
    required this.isin,
    required this.name,
    required this.type,
    required this.holdings,
    required this.marketValue,
    required this.investedValue,
    required this.payout,
    required this.nav,
    required this.amcId,
    required this.planId,
    required this.logoUrl,
    required this.userDetail,
  });
}

class HoldingsEntity {
  final String asOn;
  final double units;
  final double redeemableUnits;

  HoldingsEntity({
    required this.asOn,
    required this.units,
    required this.redeemableUnits,
  });
}

class MarketValueEntity {
  final String asOn;
  final double amount;
  final double redeemableAmount;

  MarketValueEntity({
    required this.asOn,
    required this.amount,
    required this.redeemableAmount,
  });
}

class InvestedValueEntity {
  final String asOn;
  final double amount;

  InvestedValueEntity({
    required this.asOn,
    required this.amount,
  });
}

class PayoutEntity {
  final String asOn;
  final double amount;

  PayoutEntity({
    required this.asOn,
    required this.amount,
  });
}

class NavEntity {
  final String asOn;
  final double value;

  NavEntity({
    required this.asOn,
    required this.value,
  });
}

class UserDetailEntity {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String role;

  UserDetailEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
  });
}

class DataDetailsEntity {
  final double totalInvestments;
  final double totalAbsoluteReturn;
  final Map<String, double> fundAnalysisVariables;
  final Map<String, double> categoryBaseAllocation;
  final Map<String, double> sectorBaseAllocation;
  final Map<String, double> capBaseAllocation;
  final Map<String, double> stockBaseAllocation;

  DataDetailsEntity({
    required this.totalInvestments,
    required this.totalAbsoluteReturn,
    required this.fundAnalysisVariables,
    required this.categoryBaseAllocation,
    required this.sectorBaseAllocation,
    required this.capBaseAllocation,
    required this.stockBaseAllocation,
  });
}
