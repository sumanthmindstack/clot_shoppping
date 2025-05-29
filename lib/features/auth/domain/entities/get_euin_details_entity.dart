class GetEuinDetailsEntity {
  final List<EuinDetailsEntity> euin;

  GetEuinDetailsEntity({required this.euin});
}

class EuinDetailsEntity {
  final int id;
  final int userId;
  final int mfdId;
  final String euinCode;
  final String euinFrom;
  final String euinTo;
  final String createdAt;
  final String updatedAt;

  EuinDetailsEntity({
    required this.id,
    required this.userId,
    required this.mfdId,
    required this.euinCode,
    required this.euinFrom,
    required this.euinTo,
    required this.createdAt,
    required this.updatedAt,
  });
}
