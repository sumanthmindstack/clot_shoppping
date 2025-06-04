import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/get_kyc_user_list_entity.dart';
import '../entity/params/get_kyc_user_list_params.dart';
import '../repository/invester_repo.dart';

@injectable
class GetKycUserListUseCase
    implements Usecase<GetKycUserListEntity, GetKycUserListParams> {
  final InvesterRepo _investerRepo;

  GetKycUserListUseCase(this._investerRepo);

  @override
  Future<Either<AppError, GetKycUserListEntity>> call(
      GetKycUserListParams params) async {
    return await _investerRepo.getKycUserList(params.toJson());
  }
}
