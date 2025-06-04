class GetInvesterListEntity {
  final List<InvestorEntity> data;

  GetInvesterListEntity({required this.data});
}

class InvestorEntity {
  final int id;
  final bool isKycCompliant;
  final String pan;
  final String fullName;
  final String? dateOfBirth;
  final String fatherName;
  final String motherName;
  final String maritalStatus;
  final String gender;
  final String occupation;
  final String annualIncome;
  final String nationality;
  final String? signatureUrl;
  final String? photoUrl;
  final String? videoUrl;
  final dynamic kycId;
  final String status;
  final String onboardingStatus;
  final String identityDocumentId;
  final String identityDocumentStatus;
  final String fpKycStatus;
  final int userId;
  final String type;
  final String taxStatus;
  final String countryOfBirth;
  final String placeOfBirth;
  final String? ipAddress;
  final bool isOnboardingComplete;
  final UserEntity user;
  final dynamic createdAt;
  final dynamic aadhaarNo;
  final List<NomineeEntity> userNomineeDetails;
  final List<AddressEntity> userAddressDetails;
  final List<BankDetailEntity> userBankDetails;

  InvestorEntity({
    required this.aadhaarNo,
    required this.createdAt,
    required this.id,
    required this.isKycCompliant,
    required this.pan,
    required this.fullName,
    required this.dateOfBirth,
    required this.fatherName,
    required this.motherName,
    required this.maritalStatus,
    required this.gender,
    required this.occupation,
    required this.annualIncome,
    required this.nationality,
    required this.signatureUrl,
    required this.photoUrl,
    required this.videoUrl,
    required this.kycId,
    required this.status,
    required this.onboardingStatus,
    required this.identityDocumentId,
    required this.identityDocumentStatus,
    required this.fpKycStatus,
    required this.userId,
    required this.type,
    required this.taxStatus,
    required this.countryOfBirth,
    required this.placeOfBirth,
    required this.ipAddress,
    required this.isOnboardingComplete,
    required this.user,
    required this.userNomineeDetails,
    required this.userAddressDetails,
    required this.userBankDetails,
  });
}

class UserEntity {
  final int id;
  final String fullName;
  final String email;
  final int mpin;
  final String mobile;
  final bool isActive;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mpin,
    required this.mobile,
    required this.isActive,
  });
}

class NomineeEntity {
  final int id;
  final String name;
  final String dateOfBirth;
  final String relationship;
  final int allocationPercentage;

  NomineeEntity({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.relationship,
    required this.allocationPercentage,
  });
}

class AddressEntity {
  final int id;
  final String pincode;
  final String line1;
  final String line2;
  final String city;
  final String state;

  AddressEntity({
    required this.id,
    required this.pincode,
    required this.line1,
    required this.line2,
    required this.city,
    required this.state,
  });
}

class BankDetailEntity {
  final int id;
  final String accountHolderName;
  final String accountNumber;
  final String ifscCode;
  final String bankName;
  final bool isPrimary;

  BankDetailEntity({
    required this.id,
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
    required this.bankName,
    required this.isPrimary,
  });
}
