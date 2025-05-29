import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/features/auth/domain/entities/find_one_entity.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/params/find_one_params.dart';
import '../../../domain/usecase/find_one_usecase.dart';

part 'find_one_state.dart';

@injectable
class FindOneCubit extends Cubit<FindOneState> {
  final FindOneUsecase _findOneUsecase;

  FindOneCubit(this._findOneUsecase) : super(FindOneInitialState());

  void findOne({required String id}) async {
    emit(FindOneLoadingState());

    final response = await _findOneUsecase(FindOneParams(id: id));
    response.fold(
      (l) => emit(
        FindOneFailureState(errorType: l.errorType, errorMessage: l.error),
      ),
      (r) => emit(FindOneSuccessState(r)),
    );
  }
}
