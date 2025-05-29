import 'package:equatable/equatable.dart';

class DashMonthwiseInvesterDetailsGraphEntity extends Equatable {
  final String year;
  final List<MonthwiseInvesterDataEntity> monthsData;

  const DashMonthwiseInvesterDetailsGraphEntity({
    required this.year,
    required this.monthsData,
  });

  @override
  List<Object?> get props => [year, monthsData];
}

class MonthwiseInvesterDataEntity extends Equatable {
  final int month;
  final int totalInvestors;

  const MonthwiseInvesterDataEntity({
    required this.month,
    required this.totalInvestors,
  });

  @override
  List<Object?> get props => [month, totalInvestors];
}
