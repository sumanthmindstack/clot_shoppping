class PortfolioAnalysisGraphDataEntity {
  final List<PortfolioAnalysisGraphDataItemEntity> data;

  const PortfolioAnalysisGraphDataEntity({required this.data});
}

class PortfolioAnalysisGraphDataItemEntity {
  final int id;
  final int userId;
  final double investedAmount;
  final double currentValue;
  final double unrealizedGain;
  final double absoluteReturn;
  final double cagr;
  final double? xirr;
  final String date;
  final double? adjustedValue;
  final double dayChange;

  const PortfolioAnalysisGraphDataItemEntity({
    required this.id,
    required this.userId,
    required this.investedAmount,
    required this.currentValue,
    required this.unrealizedGain,
    required this.absoluteReturn,
    required this.cagr,
    this.xirr,
    required this.date,
    this.adjustedValue,
    required this.dayChange,
  });
}
