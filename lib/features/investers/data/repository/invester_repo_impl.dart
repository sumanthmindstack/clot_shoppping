import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_call_with_error.dart';
import '../../../../core/entities/app_error.dart';
import '../../domain/repository/invester_repo.dart';
import '../data_source/invester_api_service.dart';
import '../models/get_invester_list_response_model.dart';

@LazySingleton(as: InvesterRepo)
class InvesterRepoImpl implements InvesterRepo {
  final InvesterApiService _investerApiService;
  InvesterRepoImpl(this._investerApiService);
  @override
  Future<Either<AppError, GetInvesterListResponseModel>> getInvestersList(
      Map<String, dynamic> params) {
    return ApiCallWithError.call(
      () async {
        final GetInvesterListResponseModel dashboardDatacountResponseModel =
            await _investerApiService.getInvestersList(params);
        return dashboardDatacountResponseModel;
      },
    );
  }
}
