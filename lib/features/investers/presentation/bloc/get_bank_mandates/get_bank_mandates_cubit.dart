import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/entity/params/get_bank_mandates_params.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_bank_mandates_entity.dart';
import '../../../domain/usecase/get_bank_mandates_usecase.dart';

part 'get_bank_mandates_state.dart';

@injectable
class GetBankMandatesCubit extends Cubit<GetBankMandatesState> {
  final GetBankMandatesUsecase _getBankMandatesUsecase;

  GetBankMandatesCubit(this._getBankMandatesUsecase)
      : super(GetBankMandatesInitialState());

  void fetchBankMandates({
    required int userId,
    required int limit,
    required int page,
  }) async {
    emit(GetBankMandatesLoadingState());

    final params = GetBankMandatesParams(
      userId: userId,
      limit: limit,
      page: page,
    );

    final response = await _getBankMandatesUsecase(params);

    response.fold(
      (l) => emit(
        GetBankMandatesFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetBankMandatesSuccessState(r)),
    );
  }
}
