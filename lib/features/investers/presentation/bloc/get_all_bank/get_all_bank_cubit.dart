import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/params/edit_invester_details_params.dart';
import '../../../domain/usecase/get_all_bank_usecase.dart';

part 'get_all_bank_state.dart';

@injectable
class GetAllBankCubit extends Cubit<GetAllBankState> {
  final GetAllBankUsecase _getAllBankUsecase;

  GetAllBankCubit(this._getAllBankUsecase) : super(GetAllBankInitialState());

  void fetchAllBanks({required int userId}) async {
    emit(GetAllBankLoadingState());

    final params = EditInvesterDetailsParams(userId: userId);

    final response = await _getAllBankUsecase(params);

    response.fold(
      (l) => emit(
        GetAllBankFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(const GetAllBankSuccessState()),
    );
  }
}
