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

  const GetInvesterListSuccessState(this.getInvesterListEntity);

  @override
  List<Object> get props => [getInvesterListEntity];
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
