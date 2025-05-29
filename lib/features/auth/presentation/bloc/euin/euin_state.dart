part of 'euin_cubit.dart';

abstract class EuinState extends Equatable {
  const EuinState();

  @override
  List<Object?> get props => [];
}

class EuinInitialState extends EuinState {}

class EuinLoadingState extends EuinState {}

class EuinSuccessState extends EuinState {
  final EuinEntity euinData;

  const EuinSuccessState({required this.euinData});

  @override
  List<Object?> get props => [euinData];
}

class EuinFailureState extends EuinState {
  final AppErrorType errorType;
  final String? errorMessage;

  const EuinFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
