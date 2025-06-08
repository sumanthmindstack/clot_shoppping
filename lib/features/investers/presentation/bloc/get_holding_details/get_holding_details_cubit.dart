import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/entity/params/get_holding_details_params.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_holding_details_entity.dart';
import '../../../domain/usecase/get_holding_details_usecase.dart';

part 'get_holding_details_state.dart';

@injectable
class GetHoldingDetailsCubit extends Cubit<GetHoldingDetailsState> {
  final GetHoldingsDetailsUsecase _getHoldingDetailsUsecase;

  GetHoldingDetailsCubit(this._getHoldingDetailsUsecase)
      : super(GetHoldingDetailsInitialState());

  void fetchHoldingDetails({
    required int userId,
    required int limit,
    required int page,
  }) async {
    emit(GetHoldingDetailsLoadingState());

    final params =
        GetHoldingDetailsParams(limit: limit, page: page, userId: userId);

    final response = await _getHoldingDetailsUsecase(params);

    response.fold(
      (l) => emit(
        GetHoldingDetailsFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetHoldingDetailsSuccessState(r)),
    );
  }
}
