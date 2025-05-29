import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:maxwealth_distributor_app/core/entities/no_params.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/auth_user_entity.dart';
import '../../../domain/usecase/auth_user_usecase.dart';

part 'auth_user_state.dart';

@injectable
class AuthUserCubit extends Cubit<AuthUserState> {
  final AuthUserUsecase _authUserUsecase;

  AuthUserCubit(this._authUserUsecase) : super(AuthUserInitialState());

  void authenticateUser() async {
    emit(AuthUserLoadingState());

    final response = await _authUserUsecase(NoParams());

    response.fold(
      (l) => emit(
        AuthUserFailureState(errorType: l.errorType, errorMessage: l.error),
      ),
      (r) => emit(AuthUserSuccessState(authUserEntity: r)),
    );
  }
}
