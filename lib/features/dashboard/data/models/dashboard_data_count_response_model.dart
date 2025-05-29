// dashboard_data_count_response_model.dart

import '../../domain/entities/dashboard_data_count_entity.dart';

class DashboardDatacountResponseModel extends DashboardDatacountEntity {
  const DashboardDatacountResponseModel({
    required super.status,
    required DashboardDataModel data,
  }) : super(data: data);

  factory DashboardDatacountResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardDatacountResponseModel(
      status: json['status'],
      data: DashboardDataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': (data as DashboardDataModel).toJson(),
    };
  }
}

class DashboardDataModel extends DashboardDataEntity {
  const DashboardDataModel({
    required AumReportModel aumReportDto,
    required super.totalUsers,
    required super.totalInvestors,
  }) : super(aumReportDto: aumReportDto);

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      aumReportDto: AumReportModel.fromJson(json['aum_report_dto']),
      totalUsers: json['total_users'],
      totalInvestors: json['total_investors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aum_report_dto': (aumReportDto as AumReportModel).toJson(),
      'total_users': totalUsers,
      'total_investors': totalInvestors,
    };
  }
}

class AumReportModel extends AumReportEntity {
  const AumReportModel({
    required super.equityValue,
    required super.debtValue,
    required super.hybridValue,
    required super.alternateValue,
    required super.equityPercentage,
    required super.debtPercentage,
    required super.hybridPercentage,
    required super.alternatePercentage,
  });

  factory AumReportModel.fromJson(Map<String, dynamic> json) {
    return AumReportModel(
      equityValue: (json['equity_value'] as num).toDouble(),
      debtValue: (json['debt_value'] as num).toDouble(),
      hybridValue: (json['hybrid_value'] as num).toDouble(),
      alternateValue: (json['alternate_value'] as num).toDouble(),
      equityPercentage: (json['equity_percentage'] as num).toDouble(),
      debtPercentage: (json['debt_percentage'] as num).toDouble(),
      hybridPercentage: (json['hybrid_percentage'] as num).toDouble(),
      alternatePercentage: (json['alternate_percentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
