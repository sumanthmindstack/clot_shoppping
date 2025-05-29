part of 'dashboard_data_count_cubit.dart';

abstract class DashboardDataCountState extends Equatable {}

class DashboardDataCountInitialState extends DashboardDataCountState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DashboardDataCountLoadingState extends DashboardDataCountState {
  @override
  List<Object> get props => [];
}

class DashboardDataCountSuccessState extends DashboardDataCountState {
  final DashboardDatacountEntity dashboardDatacountEntity;
  final List<Map<String, String>> breakdownValues;

  DashboardDataCountSuccessState(
      this.dashboardDatacountEntity, this.breakdownValues);

  @override
  List<Object> get props => [dashboardDatacountEntity, breakdownValues];
}

class DashboardDataCountFailureState extends DashboardDataCountState {
  final String? errorMessage;
  final AppErrorType errorType;

  DashboardDataCountFailureState({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
