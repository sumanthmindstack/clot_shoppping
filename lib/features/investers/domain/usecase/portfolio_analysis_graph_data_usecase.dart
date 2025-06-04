import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/params/portfolio_analysis_graph_data_params.dart';
import '../entity/portfolio_analysis_graph_data_entity.dart';
import '../repository/invester_repo.dart';

@injectable
class PortfolioAnalysisGraphDataUsecase
    implements
        Usecase<PortfolioAnalysisGraphDataEntity,
            PortfolioAnalysisGraphDataParams> {
  final InvesterRepo _investerRepo;

  PortfolioAnalysisGraphDataUsecase(this._investerRepo);

  @override
  Future<Either<AppError, PortfolioAnalysisGraphDataEntity>> call(
      PortfolioAnalysisGraphDataParams params) async {
    return await _investerRepo.portfolioAnalysisGraphData(params.toJson());
  }
}
