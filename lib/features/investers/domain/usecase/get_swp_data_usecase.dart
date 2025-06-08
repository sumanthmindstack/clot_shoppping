import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_swp_data_entity.dart';
import '../entity/params/get_lumpsum_data_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetSwpDataUsecase
    implements Usecase<GetSwpDataEntity, GetLumpsumDataParams> {
  final InvesterRepo _investerRepo;

  GetSwpDataUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetSwpDataEntity>> call(
      GetLumpsumDataParams params) async {
    return await _investerRepo.getSwpData(params.toJson());
  }
}
