class DashAumReportGraphEntity {
  final List<AumMonthlyDataEntity> monthlyData;
  final double equityValue;
  final double debtValue;
  final double hybridValue;
  final double alternateValue;

  const DashAumReportGraphEntity({
    required this.monthlyData,
    required this.equityValue,
    required this.debtValue,
    required this.hybridValue,
    required this.alternateValue,
  });
}

class AumMonthlyDataEntity {
  final String month;
  final double equity;
  final double debt;
  final double hybrid;
  final double alternate;
  final double equityValue;
  final double debtValue;
  final double hybridValue;
  final double alternateValue;
  final double equityPercentage;
  final double debtPercentage;
  final double hybridPercentage;
  final double alternatePercentage;

  const AumMonthlyDataEntity({
    required this.month,
    required this.equity,
    required this.debt,
    required this.hybrid,
    required this.alternate,
    required this.equityValue,
    required this.debtValue,
    required this.hybridValue,
    required this.alternateValue,
    required this.equityPercentage,
    required this.debtPercentage,
    required this.hybridPercentage,
    required this.alternatePercentage,
  });
}
