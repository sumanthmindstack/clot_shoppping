import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/params/verify_otp_params.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repo.dart';

@injectable
class VerifyOtpUsecase implements Usecase<dynamic, VerifyOtpParams> {
  final AuthRepo _authRepo;
  VerifyOtpUsecase(this._authRepo);

  @override
  Future<Either<AppError, dynamic>> call(VerifyOtpParams params) async {
    return await _authRepo.verifyOTP(params.toJson());
  }
}
