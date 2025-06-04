part of 'portfolio_analysis_cubit.dart';

abstract class PortfolioAnalysisState extends Equatable {
  const PortfolioAnalysisState();

  @override
  List<Object?> get props => [];
}

class PortfolioAnalysisInitialState extends PortfolioAnalysisState {}

class PortfolioAnalysisLoadingState extends PortfolioAnalysisState {}

class PortfolioAnalysisSuccessState extends PortfolioAnalysisState {
  final PortfolioAnalysisEntity entity;

  const PortfolioAnalysisSuccessState(this.entity);

  @override
  List<Object?> get props => [entity];
}

class PortfolioAnalysisFailureState extends PortfolioAnalysisState {
  final AppErrorType errorType;
  final String? errorMessage;

  const PortfolioAnalysisFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
