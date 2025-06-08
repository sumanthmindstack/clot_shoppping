import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/entity/get_sip_data_entity.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/params/get_lumpsum_data_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetSipDataUsecase
    implements Usecase<GetSipDataEntity, GetLumpsumDataParams> {
  final InvesterRepo _investerRepo;

  GetSipDataUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetSipDataEntity>> call(
      GetLumpsumDataParams params) async {
    return await _investerRepo.getSipData(params.toJson());
  }
}
