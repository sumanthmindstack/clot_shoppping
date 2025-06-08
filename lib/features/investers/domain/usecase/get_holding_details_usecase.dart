import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_holding_details_entity.dart';
import '../entity/params/get_holding_details_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetHoldingsDetailsUsecase
    implements Usecase<GetHoldingDetailsEntity, GetHoldingDetailsParams> {
  final InvesterRepo _investerRepo;

  GetHoldingsDetailsUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetHoldingDetailsEntity>> call(
      GetHoldingDetailsParams params) async {
    return await _investerRepo.getHoldingsDetailsData(params.toJson());
  }
}
