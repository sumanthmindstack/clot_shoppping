import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/investor_profile_data_entity.dart';
import '../../../domain/entity/params/investor_profile_data_params.dart';
import '../../../domain/usecase/investor_profile_usecase.dart';

part 'investor_profile_data_state.dart';

@injectable
class InvesterProfileDataCubit extends Cubit<InvesterProfileDataState> {
  final InvesterProfileDataUsecase _investorProfileDataUsecase;

  InvesterProfileDataCubit(this._investorProfileDataUsecase)
      : super(InvesterProfileDataInitialState());

  void fetchInvestorProfileData(
      {required InvestorProfileDataParams params}) async {
    emit(InvesterProfileDataLoadingState());

    final response = await _investorProfileDataUsecase(params);

    response.fold(
      (l) => emit(
        InvesterProfileDataFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(InvesterProfileDataSuccessState(r)),
    );
  }
}
