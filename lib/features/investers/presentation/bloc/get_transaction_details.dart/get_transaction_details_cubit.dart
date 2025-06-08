import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_transaction_details_entity.dart';
import '../../../domain/entity/params/get_transaction_details_params.dart';
import '../../../domain/usecase/get_transaction_details_usecase.dart';

part 'get_transaction_details_state.dart';

@injectable
class GetTransactionDetailsCubit extends Cubit<GetTransactionDetailsState> {
  final GetTransactionDetailsUsecase _getTransactionDetailsUsecase;

  GetTransactionDetailsCubit(this._getTransactionDetailsUsecase)
      : super(GetTransactionDetailsInitialState());

  void fetchTransactionDetails({
    required int transactionBasketItemId,
  }) async {
    emit(GetTransactionDetailsLoadingState());

    final params = GetTransactionDetailsParams(
      transactionBasketItemId: transactionBasketItemId,
    );

    final response = await _getTransactionDetailsUsecase(params);

    response.fold(
      (l) => emit(
        GetTransactionDetailsFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetTransactionDetailsSuccessState(r)),
    );
  }
}
