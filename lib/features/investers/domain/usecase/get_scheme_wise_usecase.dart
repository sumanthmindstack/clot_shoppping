import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_scheme_wise_entity.dart';
import '../entity/params/account_summary_data_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetSchemeWiseUsecase
    implements Usecase<GetSchemeWiseEntity, AccountSummaryDataParams> {
  final InvesterRepo _investerRepo;

  GetSchemeWiseUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetSchemeWiseEntity>> call(
      AccountSummaryDataParams params) async {
    return await _investerRepo.getSchemeWise(params.toJson());
  }
}
