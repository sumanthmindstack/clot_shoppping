// dashboard_data_count_entity.dart

import 'package:equatable/equatable.dart';

class DashboardDatacountEntity extends Equatable {
  final int status;
  final DashboardDataEntity data;

  const DashboardDatacountEntity({
    required this.status,
    required this.data,
  });

  @override
  List<Object?> get props => [status, data];
}

class DashboardDataEntity extends Equatable {
  final AumReportEntity aumReportDto;
  final int totalUsers;
  final int totalInvestors;

  const DashboardDataEntity({
    required this.aumReportDto,
    required this.totalUsers,
    required this.totalInvestors,
  });

  @override
  List<Object?> get props => [aumReportDto, totalUsers, totalInvestors];
}

class AumReportEntity extends Equatable {
  final double equityValue;
  final double debtValue;
  final double hybridValue;
  final double alternateValue;
  final double equityPercentage;
  final double debtPercentage;
  final double hybridPercentage;
  final double alternatePercentage;

  const AumReportEntity({
    required this.equityValue,
    required this.debtValue,
    required this.hybridValue,
    required this.alternateValue,
    required this.equityPercentage,
    required this.debtPercentage,
    required this.hybridPercentage,
    required this.alternatePercentage,
  });

  @override
  List<Object?> get props => [
        equityValue,
        debtValue,
        hybridValue,
        alternateValue,
        equityPercentage,
        debtPercentage,
        hybridPercentage,
        alternatePercentage,
      ];
}
