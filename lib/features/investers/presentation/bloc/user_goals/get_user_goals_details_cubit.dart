import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/params/get_user_goals_details_params.dart';
import '../../../domain/entity/user_goals_entity.dart';
import '../../../domain/usecase/get_user_goals_details_usecase.dart';

part 'get_user_goals_details_entity_state.dart';

@injectable
class GetUserGoalsDetailsCubit extends Cubit<GetUserGoalsDetailsState> {
  final GetUserGoalsDetailsUsecase _getUserGoalsDetailsUsecase;

  GetUserGoalsDetailsCubit(this._getUserGoalsDetailsUsecase)
      : super(GetUserGoalsDetailsInitialState());

  void fetchUserGoalsDetails({
    required int userId,
  }) async {
    emit(GetUserGoalsDetailsLoadingState());

    final params = GetUserGoalsDetailsParams(
      userId: userId,
    );

    final response = await _getUserGoalsDetailsUsecase(params);

    response.fold(
      (l) => emit(
        GetUserGoalsDetailsFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(GetUserGoalsDetailsSuccessState(r)),
    );
  }
}
