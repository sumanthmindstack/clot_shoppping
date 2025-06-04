class CheckKycEntity {
  final String name;
  final String pan;
  final bool status;
  final int userId;
  final int userOnboardingDetailId;
  final dynamic panDetails;

  CheckKycEntity({
    required this.name,
    required this.pan,
    required this.status,
    required this.userId,
    required this.userOnboardingDetailId,
    this.panDetails,
  });
}
