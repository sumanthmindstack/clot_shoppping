import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/usecase/get_kyc_user_list_usecase.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_kyc_user_list_entity.dart';
import '../../../domain/entity/params/get_kyc_user_list_params.dart';

part 'get_kyc_user_list_state.dart';

@injectable
class GetKycUserListCubit extends Cubit<GetKycUserListState> {
  final GetKycUserListUseCase _getKycUserListUsecase;

  GetKycUserListCubit(this._getKycUserListUsecase)
      : super(GetKycUserListInitialState());

  void fetchKycUserList({
    required String searchTerm,
    required int limit,
    required int page,
  }) async {
    emit(GetKycUserListLoadingState());

    final params = GetKycUserListParams.fromSearchTerm(
      searchTerm: searchTerm,
      limit: limit,
      page: page,
    );

    final response = await _getKycUserListUsecase(params);

    response.fold(
      (l) => emit(
        GetKycUserListFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetKycUserListSuccessState(r)),
    );
  }
}
