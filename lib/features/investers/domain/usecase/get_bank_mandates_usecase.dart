import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_bank_mandates_entity.dart';
import '../entity/params/get_bank_mandates_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetBankMandatesUsecase
    implements Usecase<GetBankMandatesEntity, GetBankMandatesParams> {
  final InvesterRepo _investerRepo;

  GetBankMandatesUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetBankMandatesEntity>> call(
      GetBankMandatesParams params) async {
    return await _investerRepo.getBankMandates(params.toJson());
  }
}
