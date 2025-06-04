import '../../data/models/investor_profile_data_response_model.dart';

class InvestorProfileDataEntity {
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
  final dynamic fpEsignStatus;
  final int? kycId;
  final dynamic fpPhotoFileId;
  final dynamic fpVideoFileId;
  final dynamic fpSignatureFileId;
  final dynamic aadhaarNumber;
  final dynamic fpEsignId;
  final String? status;
  final dynamic onboardingStatus;
  final dynamic lat;
  final dynamic lng;
  final String? identityDocumentId;
  final String? identityDocumentStatus;
  final dynamic fpInvestorId;
  final dynamic fpInvestmentAccountOldId;
  final dynamic fpInvestmentAccountId;
  final String? fpKycStatus;
  final dynamic fpKycRejectReasons;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final List<UserNomineeDetailsModel>? userNomineeDetails;
  final List<UserAddressDetailsModel>? userAddressDetails;
  final List<UserBankDetailsModel>? userBankDetails;
  final UserModel? user;

  InvestorProfileDataEntity({
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
    this.fpInvestmentAccountId,
    this.fpKycStatus,
    this.fpKycRejectReasons,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.userNomineeDetails,
    this.userAddressDetails,
    this.userBankDetails,
    this.user,
  });
}

class UserNomineeDetailEntity {
  final int? id;
  final String? name;
  final String? dateOfBirth;
  final String? relationship;
  final int? allocationPercentage;
  final String? guardianName;
  final String? guardianRelationship;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final int? userOnboardingDetailId;

  UserNomineeDetailEntity({
    this.id,
    this.name,
    this.dateOfBirth,
    this.relationship,
    this.allocationPercentage,
    this.guardianName,
    this.guardianRelationship,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.userOnboardingDetailId,
  });
}

class UserAddressDetailsEntity {
  final int? id;
  final String? pincode;
  final String? line1;
  final String? line2;
  final String? line3;
  final String? city;
  final String? state;
  final int? userId;
  final int? userOnboardingDetailId;
  final String? createdAt;
  final String? updatedAt;

  UserAddressDetailsEntity({
    this.id,
    this.pincode,
    this.line1,
    this.line2,
    this.line3,
    this.city,
    this.state,
    this.userId,
    this.userOnboardingDetailId,
    this.createdAt,
    this.updatedAt,
  });
}

class UserBankDetailsEntity {
  final int? id;
  final String? accountHolderName;
  final String? accountNumber;
  final String? ifscCode;
  final String? proof;
  final String? bankName;
  final bool? isPayoutEnabled;
  final int? userId;
  final int? userOnboardingDetailId;
  final String? createdAt;
  final String? updatedAt;
  final bool? isPrimary;

  UserBankDetailsEntity({
    this.id,
    this.accountHolderName,
    this.accountNumber,
    this.ifscCode,
    this.proof,
    this.bankName,
    this.isPayoutEnabled,
    this.userId,
    this.userOnboardingDetailId,
    this.createdAt,
    this.updatedAt,
    this.isPrimary,
  });
}

class UserModelEntity {
  final int? id;
  final String? username;
  final String? email;
  final String? mobile;
  final String? emailVerifiedAt;
  final String? mobileVerifiedAt;
  final String? mobileVerifiedOtp;
  final String? createdAt;
  final String? updatedAt;

  UserModelEntity({
    this.id,
    this.username,
    this.email,
    this.mobile,
    this.emailVerifiedAt,
    this.mobileVerifiedAt,
    this.mobileVerifiedOtp,
    this.createdAt,
    this.updatedAt,
  });
}
