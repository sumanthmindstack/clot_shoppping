part of 'dash_aum_report_graph_cubit.dart';

abstract class DashAumReportGraphState extends Equatable {
  const DashAumReportGraphState();

  @override
  List<Object?> get props => [];
}

class DashAumReportGraphInitialState extends DashAumReportGraphState {}

class DashAumReportGraphLoadingState extends DashAumReportGraphState {}

class DashAumReportGraphSuccessState extends DashAumReportGraphState {
  final DashAumReportGraphEntity graphData;

  const DashAumReportGraphSuccessState(this.graphData);

  @override
  List<Object?> get props => [graphData];
}

class DashAumReportGraphFailureState extends DashAumReportGraphState {
  final AppErrorType errorType;
  final String? errorMessage;

  const DashAumReportGraphFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
