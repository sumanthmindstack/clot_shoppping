import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/entity/get_invester_list_entitty.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/repository/invester_repo.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/params/get_invester_list_params.dart';

@injectable
class GetInvesterListUsecase
    implements Usecase<GetInvesterListEntity, GetInvesterListParams> {
  final InvesterRepo _investerRepo;

  GetInvesterListUsecase(this._investerRepo);

  @override
  Future<Either<AppError, GetInvesterListEntity>> call(
      GetInvesterListParams params) async {
    return await _investerRepo.getInvestersList(params.toJson());
  }
}
