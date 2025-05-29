import 'package:equatable/equatable.dart';

class RegisterUserEntity extends Equatable {
  final int? id;
  final String? email;
  final String? mobile;
  final String? type;
  final String? userType;
  final String? file1;
  final String? file2;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const RegisterUserEntity({
    this.id,
    this.email,
    this.mobile,
    this.type,
    this.userType,
    this.file1,
    this.file2,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        mobile,
        type,
        userType,
        file1,
        file2,
        createdAt,
        updatedAt,
      ];
}
