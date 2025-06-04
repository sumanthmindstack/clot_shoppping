import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/entity/investor_profile_data_entity.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/params/investor_profile_data_params.dart';
import '../repository/invester_repo.dart';

@injectable
class InvesterProfileDataUsecase
    implements
        Usecase<List<InvestorProfileDataEntity>, InvestorProfileDataParams> {
  final InvesterRepo _investerRepo;

  InvesterProfileDataUsecase(this._investerRepo);

  @override
  Future<Either<AppError, List<InvestorProfileDataEntity>>> call(
      InvestorProfileDataParams params) async {
    return await _investerRepo.investerProfileData(params.toJson());
  }
}
