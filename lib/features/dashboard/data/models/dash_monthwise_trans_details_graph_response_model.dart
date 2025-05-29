import '../../domain/entities/dash_monthwise_trans_details_graph_entity.dart';

class DashMonthwiseTransDetailsGraphModel
    extends DashMonthwiseTransDetailsGraphEntity {
  const DashMonthwiseTransDetailsGraphModel({
    required super.result,
    required super.totalCount,
    required super.excelLink,
  });

  factory DashMonthwiseTransDetailsGraphModel.fromJson(
      Map<String, dynamic> json) {
    return DashMonthwiseTransDetailsGraphModel(
      result: (json['result'] as List)
          .map((e) => MonthwiseTransDataModel.fromJson(e))
          .toList(),
      totalCount: json['totalCount'],
      excelLink: json['excelLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result':
          result.map((e) => (e as MonthwiseTransDataModel).toJson()).toList(),
      'totalCount': totalCount,
      'excelLink': excelLink,
    };
  }
}

class MonthwiseTransDataModel extends MonthwiseTransDataEntity {
  const MonthwiseTransDataModel({
    required super.month,
    required super.transactionCount,
    required super.totalAmount,
  });

  factory MonthwiseTransDataModel.fromJson(Map<String, dynamic> json) {
    return MonthwiseTransDataModel(
      month: json['month'],
      transactionCount: int.tryParse(json['transaction_count'].toString()) ?? 0,
      totalAmount: double.tryParse(json['total_amount'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'transaction_count': transactionCount.toString(),
      'total_amount': totalAmount.toStringAsFixed(4),
    };
  }
}
