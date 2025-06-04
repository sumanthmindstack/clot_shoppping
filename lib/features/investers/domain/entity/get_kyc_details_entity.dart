class GetKycDetailsEntity {
  final KycDetailsEntity data;

  GetKycDetailsEntity({required this.data});
}

class KycDetailsEntity {
  final int id;
  final int userId;
  final int userOnboardingDetailId;
  final dynamic signzyKycObjectId;
  final bool isKycComplete;
  final int pan;
  final int fullName;
  final int dateOfBirth;
  final int fatherName;
  final int motherName;
  final int nominee;
  final int maritalStatus;
  final int gender;
  final int occupation;
  final int annualIncome;
  final int nationality;
  final int bankAccountDetails;
  final int selfPhoto;
  final int panUpload;
  final int poaAadhaarDigilocker;
  final int addressDetails;
  final int signatureUpload;
  final int aadhaarEsign;
  final int signzyPoiPoaLinkGenerated;
  final int signzyPoiPoaUpdated;
  final int signzyBankUpdated;
  final int signzyKycDataUpdated;
  final int signzyFatcaUpdated;
  final int signzyForensicsUpdated;
  final int signzySignatureUpdated;
  final int signzyPhotoUpdated;
  final int signzyGeneratePdf;
  final int signzyGenerateAadharEsignUrl;
  final int signzySaveAadharEsign;
  final String status;
  final String createdAt;
  final String updatedAt;

  KycDetailsEntity({
    required this.id,
    required this.userId,
    required this.userOnboardingDetailId,
    required this.signzyKycObjectId,
    required this.isKycComplete,
    required this.pan,
    required this.fullName,
    required this.dateOfBirth,
    required this.fatherName,
    required this.motherName,
    required this.nominee,
    required this.maritalStatus,
    required this.gender,
    required this.occupation,
    required this.annualIncome,
    required this.nationality,
    required this.bankAccountDetails,
    required this.selfPhoto,
    required this.panUpload,
    required this.poaAadhaarDigilocker,
    required this.addressDetails,
    required this.signatureUpload,
    required this.aadhaarEsign,
    required this.signzyPoiPoaLinkGenerated,
    required this.signzyPoiPoaUpdated,
    required this.signzyBankUpdated,
    required this.signzyKycDataUpdated,
    required this.signzyFatcaUpdated,
    required this.signzyForensicsUpdated,
    required this.signzySignatureUpdated,
    required this.signzyPhotoUpdated,
    required this.signzyGeneratePdf,
    required this.signzyGenerateAadharEsignUrl,
    required this.signzySaveAadharEsign,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
