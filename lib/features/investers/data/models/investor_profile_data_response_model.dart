import '../../domain/entity/investor_profile_data_entity.dart';

class InvestorProfileDataResponseModel extends InvestorProfileDataEntity {
  InvestorProfileDataResponseModel({
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
    super.signatureUrl,
    super.photoUrl,
    super.videoUrl,
    super.fpEsignStatus,
    required super.kycId,
    super.fpPhotoFileId,
    super.fpVideoFileId,
    super.fpSignatureFileId,
    super.aadhaarNumber,
    super.fpEsignId,
    required super.status,
    super.onboardingStatus,
    super.lat,
    super.lng,
    super.identityDocumentId,
    super.identityDocumentStatus,
    super.fpInvestorId,
    super.fpInvestmentAccountOldId,
    super.fpInvestmentAccountId,
    super.fpKycStatus,
    super.fpKycRejectReasons,
    required super.userId,
    required super.createdAt,
    required super.updatedAt,
    required super.userNomineeDetails,
    required super.userAddressDetails,
    required super.userBankDetails,
    required super.user,
  });

  factory InvestorProfileDataResponseModel.fromJson(Map<String, dynamic> json) {
    return InvestorProfileDataResponseModel(
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
      identityDocumentId: json['identity_document_id'],
      identityDocumentStatus: json['identity_document_status'],
      fpInvestorId: json['fp_investor_id'],
      fpInvestmentAccountOldId: json['fp_investment_account_old_id'],
      fpInvestmentAccountId: json['fp_investment_account_id'],
      fpKycStatus: json['fp_kyc_status'],
      fpKycRejectReasons: json['fp_kyc_reject_reasons'],
      userId: json['user_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      userNomineeDetails: (json['user_nominee_details'] as List? ?? [])
          .map((e) => UserNomineeDetailsModel.fromJson(e))
          .toList(),
      userAddressDetails: (json['user_address_details'] as List? ?? [])
          .map((e) => UserAddressDetailsModel.fromJson(e))
          .toList(),
      userBankDetails: (json['user_bank_details'] as List? ?? [])
          .map((e) => UserBankDetailsModel.fromJson(e))
          .toList(),
      user: UserModel.fromJson(json['user'] ?? {}),
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
        'fp_investment_account_id': fpInvestmentAccountId,
        'fp_kyc_status': fpKycStatus,
        'fp_kyc_reject_reasons': fpKycRejectReasons,
        'user_id': userId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user_nominee_details': userNomineeDetails?.map((e) => e).toList(),
        'user_address_details': userAddressDetails?.map((e) => e).toList(),
        'user_bank_details': userBankDetails?.map((e) => e).toList(),
        'user': user,
      };
}

class UserNomineeDetailsModel extends UserNomineeDetailEntity {
  UserNomineeDetailsModel({
    required super.id,
    required super.name,
    required super.dateOfBirth,
    required super.relationship,
    required super.allocationPercentage,
    required super.guardianName,
    required super.guardianRelationship,
    required super.userId,
    required super.createdAt,
    required super.updatedAt,
    required super.userOnboardingDetailId,
  });

  factory UserNomineeDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserNomineeDetailsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      relationship: json['relationship'] ?? '',
      allocationPercentage: json['allocation_percentage'] ?? 0,
      guardianName: json['guardian_name'] ?? '',
      guardianRelationship: json['guardian_relationship'] ?? '',
      userId: json['user_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      userOnboardingDetailId: json['user_onboarding_detail_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date_of_birth': dateOfBirth,
        'relationship': relationship,
        'allocation_percentage': allocationPercentage,
        'guardian_name': guardianName,
        'guardian_relationship': guardianRelationship,
        'user_id': userId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user_onboarding_detail_id': userOnboardingDetailId,
      };
}

class UserAddressDetailsModel extends UserAddressDetailsEntity {
  UserAddressDetailsModel({
    required super.id,
    required super.pincode,
    required super.line1,
    required super.line2,
    super.line3,
    required super.city,
    required super.state,
    required super.userId,
    required super.userOnboardingDetailId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserAddressDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserAddressDetailsModel(
      id: json['id'] ?? 0,
      pincode: json['pincode'] ?? '',
      line1: json['line_1'] ?? '',
      line2: json['line_2'] ?? '',
      line3: json['line_3'],
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      userId: json['user_id'] ?? 0,
      userOnboardingDetailId: json['user_onboarding_detail_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'pincode': pincode,
        'line_1': line1,
        'line_2': line2,
        'line_3': line3,
        'city': city,
        'state': state,
        'user_id': userId,
        'user_onboarding_detail_id': userOnboardingDetailId,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

class UserBankDetailsModel extends UserBankDetailsEntity {
  UserBankDetailsModel({
    required super.id,
    required super.accountHolderName,
    required super.accountNumber,
    required super.ifscCode,
    required super.proof,
    required super.bankName,
    required super.isPayoutEnabled,
    required super.userId,
    required super.userOnboardingDetailId,
    required super.createdAt,
    required super.updatedAt,
    required super.isPrimary,
  });

  factory UserBankDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserBankDetailsModel(
      id: json['id'] ?? 0,
      accountHolderName: json['account_holder_name'] ?? '',
      accountNumber: json['account_number'] ?? '',
      ifscCode: json['ifsc_code'] ?? '',
      proof: json['proof'] ?? '',
      bankName: json['bank_name'] ?? '',
      isPayoutEnabled: json['is_payout_enabled'] ?? false,
      userId: json['user_id'] ?? 0,
      userOnboardingDetailId: json['user_onboarding_detail_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      isPrimary: json['is_primary'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'account_holder_name': accountHolderName,
        'account_number': accountNumber,
        'ifsc_code': ifscCode,
        'proof': proof,
        'bank_name': bankName,
        'is_payout_enabled': isPayoutEnabled,
        'user_id': userId,
        'user_onboarding_detail_id': userOnboardingDetailId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'is_primary': isPrimary,
      };
}

class UserModel extends UserModelEntity {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.mobile,
    super.emailVerifiedAt,
    super.mobileVerifiedAt,
    super.mobileVerifiedOtp,
    super.createdAt,
    super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['full_name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      mobileVerifiedAt: json['mobile_verified_at'],
      mobileVerifiedOtp: json['mobile_verified_otp'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'mobile': mobile,
        'email_verified_at': emailVerifiedAt,
        'mobile_verified_at': mobileVerifiedAt,
        'mobile_verified_otp': mobileVerifiedOtp,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
