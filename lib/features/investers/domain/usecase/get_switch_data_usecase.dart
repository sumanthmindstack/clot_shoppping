import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_switch_data_entity.dart';
import '../entity/params/get_lumpsum_data_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetSwitchDataUsecase
    implements Usecase<GetSwitchDataEntity, GetLumpsumDataParams> {
  final InvesterRepo _investerRepo;

  GetSwitchDataUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetSwitchDataEntity>> call(
      GetLumpsumDataParams params) async {
    return await _investerRepo.getSwitchData(params.toJson());
  }
}
