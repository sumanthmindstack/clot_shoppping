import '../../domain/entities/dash_monthwise_sip_details_graph_entity.dart';

class DashMonthwiseSipDetailsGraphModel
    extends DashMonthwiseSipDetailsGraphEntity {
  const DashMonthwiseSipDetailsGraphModel({
    required super.status,
    required super.year,
    required super.data,
    required super.meta,
  });

  factory DashMonthwiseSipDetailsGraphModel.fromJson(
      Map<String, dynamic> json) {
    return DashMonthwiseSipDetailsGraphModel(
      status: json['status'],
      year: json['year'],
      data: (json['data'] as List)
          .map((e) => MonthwiseSipDataModel.fromJson(e))
          .toList(),
      meta: SipMetaModel.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'year': year,
      'data': data.map((e) => (e as MonthwiseSipDataModel).toJson()).toList(),
      'meta': (meta as SipMetaModel).toJson(),
    };
  }
}

class MonthwiseSipDataModel extends MonthwiseSipDataEntity {
  const MonthwiseSipDataModel({
    required super.month,
    super.totalSipCount,
    super.totalSipAmount,
  });

  factory MonthwiseSipDataModel.fromJson(Map<String, dynamic> json) {
    return MonthwiseSipDataModel(
      month: json['month'],
      totalSipCount: json['total_sip_count'] != null
          ? int.tryParse(json['total_sip_count'].toString())
          : null,
      totalSipAmount: json['total_sip_amount'] != null
          ? double.tryParse(json['total_sip_amount'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      if (totalSipCount != null) 'total_sip_count': totalSipCount,
      if (totalSipAmount != null)
        'total_sip_amount': totalSipAmount!.toStringAsFixed(2),
    };
  }
}

class SipMetaModel extends SipMetaEntity {
  const SipMetaModel({
    required super.total,
    required super.type,
  });

  factory SipMetaModel.fromJson(Map<String, dynamic> json) {
    return SipMetaModel(
      total: json['total'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'type': type,
    };
  }
}
