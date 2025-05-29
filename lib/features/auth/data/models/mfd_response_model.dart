import '../../domain/entities/mfd_entity.dart';

class MfdResponseModel extends MfdEntity {
  const MfdResponseModel({
    super.userId,
    super.id,
    super.createdAt,
    super.updatedAt,
  });

  factory MfdResponseModel.fromJson(Map<String, dynamic> json) {
    return MfdResponseModel(
      userId: json['user_id'] as String?,
      id: json['id'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
