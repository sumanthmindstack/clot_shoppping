class GetKycUserListEntity {
  final List<KycUserEntity>? data;

  GetKycUserListEntity({required this.data});
}

class KycUserEntity {
  final int id;
  final String fullName;
  final String email;
  final String mobile;
  final bool mobileVerified;
  final bool isActive;
  final bool isBlocked;
  final String countryCode;
  final UserOnboardingDetailsEntity? userOnboardingDetails;

  KycUserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.mobileVerified,
    required this.isActive,
    required this.isBlocked,
    required this.countryCode,
    required this.userOnboardingDetails,
  });
}

class UserOnboardingDetailsEntity {
  final int? id;
  final bool? isKycCompliant;
  final String? pan;
  final String? fullName;
  final String? dateOfBirth;
  final String? fatherName;
  final String? motherName;
  final String? maritalStatus;
  final String? gender;
  final String? occupation;
  final String? annualIncome;
  final String? nationality;
  final String? signatureUrl;
  final String? photoUrl;
  final String? videoUrl;
  final String? fpEsignStatus;
  final int? kycId;
  final String? fpPhotoFileId;
  final String? fpVideoFileId;
  final String? fpSignatureFileId;
  final String? aadhaarNumber;
  final String? fpEsignId;
  final String? status;
  final String? onboardingStatus;
  final dynamic? lat;
  final dynamic? lng;
  final String? identityDocumentId;
  final String? identityDocumentStatus;
  final String? fpInvestorId;
  final String? fpInvestmentAccountOldId;

  UserOnboardingDetailsEntity({
    this.id,
    this.isKycCompliant,
    this.pan,
    this.fullName,
    this.dateOfBirth,
    this.fatherName,
    this.motherName,
    this.maritalStatus,
    this.gender,
    this.occupation,
    this.annualIncome,
    this.nationality,
    this.signatureUrl,
    this.photoUrl,
    this.videoUrl,
    this.fpEsignStatus,
    this.kycId,
    this.fpPhotoFileId,
    this.fpVideoFileId,
    this.fpSignatureFileId,
    this.aadhaarNumber,
    this.fpEsignId,
    this.status,
    this.onboardingStatus,
    this.lat,
    this.lng,
    this.identityDocumentId,
    this.identityDocumentStatus,
    this.fpInvestorId,
    this.fpInvestmentAccountOldId,
  });
}
