import '../../domain/entity/get_invester_list_entitty.dart';

class GetInvesterListResponseModel extends GetInvesterListEntity {
  GetInvesterListResponseModel({required super.data});

  factory GetInvesterListResponseModel.fromJson(Map<String, dynamic> json) {
    return GetInvesterListResponseModel(
      data: (json['data'] as List?)
              ?.map((e) => InvestorModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((e) => e).toList(),
    };
  }
}

class InvestorModel extends InvestorEntity {
  InvestorModel({
    required super.aadhaarNo,
    required super.createdAt,
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
    required super.kycId,
    required super.status,
    required super.onboardingStatus,
    required super.identityDocumentId,
    required super.identityDocumentStatus,
    required super.fpKycStatus,
    required super.userId,
    required super.type,
    required super.taxStatus,
    required super.countryOfBirth,
    required super.placeOfBirth,
    required super.ipAddress,
    required super.isOnboardingComplete,
    required super.user,
    required super.userNomineeDetails,
    required super.userAddressDetails,
    required super.userBankDetails,
  });

  factory InvestorModel.fromJson(Map<String, dynamic> json) {
    return InvestorModel(
      aadhaarNo: json['aadhaar_number'],
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? 0,
      isKycCompliant: json['is_kyc_compliant'] ?? false,
      pan: json['pan'] ?? "",
      fullName: json['full_name'] ?? "",
      dateOfBirth: json['date_of_birth'] ?? "",
      fatherName: json['father_name'] ?? "",
      motherName: json['mother_name'] ?? "",
      maritalStatus: json['marital_status'] ?? "",
      gender: json['gender'] ?? "",
      occupation: json['occupation'] ?? "",
      annualIncome: json['annual_income'] ?? "",
      nationality: json['nationality'] ?? "",
      signatureUrl: json['signature_url'] ?? "",
      photoUrl: json['photo_url'] ?? "",
      videoUrl: json['video_url'] ?? "",
      kycId: json['kyc_id'] ?? "",
      status: json['status'] ?? "",
      onboardingStatus: json['onboarding_status'] ?? "",
      identityDocumentId: json['identity_document_id'] ?? "",
      identityDocumentStatus: json['identity_document_status'] ?? "",
      fpKycStatus: json['fp_kyc_status'] ?? "",
      userId: json['user_id'] ?? 0,
      type: json['type'] ?? "",
      taxStatus: json['tax_status'] ?? "",
      countryOfBirth: json['country_of_birth'] ?? "",
      placeOfBirth: json['place_of_birth'] ?? "",
      ipAddress: json['ip_address'] ?? "",
      isOnboardingComplete: json['is_onboarding_complete'] ?? false,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'])
          : UserModel(
              id: 0,
              fullName: '',
              email: '',
              mpin: 0,
              mobile: '',
              isActive: false),
      userNomineeDetails: (json['user_nominee_details'] as List?)
              ?.map((e) => NomineeModel.fromJson(e))
              .toList() ??
          [],
      userAddressDetails: (json['user_address_details'] as List?)
              ?.map((e) => AddressModel.fromJson(e))
              .toList() ??
          [],
      userBankDetails: (json['user_bank_details'] as List?)
              ?.map((e) => BankDetailModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'aadhaar_number': aadhaarNo,
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
        'kyc_id': kycId,
        'status': status,
        'onboarding_status': onboardingStatus,
        'identity_document_id': identityDocumentId,
        'identity_document_status': identityDocumentStatus,
        'fp_kyc_status': fpKycStatus,
        'user_id': userId,
        'type': type,
        'tax_status': taxStatus,
        'country_of_birth': countryOfBirth,
        'place_of_birth': placeOfBirth,
        'ip_address': ipAddress,
        'is_onboarding_complete': isOnboardingComplete,
        'user': user,
        'user_nominee_details': userNomineeDetails?.map((e) => e).toList(),
        'user_address_details': userAddressDetails?.map((e) => e).toList(),
        'user_bank_details': userBankDetails?.map((e) => e).toList(),
      };
}

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.mpin,
    required super.mobile,
    required super.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? "",
      email: json['email'] ?? "",
      mpin: json['mpin'] ?? 0,
      mobile: json['mobile'] ?? "",
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'mpin': mpin,
        'mobile': mobile,
        'is_active': isActive,
      };
}

class NomineeModel extends NomineeEntity {
  NomineeModel({
    required super.id,
    required super.name,
    required super.dateOfBirth,
    required super.relationship,
    required super.allocationPercentage,
  });

  factory NomineeModel.fromJson(Map<String, dynamic> json) {
    return NomineeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      dateOfBirth: json['date_of_birth'] ?? "",
      relationship: json['relationship'] ?? "",
      allocationPercentage: json['allocation_percentage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date_of_birth': dateOfBirth,
        'relationship': relationship,
        'allocation_percentage': allocationPercentage,
      };
}

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.pincode,
    required super.line1,
    required super.line2,
    required super.city,
    required super.state,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? 0,
      pincode: json['pincode'] ?? "",
      line1: json['line_1'] ?? "",
      line2: json['line_2'] ?? "",
      city: json['city'] ?? "",
      state: json['state'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'pincode': pincode,
        'line_1': line1,
        'line_2': line2,
        'city': city,
        'state': state,
      };
}

class BankDetailModel extends BankDetailEntity {
  BankDetailModel({
    required super.id,
    required super.accountHolderName,
    required super.accountNumber,
    required super.ifscCode,
    required super.bankName,
    required super.isPrimary,
  });

  factory BankDetailModel.fromJson(Map<String, dynamic> json) {
    return BankDetailModel(
      id: json['id'] ?? 0,
      accountHolderName: json['account_holder_name'] ?? "",
      accountNumber: json['account_number'] ?? "",
      ifscCode: json['ifsc_code'] ?? "",
      bankName: json['bank_name'] ?? "",
      isPrimary: json['is_primary'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'account_holder_name': accountHolderName,
        'account_number': accountNumber,
        'ifsc_code': ifscCode,
        'bank_name': bankName,
        'is_primary': isPrimary,
      };
}
