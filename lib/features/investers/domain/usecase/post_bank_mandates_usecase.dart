import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_bank_mandates_entity.dart';
import '../entity/params/post_bank_mandates_params.dart';
import '../repository/invester_repo.dart';

@injectable
class PostBankMandatesUsecase
    implements Usecase<GetBankMandatesEntity, PostBankMandatesParams> {
  final InvesterRepo _investerRepo;

  PostBankMandatesUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetBankMandatesEntity>> call(
      PostBankMandatesParams params) async {
    return await _investerRepo.postBankMandates(params.toJson());
  }
}
