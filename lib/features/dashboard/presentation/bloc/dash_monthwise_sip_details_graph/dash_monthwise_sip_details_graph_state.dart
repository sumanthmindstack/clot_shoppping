part of 'dash_monthwise_sip_details_graph_cubit.dart';

abstract class DashMonthwiseSipDetailsGraphState extends Equatable {
  const DashMonthwiseSipDetailsGraphState();

  @override
  List<Object?> get props => [];
}

class DashMonthwiseSipDetailsGraphInitialState
    extends DashMonthwiseSipDetailsGraphState {}

class DashMonthwiseSipDetailsGraphLoadingState
    extends DashMonthwiseSipDetailsGraphState {}

class DashMonthwiseSipDetailsGraphFailureState
    extends DashMonthwiseSipDetailsGraphState {
  final String? errorMessage;
  final AppErrorType errorType;

  const DashMonthwiseSipDetailsGraphFailureState({
    required this.errorMessage,
    required this.errorType,
  });

  @override
  List<Object?> get props => [errorMessage, errorType];
}

class DashMonthwiseSipDetailsGraphSuccessState
    extends DashMonthwiseSipDetailsGraphState {
  final DashMonthwiseSipDetailsGraphEntity dashMonthwiseSipDetailsGraphEntity;
  final List<Map<String, dynamic>> graphData;

  const DashMonthwiseSipDetailsGraphSuccessState({
    required this.dashMonthwiseSipDetailsGraphEntity,
    required this.graphData,
  });

  @override
  List<Object?> get props => [dashMonthwiseSipDetailsGraphEntity, graphData];
}
