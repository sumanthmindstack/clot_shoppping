import 'package:equatable/equatable.dart';

class DashMonthwiseUserDetailsGraphEntity extends Equatable {
  final String year;
  final List<MonthwiseUserDataEntity> monthsData;

  const DashMonthwiseUserDetailsGraphEntity({
    required this.year,
    required this.monthsData,
  });

  @override
  List<Object?> get props => [year, monthsData];
}

class MonthwiseUserDataEntity extends Equatable {
  final int month;
  final int totalInvestors;

  const MonthwiseUserDataEntity({
    required this.month,
    required this.totalInvestors,
  });

  @override
  List<Object?> get props => [month, totalInvestors];
}
