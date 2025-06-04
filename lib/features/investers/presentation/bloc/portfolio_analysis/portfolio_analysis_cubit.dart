import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/entity/params/edit_invester_details_params.dart';
import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/portfolio_analysis_entity.dart';
import '../../../domain/usecase/portfolio_analysis_usecase.dart';

part 'portfolio_analysis_state.dart';

@injectable
class PortfolioAnalysisCubit extends Cubit<PortfolioAnalysisState> {
  final PortfolioAnalysisUsecase _portfolioAnalysisUsecase;

  PortfolioAnalysisCubit(this._portfolioAnalysisUsecase)
      : super(PortfolioAnalysisInitialState());

  void getPortfolioAnalysis({
    required int userId,
  }) async {
    emit(PortfolioAnalysisLoadingState());

    final params = EditInvesterDetailsParams(userId: userId);
    final response = await _portfolioAnalysisUsecase(params);

    response.fold(
      (l) => emit(
        PortfolioAnalysisFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(PortfolioAnalysisSuccessState(r)),
    );
  }
}
