import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../entity/get_invester_list_entitty.dart';

abstract class InvesterRepo {
  Future<Either<AppError, GetInvesterListEntity>> getInvestersList(
      Map<String, dynamic> params);
}
