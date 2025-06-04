import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/account_summary_data_entity.dart';
import '../../../domain/entity/params/account_summary_data_params.dart';
import '../../../domain/usecase/account_summary_data_usecase.dart';

part 'account_summary_data_state.dart';

@injectable
class AccountSummaryDataCubit extends Cubit<AccountSummaryDataState> {
  final AccountSummaryDataUsecase _usecase;

  AccountSummaryDataCubit(this._usecase)
      : super(AccountSummaryDataInitialState());

  void getAccountSummaryData({
    required int page,
    required int userId,
    required int limit,
  }) async {
    emit(AccountSummaryDataLoadingState());

    final params = AccountSummaryDataParams(
      page: page,
      userId: userId,
      limit: limit,
    );

    final response = await _usecase(params);

    response.fold(
      (l) => emit(
        AccountSummaryDataFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(AccountSummaryDataSuccessState(r)),
    );
  }
}
