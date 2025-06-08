part of 'get_scheme_wise_cubit.dart';

abstract class GetSchemeWiseState extends Equatable {
  const GetSchemeWiseState();

  @override
  List<Object?> get props => [];
}

class GetSchemeWiseInitialState extends GetSchemeWiseState {}

class GetSchemeWiseLoadingState extends GetSchemeWiseState {}

class GetSchemeWiseSuccessState extends GetSchemeWiseState {
  final GetSchemeWiseEntity getSchemeWiseEntity;

  const GetSchemeWiseSuccessState(this.getSchemeWiseEntity);

  @override
  List<Object?> get props => [getSchemeWiseEntity];
}

class GetSchemeWiseFailureState extends GetSchemeWiseState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetSchemeWiseFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
