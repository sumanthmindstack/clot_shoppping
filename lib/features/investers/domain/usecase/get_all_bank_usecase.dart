import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/params/edit_invester_details_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetAllBankUsecase implements Usecase<dynamic, EditInvesterDetailsParams> {
  final InvesterRepo _investerRepo;

  GetAllBankUsecase(this._investerRepo);

  @override
  Future<Either<AppError, dynamic>> call(
      EditInvesterDetailsParams params) async {
    return await _investerRepo.getAllBank(params.toJson());
  }
}
