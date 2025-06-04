part of 'investor_profile_data_cubit.dart';

abstract class InvesterProfileDataState extends Equatable {
  const InvesterProfileDataState();

  @override
  List<Object?> get props => [];
}

class InvesterProfileDataInitialState extends InvesterProfileDataState {}

class InvesterProfileDataLoadingState extends InvesterProfileDataState {}

class InvesterProfileDataSuccessState extends InvesterProfileDataState {
  final List<InvestorProfileDataEntity> investorProfileDataEntity;

  const InvesterProfileDataSuccessState(this.investorProfileDataEntity);

  @override
  List<Object?> get props => [investorProfileDataEntity];
}

class InvesterProfileDataFailureState extends InvesterProfileDataState {
  final AppErrorType errorType;
  final String? errorMessage;

  const InvesterProfileDataFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
