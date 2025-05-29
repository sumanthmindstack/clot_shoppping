import '../../domain/entities/trans_typewise_returns_entity.dart';

class TransTypewiseReturnModel extends TransTypewiseReturnEntity {
  const TransTypewiseReturnModel({
    required super.type,
    required super.count,
    required super.total,
  });

  factory TransTypewiseReturnModel.fromJson(Map<String, dynamic> json) {
    return TransTypewiseReturnModel(
      type: json['type'] ?? '',
      count: int.tryParse(json['count'].toString()) ?? 0,
      total: double.tryParse(json['total'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'count': count.toString(),
      'total': total.toStringAsFixed(4),
    };
  }
}

class MetaModel extends MetaEntity {
  const MetaModel({
    required super.total,
    required super.totalPages,
    required super.currentPage,
    required super.perPage,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      total: int.tryParse(json['total'].toString()) ?? 0,
      totalPages: int.tryParse(json['totalPages'].toString()) ?? 0,
      currentPage: int.tryParse(json['currentPage'].toString()) ?? 0,
      perPage: int.tryParse(json['perPage'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total.toString(),
      'totalPages': totalPages.toString(),
      'currentPage': currentPage.toString(),
      'perPage': perPage.toString(),
    };
  }
}

class TransTypewiseReturnsResponseModel
    extends TransTypewiseReturnsResponseEntity {
  const TransTypewiseReturnsResponseModel({
    required super.data,
    required super.excelDownloadLink,
    required super.meta,
  });

  factory TransTypewiseReturnsResponseModel.fromJson(
      Map<String, dynamic> json) {
    return TransTypewiseReturnsResponseModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => TransTypewiseReturnModel.fromJson(e))
          .toList(),
      excelDownloadLink: json['excelDownloadLink'] ?? '',
      meta: MetaModel.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data':
          data.map((e) => (e as TransTypewiseReturnModel).toJson()).toList(),
      'excelDownloadLink': excelDownloadLink,
      'meta': (meta as MetaModel).toJson(),
    };
  }
}
