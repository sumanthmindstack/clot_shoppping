import 'package:equatable/equatable.dart';

class DashMonthwiseTransDetailsGraphEntity extends Equatable {
  final List<MonthwiseTransDataEntity> result;
  final int totalCount;
  final String excelLink;

  const DashMonthwiseTransDetailsGraphEntity({
    required this.result,
    required this.totalCount,
    required this.excelLink,
  });

  @override
  List<Object?> get props => [result, totalCount, excelLink];
}

class MonthwiseTransDataEntity extends Equatable {
  final String month;
  final int transactionCount;
  final double totalAmount;

  const MonthwiseTransDataEntity({
    required this.month,
    required this.transactionCount,
    required this.totalAmount,
  });

  @override
  List<Object?> get props => [month, transactionCount, totalAmount];
}
