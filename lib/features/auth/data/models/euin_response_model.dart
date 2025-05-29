import '../../domain/entities/euin_entity.dart';

class EuinResponseModel extends EuinEntity {
  EuinResponseModel({
    required super.euinCode,
    required super.euinFrom,
    required super.euinTo,
    required super.userId,
    required super.mfdId,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory EuinResponseModel.fromJson(Map<String, dynamic> json) {
    return EuinResponseModel(
      euinCode: json['euin_code'] ?? '',
      euinFrom: json['euin_from'] ?? '',
      euinTo: json['euin_to'] ?? '',
      userId: json['user_id'] ?? 0,
      mfdId: json['mfd_id'] ?? 0,
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'euin_code': euinCode,
      'euin_from': euinFrom,
      'euin_to': euinTo,
      'user_id': userId,
      'mfd_id': mfdId,
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
