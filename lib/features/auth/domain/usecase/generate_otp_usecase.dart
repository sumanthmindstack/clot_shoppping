import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/core/entities/app_error.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/repository/auth_repo.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/params/generate_otp_params.dart';

@injectable
class GenerateOtpUsecase implements Usecase<dynamic, GenerateOtpParams> {
  final AuthRepo _authRepo;
  GenerateOtpUsecase(this._authRepo);

  @override
  Future<Either<AppError, dynamic>> call(GenerateOtpParams params) async {
    return await _authRepo.generateOTP(params.toJson());
  }
}
