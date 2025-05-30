part of 'get_invester_list_cubit.dart';

abstract class GetInvesterListState extends Equatable {
  const GetInvesterListState();

  @override
  List<Object> get props => [];
}

class GetInvesterListInitialState extends GetInvesterListState {}

class GetInvesterListLoadingState extends GetInvesterListState {}

class GetInvesterListSuccessState extends GetInvesterListState {
  final GetInvesterListEntity getInvesterListEntity;
  final List<InvestorEntity> investors;
  final bool hasReachedMax;

  const GetInvesterListSuccessState(
      {required this.investors,
      required this.hasReachedMax,
      required this.getInvesterListEntity});

  @override
  List<Object> get props => [getInvesterListEntity, investors, hasReachedMax];
}

class GetInvesterListFailureState extends GetInvesterListState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetInvesterListFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
