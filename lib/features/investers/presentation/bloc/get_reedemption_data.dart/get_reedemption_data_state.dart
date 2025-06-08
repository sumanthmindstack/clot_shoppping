part of 'get_reedemption_data_cubit.dart';

abstract class GetRedeemDataState {
  const GetRedeemDataState();

  @override
  List<Object?> get props => [];
}

class GetRedeemDataInitialState extends GetRedeemDataState {}

class GetRedeemDataLoadingState extends GetRedeemDataState {}

class GetRedeemDataSuccessState extends GetRedeemDataState {
  final GetRedeemptionDataEntity getRedeemptionDataEntity;

  const GetRedeemDataSuccessState(this.getRedeemptionDataEntity);

  @override
  List<Object?> get props => [getRedeemptionDataEntity];
}

class GetRedeemDataFailureState extends GetRedeemDataState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetRedeemDataFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorType, errorMessage ?? ''];
}
