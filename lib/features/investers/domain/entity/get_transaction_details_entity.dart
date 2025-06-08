class GetTransactionDetailsEntity {
  final OrderDetailsEntity orderDetails;
  final List<FundDetailsEntity> fundDetails;

  GetTransactionDetailsEntity({
    required this.orderDetails,
    required this.fundDetails,
  });
}

class OrderDetailsEntity {
  final int id;
  final int transactionBasketId;
  final String transactionType;
  final String fundIsin;
  final String? folioNumber;
  final String frequency;
  final int? installmentDay;
  final int? numberOfInstallments;
  final num amount;
  final String? units;
  final String? euin;
  final String? partner;
  final String? toFundIsin;
  final String status;
  final String? responseMessage;
  final bool? isConsentVerified;
  final int userId;
  final num? stepUpAmount;
  final String? stepUpFrequency;
  final String? paymentMethod;
  final String? paymentSource;
  final String? fpSipId;
  final String? fpSwpId;
  final String? fpStpId;
  final bool isPayment;
  final String? startDate;
  final String? endDate;
  final String? nextInstallmentDate;
  final String? previousInstallmentDate;
  final int? remainingInstallments;
  final String? activatedAt;
  final String? cancelledAt;
  final String? completedAt;
  final String? failedAt;
  final bool isActive;
  final bool isBulk;
  final int? bulkTransactionFileId;
  final String? createdAt;
  final String? updatedAt;

  OrderDetailsEntity({
    required this.id,
    required this.transactionBasketId,
    required this.transactionType,
    required this.fundIsin,
    this.folioNumber,
    required this.frequency,
    this.installmentDay,
    this.numberOfInstallments,
    required this.amount,
    this.units,
    this.euin,
    this.partner,
    this.toFundIsin,
    required this.status,
    this.responseMessage,
    this.isConsentVerified,
    required this.userId,
    this.stepUpAmount,
    this.stepUpFrequency,
    this.paymentMethod,
    this.paymentSource,
    this.fpSipId,
    this.fpSwpId,
    this.fpStpId,
    required this.isPayment,
    this.startDate,
    this.endDate,
    this.nextInstallmentDate,
    this.previousInstallmentDate,
    this.remainingInstallments,
    this.activatedAt,
    this.cancelledAt,
    this.completedAt,
    this.failedAt,
    required this.isActive,
    required this.isBulk,
    this.bulkTransactionFileId,
    this.createdAt,
    this.updatedAt,
  });
}

class FundDetailsEntity {
  final int id;
  final int planId;
  final String rtaCode;
  final int variantFundId;
  final String riskGrade;
  final String returnGrade;
  final String basicName;
  final String shortName;
  final String planName;
  final String schemeName;
  final AmcEntity amc;
  final CategoryEntity category;
  final FundTypeEntity fundType;
  final int minInitialInvestment;
  final int minSubsequentSipInvestment;
  final String? issueOpen;
  final String? objectiveText;
  final String? navDate;
  final double? nav;

  FundDetailsEntity({
    required this.id,
    required this.planId,
    required this.rtaCode,
    required this.variantFundId,
    required this.riskGrade,
    required this.returnGrade,
    required this.basicName,
    required this.shortName,
    required this.planName,
    required this.schemeName,
    required this.amc,
    required this.category,
    required this.fundType,
    required this.minInitialInvestment,
    required this.minSubsequentSipInvestment,
    this.issueOpen,
    this.objectiveText,
    this.navDate,
    this.nav,
  });
}

class AmcEntity {
  final int id;
  final int amcId;
  final String amcFullName;
  final String logoUrl;
  final String ownerType;
  final String cio;
  final String investorsRelationsOfficer;
  final String amcShortName;
  final String ceo;
  final String managementTrustee;
  final String startDate;
  final String website;
  final String address1;
  final String address2;
  final String address3;
  final String city;
  final String pin;
  final String phone;
  final String fax;
  final String email;
  final String createdAt;
  final String updatedAt;
  final bool deleted;
  final bool excluded;

  AmcEntity({
    required this.id,
    required this.amcId,
    required this.amcFullName,
    required this.logoUrl,
    required this.ownerType,
    required this.cio,
    required this.investorsRelationsOfficer,
    required this.amcShortName,
    required this.ceo,
    required this.managementTrustee,
    required this.startDate,
    required this.website,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.city,
    required this.pin,
    required this.phone,
    required this.fax,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
    required this.excluded,
  });
}

class CategoryEntity {
  final String createdAt;
  final String updatedAt;
  final int id;
  final String primaryCategoryName;
  final String categoryName;
  final String categoryIcon;
  final bool active;
  final bool deleted;

  CategoryEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.primaryCategoryName,
    required this.categoryName,
    required this.categoryIcon,
    required this.active,
    required this.deleted,
  });
}

class FundTypeEntity {
  final int id;
  final String typeName;
  final String createdAt;
  final String updatedAt;
  final bool deleted;

  FundTypeEntity({
    required this.id,
    required this.typeName,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
  });
}
