import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/portfolio_analysis_graph_data_entity.dart';
import '../../../domain/entity/params/portfolio_analysis_graph_data_params.dart';
import '../../../domain/usecase/portfolio_analysis_graph_data_usecase.dart';

part 'portfolio_analysis_graph_data_state.dart';

@injectable
class PortfolioAnalysisGraphDataCubit
    extends Cubit<PortfolioAnalysisGraphDataState> {
  final PortfolioAnalysisGraphDataUsecase _usecase;

  PortfolioAnalysisGraphDataCubit(this._usecase)
      : super(PortfolioAnalysisGraphDataInitialState());

  void getPortfolioAnalysisGraphData({
    required int userId,
    required int duration,
  }) async {
    emit(PortfolioAnalysisGraphDataLoadingState());

    final params =
        PortfolioAnalysisGraphDataParams(userId: userId, duration: duration);
    final response = await _usecase(params);

    response.fold(
      (l) => emit(
        PortfolioAnalysisGraphDataFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) {
        emit(PortfolioAnalysisGraphDataSuccessState(r));
      },
    );
  }
}
