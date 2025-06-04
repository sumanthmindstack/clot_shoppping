import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/check_kyc_entity.dart';
import '../entity/params/check_kyc_params.dart';
import '../repository/invester_repo.dart';

@injectable
class CheckKycUsecase implements Usecase<CheckKycEntity, CheckKycParams> {
  final InvesterRepo _kycRepo;

  CheckKycUsecase(this._kycRepo);

  @override
  Future<Either<AppError, CheckKycEntity>> call(CheckKycParams params) async {
    return await _kycRepo.checkKyc(params.toJson());
  }
}
