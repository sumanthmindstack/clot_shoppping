import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_lumpsum_data_entity.dart';
import '../entity/params/get_lumpsum_data_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetLumpsumDataUsecase
    implements Usecase<GetLumpsumDataEntity, GetLumpsumDataParams> {
  final InvesterRepo _investerRepo;

  GetLumpsumDataUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetLumpsumDataEntity>> call(
      GetLumpsumDataParams params) async {
    return await _investerRepo.getLumpsumData(params.toJson());
  }
}
