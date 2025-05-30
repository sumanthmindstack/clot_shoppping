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

  int _currentPage = 1;
  final int _limit = 10;
  bool _hasReachedMax = false;
  List<InvestorEntity> _investors = [];
  String? _currentSearch;

  GetInvesterListCubit(this._getInvesterListUsecase)
      : super(GetInvesterListInitialState());

  // Public getters
  List<InvestorEntity> get investors => _investors;
  bool get hasReachedMax => _hasReachedMax;

  Future<void> fetchInvesterList({
    bool loadMore = false,
    String? searchData,
  }) async {
    // Reset pagination if it's a new search
    if (searchData != null && searchData != _currentSearch) {
      _currentPage = 1;
      _hasReachedMax = false;
      _investors = [];
      _currentSearch = searchData;
    }

    // Don't load more if we've reached the end
    if (loadMore && _hasReachedMax) return;

    try {
      emit(loadMore
          ? GetInvesterListLoadingState()
          : GetInvesterListLoadingState());

      final params = GetInvesterListParams(
        page: _currentPage,
        limit: _limit,
        searchData: searchData ?? _currentSearch ?? "",
      );

      final response = await _getInvesterListUsecase(params);

      response.fold(
        (l) => emit(GetInvesterListFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        )),
        (r) {
          _currentPage++;
          _hasReachedMax = r.data.length < _limit;
          _investors.addAll(r.data);

          emit(GetInvesterListSuccessState(
            getInvesterListEntity: r,
            investors: List.of(_investors),
            hasReachedMax: _hasReachedMax,
          ));
        },
      );
    } catch (e) {
      emit(GetInvesterListFailureState(
        errorType: AppErrorType.api,
        errorMessage: e.toString(),
      ));
    }
  }

  void resetPagination() {
    _currentPage = 1;
    _hasReachedMax = false;
    _investors = [];
    _currentSearch = null;
  }
}
