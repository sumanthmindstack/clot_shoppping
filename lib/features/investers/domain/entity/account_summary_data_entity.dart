class AccountSummaryDataEntity {
  final List<InvestmentAccountEntity>? data;
  final String? excelDownloadLink;
  final MetaEntity? meta;

  AccountSummaryDataEntity({
    required this.data,
    required this.excelDownloadLink,
    required this.meta,
  });
}

class InvestmentAccountEntity {
  final int investmentAccountId;
  final double investedAmount;
  final String currentValue;
  final String unrealizedGain;
  final String absoluteReturn;
  final String cagr;
  final UserDetailsEntity? userDetails;

  InvestmentAccountEntity({
    required this.investmentAccountId,
    required this.investedAmount,
    required this.currentValue,
    required this.unrealizedGain,
    required this.absoluteReturn,
    required this.cagr,
    required this.userDetails,
  });
}

class UserDetailsEntity {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String role;

  UserDetailsEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
  });
}

class MetaEntity {
  final int total;
  final int totalPages;
  final String currentPage;

  MetaEntity({
    required this.total,
    required this.totalPages,
    required this.currentPage,
  });
}
