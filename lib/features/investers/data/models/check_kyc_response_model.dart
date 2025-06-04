import '../../domain/entity/check_kyc_entity.dart';

class CheckKycResponseModel extends CheckKycEntity {
  CheckKycResponseModel({
    required super.name,
    required super.pan,
    required super.status,
    required super.userId,
    required super.userOnboardingDetailId,
    super.panDetails,
  });

  factory CheckKycResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return CheckKycResponseModel(
      name: data['name'] ?? '',
      pan: data['pan'] ?? '',
      status: data['status'] ?? false,
      userId: data['user_id'] ?? 0,
      userOnboardingDetailId: data['user_onboarding_detail_id'] ?? 0,
      panDetails: data['pan_details'], // remains dynamic
    );
  }

  Map<String, dynamic> toJson() => {
        'data': {
          'name': name,
          'pan': pan,
          'status': status,
          'user_id': userId,
          'user_onboarding_detail_id': userOnboardingDetailId,
          'pan_details': panDetails,
        },
      };
}
