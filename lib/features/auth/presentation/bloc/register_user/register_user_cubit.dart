import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/params/register_user_params.dart';
import '../../../domain/entities/register_user_entity.dart';
import '../../../domain/usecase/register_user_usecase.dart';

part 'register_user_state.dart';

@injectable
class RegisterUserCubit extends Cubit<RegisterUserState> {
  final RegisterUserUsecase _registerUserUsecase;

  RegisterUserCubit(this._registerUserUsecase)
      : super(RegisterUserInitialState());

  void registerUser(
      {String? userType,
      String? email,
      String? type,
      String? mobileNumber,
      File? file1,
      File? file2}) async {
    emit(RegisterUserLoadingState());

    final response = await _registerUserUsecase(
      RegisterUserParams(
          userType: userType!,
          email: email!,
          type: type!,
          mobile: mobileNumber!,
          file1: file1!,
          file2: file2!),
    );

    response.fold(
      (l) => emit(RegisterUserFailureState(
          errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(RegisterUserSuccessState(r)),
    );
  }
}
