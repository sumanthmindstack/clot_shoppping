import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_scheme_wise_entity.dart';
import '../../../domain/usecase/get_scheme_wise_usecase.dart';
import '../../../domain/entity/params/account_summary_data_params.dart';

part 'get_scheme_wise_state.dart';

@injectable
class GetSchemeWiseCubit extends Cubit<GetSchemeWiseState> {
  final GetSchemeWiseUsecase _getSchemeWiseUsecase;

  GetSchemeWiseCubit(this._getSchemeWiseUsecase)
      : super(GetSchemeWiseInitialState());

  void fetchSchemeWise({
    required int userId,
    required int page,
    required int limit,
  }) async {
    emit(GetSchemeWiseLoadingState());

    final params = AccountSummaryDataParams(
      userId: userId,
      page: page,
      limit: limit,
    );

    final response = await _getSchemeWiseUsecase(params);

    response.fold(
      (l) => emit(
        GetSchemeWiseFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetSchemeWiseSuccessState(r)),
    );
  }
}
