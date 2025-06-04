part of 'portfolio_analysis_graph_data_cubit.dart';

abstract class PortfolioAnalysisGraphDataState extends Equatable {
  const PortfolioAnalysisGraphDataState();

  @override
  List<Object?> get props => [];
}

class PortfolioAnalysisGraphDataInitialState
    extends PortfolioAnalysisGraphDataState {}

class PortfolioAnalysisGraphDataLoadingState
    extends PortfolioAnalysisGraphDataState {}

class PortfolioAnalysisGraphDataSuccessState
    extends PortfolioAnalysisGraphDataState {
  final PortfolioAnalysisGraphDataEntity entity;

  const PortfolioAnalysisGraphDataSuccessState(this.entity);

  @override
  List<Object?> get props => [entity];
}

class PortfolioAnalysisGraphDataFailureState
    extends PortfolioAnalysisGraphDataState {
  final AppErrorType errorType;
  final String? errorMessage;

  const PortfolioAnalysisGraphDataFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
