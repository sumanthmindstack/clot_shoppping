import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/get_invester_list_entitty.dart';
import '../../../domain/entity/params/get_invester_list_params.dart';
import '../../../domain/usecase/get_invester_list_usecase.dart';

part 'get_invester_list_state.dart';

@injectable
class GetInvesterListCubit extends Cubit<GetInvesterListState> {
  final GetInvesterListUsecase _getInvesterListUsecase;
  List<InvestorEntity> _investors = [];

  GetInvesterListCubit(this._getInvesterListUsecase)
      : super(GetInvesterListInitialState());

  void fetchInvesterList({
    required int page,
    required int limit,
    String? searchData,
  }) async {
    if (page == 1) {
      emit(GetInvesterListLoadingState());
      _investors.clear();
    }

    final params = GetInvesterListParams(
      page: page,
      limit: limit,
      searchData: searchData ?? "",
    );

    final response = await _getInvesterListUsecase(params);

    response.fold(
      (l) => emit(
        GetInvesterListFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) {
        _investors.addAll(r.data);
        emit(GetInvesterListSuccessState(
          GetInvesterListEntity(data: List.from(_investors)),
        ));
      },
    );
  }
}
