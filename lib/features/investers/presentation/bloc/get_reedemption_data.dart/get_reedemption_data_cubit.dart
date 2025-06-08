import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_redeemption_data_entity.dart';
import '../../../domain/entity/params/get_lumpsum_data_params.dart';
import '../../../domain/usecase/get_redeemption_data_usecase.dart';

part 'get_reedemption_data_state.dart';

@injectable
class GetRedeemDataCubit extends Cubit<GetRedeemDataState> {
  final GetRedeemDataUsecase _getRedeemDataUseCase;

  GetRedeemDataCubit(this._getRedeemDataUseCase)
      : super(GetRedeemDataInitialState());

  void fetchRedeemData({
    required int userId,
    required int limit,
    required int page,
    required String type,
  }) async {
    emit(GetRedeemDataLoadingState());

    final params = GetLumpsumDataParams(
      limit: limit,
      page: page,
      userId: userId,
      type: type,
    );

    final response = await _getRedeemDataUseCase(params);

    response.fold(
      (l) => emit(
        GetRedeemDataFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetRedeemDataSuccessState(r)),
    );
  }
}
