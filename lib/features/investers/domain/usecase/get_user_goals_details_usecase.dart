import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/params/get_user_goals_details_params.dart';
import '../entity/user_goals_entity.dart';
import '../repository/invester_repo.dart';

@injectable
class GetUserGoalsDetailsUsecase
    implements Usecase<UserGoalsEntity, GetUserGoalsDetailsParams> {
  final InvesterRepo _investerRepo;

  GetUserGoalsDetailsUsecase(this._investerRepo);

  @override
  Future<Either<AppError, UserGoalsEntity>> call(
      GetUserGoalsDetailsParams params) async {
    return await _investerRepo.getUserGoalsDetailsData(params.toJson());
  }
}
