import '../../domain/entities/dash_aum_report_graph_entity.dart';

class DashAumReportGraphResponseModel extends DashAumReportGraphEntity {
  const DashAumReportGraphResponseModel({
    required List<AumMonthlyDataModel> monthlyData,
    required super.equityValue,
    required super.debtValue,
    required super.hybridValue,
    required super.alternateValue,
  }) : super(monthlyData: monthlyData);

  factory DashAumReportGraphResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return DashAumReportGraphResponseModel(
      monthlyData: (data['monthly_data'] as List)
          .map((e) => AumMonthlyDataModel.fromJson(e))
          .toList(),
      equityValue: data['equity_value']?.toDouble() ?? 0,
      debtValue: data['debt_value']?.toDouble() ?? 0,
      hybridValue: data['hybrid_value']?.toDouble() ?? 0,
      alternateValue: data['alternate_value']?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'monthly_data': monthlyData
            .map((e) => (e as AumMonthlyDataModel).toJson())
            .toList(),
        'equity_value': equityValue,
        'debt_value': debtValue,
        'hybrid_value': hybridValue,
        'alternate_value': alternateValue,
      }
    };
  }
}

class AumMonthlyDataModel extends AumMonthlyDataEntity {
  const AumMonthlyDataModel({
    required super.month,
    required super.equity,
    required super.debt,
    required super.hybrid,
    required super.alternate,
    required super.equityValue,
    required super.debtValue,
    required super.hybridValue,
    required super.alternateValue,
    required super.equityPercentage,
    required super.debtPercentage,
    required super.hybridPercentage,
    required super.alternatePercentage,
  });

  factory AumMonthlyDataModel.fromJson(Map<String, dynamic> json) {
    return AumMonthlyDataModel(
      month: json['month'],
      equity: json['Equity']?.toDouble() ?? 0,
      debt: json['Debt']?.toDouble() ?? 0,
      hybrid: json['Hybrid']?.toDouble() ?? 0,
      alternate: json['Alternate']?.toDouble() ?? 0,
      equityValue: json['equity_value']?.toDouble() ?? 0,
      debtValue: json['debt_value']?.toDouble() ?? 0,
      hybridValue: json['hybrid_value']?.toDouble() ?? 0,
      alternateValue: json['alternate_value']?.toDouble() ?? 0,
      equityPercentage: json['equity_percentage']?.toDouble() ?? 0,
      debtPercentage: json['debt_percentage']?.toDouble() ?? 0,
      hybridPercentage: json['hybrid_percentage']?.toDouble() ?? 0,
      alternatePercentage: json['alternate_percentage']?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'Equity': equity,
      'Debt': debt,
      'Hybrid': hybrid,
      'Alternate': alternate,
      'equity_value': equityValue,
      'debt_value': debtValue,
      'hybrid_value': hybridValue,
      'alternate_value': alternateValue,
      'equity_percentage': equityPercentage,
      'debt_percentage': debtPercentage,
      'hybrid_percentage': hybridPercentage,
      'alternate_percentage': alternatePercentage,
    };
  }
}
