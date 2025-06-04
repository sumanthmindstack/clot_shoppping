part of 'get_kyc_details_cubit.dart';

abstract class GetKycDetailsState extends Equatable {
  const GetKycDetailsState();

  @override
  List<Object?> get props => [];
}

class GetKycDetailsInitialState extends GetKycDetailsState {}

class GetKycDetailsLoadingState extends GetKycDetailsState {}

class GetKycDetailsSuccessState extends GetKycDetailsState {
  final GetKycDetailsEntity kycDetails;

  const GetKycDetailsSuccessState(this.kycDetails);

  @override
  List<Object?> get props => [kycDetails];
}

class GetKycDetailsFailureState extends GetKycDetailsState {
  final AppErrorType errorType;
  final String? errorMessage;

  const GetKycDetailsFailureState({
    required this.errorType,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorType, errorMessage];
}
