import '../../domain/entity/portfolio_analysis_graph_data_entity.dart';

class PortfolioAnalysisGraphDataResponseModel
    extends PortfolioAnalysisGraphDataEntity {
  PortfolioAnalysisGraphDataResponseModel({required super.data});

  factory PortfolioAnalysisGraphDataResponseModel.fromJson(
      Map<String, dynamic> json) {
    final list = (json['data'] as List<dynamic>? ?? [])
        .map((e) => PortfolioAnalysisGraphDataItemModel.fromJson(e))
        .toList();

    return PortfolioAnalysisGraphDataResponseModel(data: list);
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((e) => e).toList(),
      };
}

class PortfolioAnalysisGraphDataItemModel
    extends PortfolioAnalysisGraphDataItemEntity {
  const PortfolioAnalysisGraphDataItemModel({
    required super.id,
    required super.userId,
    required super.investedAmount,
    required super.currentValue,
    required super.unrealizedGain,
    required super.absoluteReturn,
    required super.cagr,
    super.xirr,
    required super.date,
    super.adjustedValue,
    required super.dayChange,
  });

  factory PortfolioAnalysisGraphDataItemModel.fromJson(
      Map<String, dynamic> json) {
    return PortfolioAnalysisGraphDataItemModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      investedAmount: (json['invested_amount'] ?? 0).toDouble(),
      currentValue: (json['current_value'] ?? 0).toDouble(),
      unrealizedGain: (json['unrealized_gain'] ?? 0).toDouble(),
      absoluteReturn: (json['absolute_return'] ?? 0).toDouble(),
      cagr: (json['cagr'] ?? 0).toDouble(),
      xirr: json['xirr'] != null ? (json['xirr']).toDouble() : null,
      date: json['date'] ?? '',
      adjustedValue: json['addjusted_value'] != null
          ? (json['addjusted_value']).toDouble()
          : null,
      dayChange: (json['day_change'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'invested_amount': investedAmount,
      'current_value': currentValue,
      'unrealized_gain': unrealizedGain,
      'absolute_return': absoluteReturn,
      'cagr': cagr,
      'xirr': xirr,
      'date': date,
      'addjusted_value': adjustedValue,
      'day_change': dayChange,
    };
  }
}
