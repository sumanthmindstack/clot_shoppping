import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/account_summary_data_entity.dart';
import '../entity/params/account_summary_data_params.dart';
import '../repository/invester_repo.dart';

@injectable
class AccountSummaryDataUsecase
    implements Usecase<AccountSummaryDataEntity, AccountSummaryDataParams> {
  final InvesterRepo _investerRepo;

  AccountSummaryDataUsecase(this._investerRepo);

  @override
  Future<Either<AppError, AccountSummaryDataEntity>> call(
      AccountSummaryDataParams params) async {
    return await _investerRepo.accountSummaryData(params.toJson());
  }
}
