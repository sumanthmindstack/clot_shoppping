import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/entities/no_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/trans_typewise_returns_entity.dart';
import '../repository/home_dash_repo.dart';

@injectable
class TransTypewiseReturnsUsecase
    implements Usecase<TransTypewiseReturnsResponseEntity, NoParams> {
  final HomeDashRepo _homeDashRepo;

  TransTypewiseReturnsUsecase(this._homeDashRepo);

  @override
  Future<Either<AppError, TransTypewiseReturnsResponseEntity>> call(
      NoParams noParams) async {
    return await _homeDashRepo.transTypewiseReturns();
  }
}
