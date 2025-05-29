part of 'ria_bank_cubit.dart';

abstract class RiaBankState extends Equatable {
  const RiaBankState();

  @override
  List<Object?> get props => [];
}

class RiaBankInitialState extends RiaBankState {}

class RiaBankLoadingState extends RiaBankState {}

class RiaBankSuccessState extends RiaBankState {
  final RiaBankEntity riaBankEntity;

  const RiaBankSuccessState(this.riaBankEntity);

  @override
  List<Object?> get props => [riaBankEntity];
}

class RiaBankFailureState extends RiaBankState {
  final AppErrorType errorType;
  final String? errorMessage;

  const RiaBankFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
