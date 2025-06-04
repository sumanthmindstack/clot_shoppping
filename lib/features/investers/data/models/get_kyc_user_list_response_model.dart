import '../../domain/entity/get_kyc_user_list_entity.dart';

class GetKycUserListResponseModel extends GetKycUserListEntity {
  GetKycUserListResponseModel({required super.data});

  factory GetKycUserListResponseModel.fromJson(Map<String, dynamic> json) {
    return GetKycUserListResponseModel(
      data: (json['data'] as List?)
              ?.map((e) => KycUserModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e).toList(),
      };
}

class KycUserModel extends KycUserEntity {
  KycUserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.mobile,
    required super.mobileVerified,
    required super.isActive,
    required super.isBlocked,
    required super.countryCode,
    required super.userOnboardingDetails,
  });

  factory KycUserModel.fromJson(Map<String, dynamic> json) {
    return KycUserModel(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      mobileVerified: json['mobile_verified'] ?? false,
      isActive: json['is_active'] ?? false,
      isBlocked: json['is_blocked'] ?? false,
      countryCode: json['country_code'] ?? '',
      userOnboardingDetails: json['user_onboarding_details'] != null
          ? UserOnboardingDetailsModel.fromJson(json['user_onboarding_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'mobile': mobile,
        'mobile_verified': mobileVerified,
        'is_active': isActive,
        'is_blocked': isBlocked,
        'country_code': countryCode,
        'user_onboarding_details': userOnboardingDetails,
      };
}

class UserOnboardingDetailsModel extends UserOnboardingDetailsEntity {
  UserOnboardingDetailsModel({
    required super.id,
    required super.isKycCompliant,
    required super.pan,
    required super.fullName,
    required super.dateOfBirth,
    required super.fatherName,
    required super.motherName,
    required super.maritalStatus,
    required super.gender,
    required super.occupation,
    required super.annualIncome,
    required super.nationality,
    required super.signatureUrl,
    required super.photoUrl,
    required super.videoUrl,
    required super.fpEsignStatus,
    required super.kycId,
    required super.fpPhotoFileId,
    required super.fpVideoFileId,
    required super.fpSignatureFileId,
    required super.aadhaarNumber,
    required super.fpEsignId,
    required super.status,
    required super.onboardingStatus,
    required super.lat,
    required super.lng,
    required super.identityDocumentId,
    required super.identityDocumentStatus,
    required super.fpInvestorId,
    required super.fpInvestmentAccountOldId,
  });

  factory UserOnboardingDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserOnboardingDetailsModel(
      id: json['id'] ?? 0,
      isKycCompliant: json['is_kyc_compliant'] ?? false,
      pan: json['pan'] ?? '',
      fullName: json['full_name'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      fatherName: json['father_name'] ?? '',
      motherName: json['mother_name'] ?? '',
      maritalStatus: json['marital_status'] ?? '',
      gender: json['gender'] ?? '',
      occupation: json['occupation'] ?? '',
      annualIncome: json['annual_income'] ?? '',
      nationality: json['nationality'] ?? '',
      signatureUrl: json['signature_url'],
      photoUrl: json['photo_url'],
      videoUrl: json['video_url'],
      fpEsignStatus: json['fp_esign_status'],
      kycId: json['kyc_id'] ?? 0,
      fpPhotoFileId: json['fp_photo_file_id'],
      fpVideoFileId: json['fp_video_file_id'],
      fpSignatureFileId: json['fp_signature_file_id'],
      aadhaarNumber: json['aadhaar_number'],
      fpEsignId: json['fp_esign_id'],
      status: json['status'] ?? '',
      onboardingStatus: json['onboarding_status'],
      lat: json['lat'],
      lng: json['lng'],
      identityDocumentId: json['identity_document_id'] ?? '',
      identityDocumentStatus: json['identity_document_status'] ?? '',
      fpInvestorId: json['fp_investor_id'],
      fpInvestmentAccountOldId: json['fp_investment_account_old_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'is_kyc_compliant': isKycCompliant,
        'pan': pan,
        'full_name': fullName,
        'date_of_birth': dateOfBirth,
        'father_name': fatherName,
        'mother_name': motherName,
        'marital_status': maritalStatus,
        'gender': gender,
        'occupation': occupation,
        'annual_income': annualIncome,
        'nationality': nationality,
        'signature_url': signatureUrl,
        'photo_url': photoUrl,
        'video_url': videoUrl,
        'fp_esign_status': fpEsignStatus,
        'kyc_id': kycId,
        'fp_photo_file_id': fpPhotoFileId,
        'fp_video_file_id': fpVideoFileId,
        'fp_signature_file_id': fpSignatureFileId,
        'aadhaar_number': aadhaarNumber,
        'fp_esign_id': fpEsignId,
        'status': status,
        'onboarding_status': onboardingStatus,
        'lat': lat,
        'lng': lng,
        'identity_document_id': identityDocumentId,
        'identity_document_status': identityDocumentStatus,
        'fp_investor_id': fpInvestorId,
        'fp_investment_account_old_id': fpInvestmentAccountOldId,
      };
}
