part of 'dash_monthwise_invester_details_graph_cubit.dart';

abstract class DashMonthwiseInvesterDetailsGraphState extends Equatable {
  const DashMonthwiseInvesterDetailsGraphState();

  @override
  List<Object?> get props => [];
}

class DashMonthwiseInvesterDetailsGraphInitialState
    extends DashMonthwiseInvesterDetailsGraphState {}

class DashMonthwiseInvesterDetailsGraphLoadingState
    extends DashMonthwiseInvesterDetailsGraphState {}

class DashMonthwiseInvesterDetailsGraphSuccessState
    extends DashMonthwiseInvesterDetailsGraphState {
  final DashMonthwiseInvesterDetailsGraphEntity graphData;

  const DashMonthwiseInvesterDetailsGraphSuccessState(this.graphData);

  @override
  List<Object?> get props => [graphData];
}

class DashMonthwiseInvesterDetailsGraphFailureState
    extends DashMonthwiseInvesterDetailsGraphState {
  final AppErrorType errorType;
  final String? errorMessage;

  const DashMonthwiseInvesterDetailsGraphFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
