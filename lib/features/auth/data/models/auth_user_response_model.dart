import '../../domain/entities/auth_user_entity.dart';

class AuthUserResponseModel extends AuthUserEntity {
  const AuthUserResponseModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.role,
  });

  factory AuthUserResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthUserResponseModel(
      id: json['id'],
      email: json['email'],
      fullName: json['full_name'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': role,
    };
  }
}
