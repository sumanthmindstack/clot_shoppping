import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_stp_data_entity.dart';
import '../entity/params/get_lumpsum_data_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetStpDataUsecase
    implements Usecase<GetStpDataEntity, GetLumpsumDataParams> {
  final InvesterRepo _investerRepo;

  GetStpDataUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetStpDataEntity>> call(
      GetLumpsumDataParams params) async {
    return await _investerRepo.getStpData(params.toJson());
  }
}
