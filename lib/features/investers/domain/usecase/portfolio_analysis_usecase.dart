import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/params/edit_invester_details_params.dart';
import '../entity/portfolio_analysis_entity.dart';
import '../repository/invester_repo.dart';

@injectable
class PortfolioAnalysisUsecase
    implements Usecase<PortfolioAnalysisEntity, EditInvesterDetailsParams> {
  final InvesterRepo _investerRepo;

  PortfolioAnalysisUsecase(this._investerRepo);

  @override
  Future<Either<AppError, PortfolioAnalysisEntity>> call(
      EditInvesterDetailsParams params) async {
    return await _investerRepo.portfolioAnalysis(params.toJson());
  }
}
