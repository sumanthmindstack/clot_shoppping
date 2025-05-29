class TransTypewiseReturnEntity {
  final String type;
  final int count;
  final double total;

  const TransTypewiseReturnEntity({
    required this.type,
    required this.count,
    required this.total,
  });
}

class MetaEntity {
  final int total;
  final int totalPages;
  final int currentPage;
  final int perPage;

  const MetaEntity({
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.perPage,
  });
}

class TransTypewiseReturnsResponseEntity {
  final List<TransTypewiseReturnEntity> data;
  final String excelDownloadLink;
  final MetaEntity meta;

  const TransTypewiseReturnsResponseEntity({
    required this.data,
    required this.excelDownloadLink,
    required this.meta,
  });
}
