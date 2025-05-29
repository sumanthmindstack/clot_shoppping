import 'dart:io';
import 'package:dio/dio.dart';

class RegisterUserParams {
  final String email;
  final String mobile;
  final String type;
  final String userType;
  final File file1;
  final File? file2;

  RegisterUserParams({
    required this.email,
    required this.mobile,
    required this.type,
    required this.userType,
    required this.file1,
    this.file2,
  });

  Future<FormData> toFormData() async {
    final List<MultipartFile> files = [
      await MultipartFile.fromFile(file1.path, filename: 'file1'),
      if (file2 != null)
        await MultipartFile.fromFile(file2!.path, filename: 'file2'),
    ];

    return FormData.fromMap({
      'email': email,
      'mobile': mobile,
      'type': type,
      'user_type': userType,
      'files': files,
    });
  }
}
