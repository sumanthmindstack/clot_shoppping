import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/params/add_new_bank_params.dart';
import '../repository/invester_repo.dart';

@injectable
class AddNewBankUsecase implements Usecase<dynamic, AddNewBankParams> {
  final InvesterRepo _investerRepo;

  AddNewBankUsecase(this._investerRepo);

  @override
  Future<Either<AppError, dynamic>> call(AddNewBankParams params) async {
    return await _investerRepo.addNewBank(params.toJson());
  }
}
