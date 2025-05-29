import 'package:equatable/equatable.dart';

class DashMonthwiseSipDetailsGraphEntity extends Equatable {
  final int status;
  final String year;
  final List<MonthwiseSipDataEntity> data;
  final SipMetaEntity meta;

  const DashMonthwiseSipDetailsGraphEntity({
    required this.status,
    required this.year,
    required this.data,
    required this.meta,
  });

  @override
  List<Object?> get props => [status, year, data, meta];
}

class MonthwiseSipDataEntity extends Equatable {
  final String month;
  final int? totalSipCount;
  final double? totalSipAmount;

  const MonthwiseSipDataEntity({
    required this.month,
    this.totalSipCount,
    this.totalSipAmount,
  });

  @override
  List<Object?> get props => [month, totalSipCount, totalSipAmount];
}

class SipMetaEntity extends Equatable {
  final int total;
  final String type;

  const SipMetaEntity({
    required this.total,
    required this.type,
  });

  @override
  List<Object?> get props => [total, type];
}
