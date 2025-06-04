import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entity/params/edit_invester_details_params.dart';
import '../../../domain/usecase/edit_invester_details_usecase.dart';

part 'edit_invester_details_state.dart';

@injectable
class EditInvesterDetailsCubit extends Cubit<EditInvesterDetailsState> {
  final EditInvesterDetailsUsecase _editInvesterDetailsUsecase;

  EditInvesterDetailsCubit(this._editInvesterDetailsUsecase)
      : super(EditInvesterDetailsInitialState());

  void editDetails({required int userId}) async {
    emit(EditInvesterDetailsLoadingState());

    final params = EditInvesterDetailsParams(userId: userId);

    final response = await _editInvesterDetailsUsecase(params);

    response.fold(
      (l) => emit(
        EditInvesterDetailsFailureState(
          errorType: l.errorType,
          errorMessage: l.error,
        ),
      ),
      (r) => emit(const EditInvesterDetailsSuccessState()),
    );
  }
}
