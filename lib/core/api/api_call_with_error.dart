import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:maxwealth_distributor_app/core/entities/app_error.dart';
import 'package:maxwealth_distributor_app/core/entities/custom_exception.dart';
import 'package:maxwealth_distributor_app/core/entities/unauthorised_exception.dart';

class ApiCallWithError {
  const ApiCallWithError._();

  static Future<Either<AppError, T>> call<T>(Future<T> Function() f) async {
    try {
      return Right(await f());
    } on SocketException {
      return const Left(
          AppError(AppErrorType.network, error: 'Internet Connection issue !'));
    } on TimeoutException {
      return const Left(AppError(AppErrorType.timeout));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.authorisation,
          error: 'Session expired ! please login again.', statusCode: 401));
    } on CustomException catch (e) {
      return Left(AppError(AppErrorType.api,
          error: e.errorMessage, statusCode: e.errorCode));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
