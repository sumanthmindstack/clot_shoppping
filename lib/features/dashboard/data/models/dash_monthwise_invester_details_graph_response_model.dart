import '../../domain/entities/dash_monthwise_invester_details_graph_entity.dart';

class DashMonthwiseInvesterDetailsGraphModel
    extends DashMonthwiseInvesterDetailsGraphEntity {
  const DashMonthwiseInvesterDetailsGraphModel({
    required super.year,
    required List<MonthwiseInvesterDataModel> monthsData,
  }) : super(monthsData: monthsData);

  factory DashMonthwiseInvesterDetailsGraphModel.fromJson(
      Map<String, dynamic> json) {
    return DashMonthwiseInvesterDetailsGraphModel(
      year: json['year'],
      monthsData: (json['monthsData'] as List)
          .map((e) => MonthwiseInvesterDataModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'monthsData': monthsData
          .map((e) => (e as MonthwiseInvesterDataModel).toJson())
          .toList(),
    };
  }
}

class MonthwiseInvesterDataModel extends MonthwiseInvesterDataEntity {
  const MonthwiseInvesterDataModel({
    required super.month,
    required super.totalInvestors,
  });

  factory MonthwiseInvesterDataModel.fromJson(Map<String, dynamic> json) {
    return MonthwiseInvesterDataModel(
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
