class GetHoldingDetailsEntity {
  final HoldingDetailsEntity data;
  final PaginationEntity pagination;
  final String excelDownloadLink;

  GetHoldingDetailsEntity({
    required this.data,
    required this.pagination,
    required this.excelDownloadLink,
  });
}

class HoldingDetailsEntity {
  final int id;
  final List<FolioEntity> folios;

  HoldingDetailsEntity({
    required this.id,
    required this.folios,
  });
}

class FolioEntity {
  final String folioNumber;
  final List<SchemeEntity> schemes;

  FolioEntity({
    required this.folioNumber,
    required this.schemes,
  });
}

class SchemeEntity {
  final String isin;
  final String name;
  final String type;
  final HoldingDetailEntity holdings;
  final MarketValueEntity marketValue;
  final AmountValueEntity investedValue;
  final AmountValueEntity payout;
  final NavValueEntity nav;
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

class HoldingDetailEntity {
  final String asOn;
  final double units;
  final double redeemableUnits;

  HoldingDetailEntity({
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

class AmountValueEntity {
  final String asOn;
  final double amount;

  AmountValueEntity({
    required this.asOn,
    required this.amount,
  });
}

class NavValueEntity {
  final String asOn;
  final double value;

  NavValueEntity({
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

class PaginationEntity {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final int excelRecords;

  PaginationEntity({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.excelRecords,
  });
}
