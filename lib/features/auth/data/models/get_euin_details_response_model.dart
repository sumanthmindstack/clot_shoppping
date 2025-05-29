import '../../domain/entities/get_euin_details_entity.dart';

class GetEuinDetailsResponseModel extends GetEuinDetailsEntity {
  GetEuinDetailsResponseModel({required List<EuinDetailsModel> euin})
      : super(euin: euin);

  factory GetEuinDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetEuinDetailsResponseModel(
      euin: (json['euin'] as List<dynamic>?)
              ?.map((e) => EuinDetailsModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'euin': euin.map((e) => (e as EuinDetailsModel).toJson()).toList(),
    };
  }
}

class EuinDetailsModel extends EuinDetailsEntity {
  EuinDetailsModel({
    required super.id,
    required super.userId,
    required super.mfdId,
    required super.euinCode,
    required super.euinFrom,
    required super.euinTo,
    required super.createdAt,
    required super.updatedAt,
  });

  factory EuinDetailsModel.fromJson(Map<String, dynamic> json) {
    return EuinDetailsModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      mfdId: json['mfd_id'] ?? 0,
      euinCode: json['euin_code'] ?? '',
      euinFrom: json['euin_from'] ?? '',
      euinTo: json['euin_to'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'mfd_id': mfdId,
      'euin_code': euinCode,
      'euin_from': euinFrom,
      'euin_to': euinTo,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
