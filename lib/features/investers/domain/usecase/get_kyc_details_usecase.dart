import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_kyc_details_entity.dart';
import '../entity/params/get_kyc_details_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetKycDetailsUsecase
    implements Usecase<GetKycDetailsEntity, GetKycDetailsParams> {
  final InvesterRepo _investerRepo;

  GetKycDetailsUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetKycDetailsEntity>> call(
      GetKycDetailsParams params) async {
    return await _investerRepo.getKycDetails(params.toJson());
  }
}
