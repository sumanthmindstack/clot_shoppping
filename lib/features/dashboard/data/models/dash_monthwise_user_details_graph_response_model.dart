import '../../domain/entities/dash_monthwise_user_details_graph_entity.dart';

class DashMonthwiseUserDetailsGraphModel
    extends DashMonthwiseUserDetailsGraphEntity {
  const DashMonthwiseUserDetailsGraphModel({
    required super.year,
    required List<MonthwiseUserDataModel> monthsData,
  }) : super(monthsData: monthsData);

  factory DashMonthwiseUserDetailsGraphModel.fromJson(
      Map<String, dynamic> json) {
    return DashMonthwiseUserDetailsGraphModel(
      year: json['year'],
      monthsData: (json['monthsData'] as List)
          .map((e) => MonthwiseUserDataModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'monthsData': monthsData
          .map((e) => (e as MonthwiseUserDataModel).toJson())
          .toList(),
    };
  }
}

class MonthwiseUserDataModel extends MonthwiseUserDataEntity {
  const MonthwiseUserDataModel({
    required super.month,
    required super.totalInvestors,
  });

  factory MonthwiseUserDataModel.fromJson(Map<String, dynamic> json) {
    return MonthwiseUserDataModel(
      month: json['month'],
      totalInvestors: json['total_investors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'total_investors': totalInvestors,
    };
  }
}
