import '../../domain/entities/register_user_entity.dart';

class RegisterUserResponseModel extends RegisterUserEntity {
  const RegisterUserResponseModel({
    super.id,
    super.email,
    super.mobile,
    super.type,
    super.userType,
    super.file1,
    super.file2,
    super.createdAt,
    super.updatedAt,
  });

  factory RegisterUserResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserResponseModel(
      id: json['id'] as int?,
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      type: json['type'] as String?,
      userType: json['user_type'] as String?,
      file1: json['file1'] as String?,
      file2: json['file2'] as String?,
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
      'id': id,
      'email': email,
      'mobile': mobile,
      'type': type,
      'user_type': userType,
      'file1': file1,
      'file2': file2,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
