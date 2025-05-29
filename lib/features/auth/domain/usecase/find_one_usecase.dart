import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/find_one_entity.dart';
import '../entities/params/find_one_params.dart';
import '../repository/auth_repo.dart';

@injectable
class FindOneUsecase implements Usecase<FindOneEntity, FindOneParams> {
  final AuthRepo _authRepo;

  FindOneUsecase(this._authRepo);

  @override
  Future<Either<AppError, FindOneEntity>> call(FindOneParams params) async {
    return await _authRepo.findOne(params.toJson());
  }
}
