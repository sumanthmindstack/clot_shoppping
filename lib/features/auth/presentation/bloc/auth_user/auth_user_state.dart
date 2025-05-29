part of 'auth_user_cubit.dart';

abstract class AuthUserState extends Equatable {
  const AuthUserState();

  @override
  List<Object?> get props => [];
}

class AuthUserInitialState extends AuthUserState {}

class AuthUserLoadingState extends AuthUserState {}

class AuthUserSuccessState extends AuthUserState {
  final AuthUserEntity authUserEntity;

  const AuthUserSuccessState({required this.authUserEntity});
  @override
  List<Object?> get props => [authUserEntity];
}

class AuthUserFailureState extends AuthUserState {
  final AppErrorType errorType;
  final String? errorMessage;

  const AuthUserFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
