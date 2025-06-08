import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_transaction_details_entity.dart';
import '../entity/params/get_transaction_details_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetTransactionDetailsUsecase
    implements
        Usecase<GetTransactionDetailsEntity, GetTransactionDetailsParams> {
  final InvesterRepo _investerRepo;

  GetTransactionDetailsUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetTransactionDetailsEntity>> call(
      GetTransactionDetailsParams params) async {
    return await _investerRepo.getTransactionDetailsData(params.toJson());
  }
}
