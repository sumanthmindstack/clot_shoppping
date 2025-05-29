part of 'register_user_cubit.dart';

abstract class RegisterUserState extends Equatable {}

class RegisterUserInitialState extends RegisterUserState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RegisterUserLoadingState extends RegisterUserState {
  @override
  List<Object> get props => [];
}

class RegisterUserSuccessState extends RegisterUserState {
  final RegisterUserEntity registerUserEntity;

  RegisterUserSuccessState(this.registerUserEntity);
  @override
  List<Object> get props => [registerUserEntity];
}

class RegisterUserFailureState extends RegisterUserState {
  final String? errorMessage;
  final AppErrorType errorType;

  RegisterUserFailureState({this.errorMessage, required this.errorType});

  @override
  List<Object?> get props => [errorMessage, errorType];
}
