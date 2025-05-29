part of 'dash_monthwise_user_details_graph_cubit.dart';

abstract class DashMonthwiseUserDetailsGraphState extends Equatable {
  const DashMonthwiseUserDetailsGraphState();

  @override
  List<Object?> get props => [];
}

class DashMonthwiseUserDetailsGraphInitialState
    extends DashMonthwiseUserDetailsGraphState {}

class DashMonthwiseUserDetailsGraphLoadingState
    extends DashMonthwiseUserDetailsGraphState {}

class DashMonthwiseUserDetailsGraphSuccessState
    extends DashMonthwiseUserDetailsGraphState {
  final DashMonthwiseUserDetailsGraphEntity graphData;

  const DashMonthwiseUserDetailsGraphSuccessState(this.graphData);

  @override
  List<Object?> get props => [graphData];
}

class DashMonthwiseUserDetailsGraphFailureState
    extends DashMonthwiseUserDetailsGraphState {
  final AppErrorType errorType;
  final String? errorMessage;

  const DashMonthwiseUserDetailsGraphFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
