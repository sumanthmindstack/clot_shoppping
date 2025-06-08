import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_redeemption_data_entity.dart';
import '../entity/params/get_lumpsum_data_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetRedeemDataUsecase
    implements Usecase<GetRedeemptionDataEntity, GetLumpsumDataParams> {
  final InvesterRepo _investerRepo;

  GetRedeemDataUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetRedeemptionDataEntity>> call(
      GetLumpsumDataParams params) async {
    return await _investerRepo.getRedeemData(params.toJson());
  }
}
