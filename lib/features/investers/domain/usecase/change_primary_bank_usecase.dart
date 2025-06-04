import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/params/change_primary_bank_params.dart';
import '../repository/invester_repo.dart';

@injectable
class ChangePrimaryBankUsecase
    implements Usecase<dynamic, ChangePrimaryBankParams> {
  final InvesterRepo _investerRepo;

  ChangePrimaryBankUsecase(this._investerRepo);

  @override
  Future<Either<AppError, dynamic>> call(ChangePrimaryBankParams params) async {
    return await _investerRepo.changePrimaryBank(params.toJson());
  }
}
