part of 'dash_monthwise_trans_details_graph_cubit.dart';

abstract class DashMonthwiseTransDetailsGraphState extends Equatable {
  const DashMonthwiseTransDetailsGraphState();

  @override
  List<Object?> get props => [];
}

class DashMonthwiseTransDetailsGraphInitialState
    extends DashMonthwiseTransDetailsGraphState {}

class DashMonthwiseTransDetailsGraphLoadingState
    extends DashMonthwiseTransDetailsGraphState {}

class DashMonthwiseTransDetailsGraphSuccessState
    extends DashMonthwiseTransDetailsGraphState {
  final DashMonthwiseTransDetailsGraphEntity graphData;

  const DashMonthwiseTransDetailsGraphSuccessState(this.graphData);

  @override
  List<Object?> get props => [graphData];
}

class DashMonthwiseTransDetailsGraphFailureState
    extends DashMonthwiseTransDetailsGraphState {
  final AppErrorType errorType;
  final String? errorMessage;

  const DashMonthwiseTransDetailsGraphFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
