import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_capital_gains_entity.dart';
import '../entity/params/account_summary_data_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetCapitalGainsUsecase
    implements Usecase<GetCapitalGainsEntity, AccountSummaryDataParams> {
  final InvesterRepo _investerRepo;

  GetCapitalGainsUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetCapitalGainsEntity>> call(
      AccountSummaryDataParams params) async {
    return await _investerRepo.getCapitalGains(params.toJson());
  }
}
