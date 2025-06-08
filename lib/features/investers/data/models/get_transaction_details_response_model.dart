import '../../domain/entity/get_transaction_details_entity.dart';

class GetTransactionDetailsResponseModel extends GetTransactionDetailsEntity {
  GetTransactionDetailsResponseModel({
    required super.orderDetails,
    required super.fundDetails,
  });

  factory GetTransactionDetailsResponseModel.fromJson(
      Map<String, dynamic> json) {
    return GetTransactionDetailsResponseModel(
      orderDetails: OrderDetailsModel.fromJson(json['order_details']),
      fundDetails: (json['fund_details'] as List<dynamic>?)
              ?.map((e) => FundDetailsModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'order_details': (orderDetails as OrderDetailsModel).toJson(),
        'fund_details':
            fundDetails.map((e) => (e as FundDetailsModel).toJson()).toList(),
      };
}

class OrderDetailsModel extends OrderDetailsEntity {
  OrderDetailsModel({
    required super.id,
    required super.transactionBasketId,
    required super.transactionType,
    required super.fundIsin,
    super.folioNumber,
    required super.frequency,
    super.installmentDay,
    super.numberOfInstallments,
    required super.amount,
    super.units,
    super.euin,
    super.partner,
    super.toFundIsin,
    required super.status,
    super.responseMessage,
    super.isConsentVerified,
    required super.userId,
    super.stepUpAmount,
    super.stepUpFrequency,
    super.paymentMethod,
    super.paymentSource,
    super.fpSipId,
    super.fpSwpId,
    super.fpStpId,
    required super.isPayment,
    super.startDate,
    super.endDate,
    super.nextInstallmentDate,
    super.previousInstallmentDate,
    super.remainingInstallments,
    super.activatedAt,
    super.cancelledAt,
    super.completedAt,
    super.failedAt,
    required super.isActive,
    required super.isBulk,
    super.bulkTransactionFileId,
    super.createdAt,
    super.updatedAt,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json['id'],
      transactionBasketId: json['transaction_basket_id'],
      transactionType: json['transaction_type'],
      fundIsin: json['fund_isin'],
      folioNumber: json['folio_number'],
      frequency: json['frequency'] ?? "",
      installmentDay: json['installment_day'],
      numberOfInstallments: json['number_of_installments'],
      amount: (json['amount'] as num).toDouble(),
      units: json['units'],
      euin: json['euin'],
      partner: json['partner'],
      toFundIsin: json['to_fund_isin'],
      status: json['status'],
      responseMessage: json['response_message'],
      isConsentVerified: json['is_consent_verified'],
      userId: json['user_id'],
      stepUpAmount: json['step_up_amount'],
      stepUpFrequency: json['step_up_frequency'],
      paymentMethod: json['payment_method'],
      paymentSource: json['payment_source'],
      fpSipId: json['fp_sip_id'],
      fpSwpId: json['fp_swp_id'],
      fpStpId: json['fp_stp_id'],
      isPayment: json['is_payment'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      nextInstallmentDate: json['next_installment_date'],
      previousInstallmentDate: json['previous_installment_date'],
      remainingInstallments: json['remaining_installments'],
      activatedAt: json['activated_at'],
      cancelledAt: json['cancelled_at'],
      completedAt: json['completed_at'],
      failedAt: json['failed_at'],
      isActive: json['is_active'],
      isBulk: json['is_bulk'],
      bulkTransactionFileId: json['bulk_transaction_file_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'transaction_basket_id': transactionBasketId,
        'transaction_type': transactionType,
        'fund_isin': fundIsin,
        'folio_number': folioNumber,
        'frequency': frequency,
        'installment_day': installmentDay,
        'number_of_installments': numberOfInstallments,
        'amount': amount,
        'units': units,
        'euin': euin,
        'partner': partner,
        'to_fund_isin': toFundIsin,
        'status': status,
        'response_message': responseMessage,
        'is_consent_verified': isConsentVerified,
        'user_id': userId,
        'step_up_amount': stepUpAmount,
        'step_up_frequency': stepUpFrequency,
        'payment_method': paymentMethod,
        'payment_source': paymentSource,
        'fp_sip_id': fpSipId,
        'fp_swp_id': fpSwpId,
        'fp_stp_id': fpStpId,
        'is_payment': isPayment,
        'start_date': startDate,
        'end_date': endDate,
        'next_installment_date': nextInstallmentDate,
        'previous_installment_date': previousInstallmentDate,
        'remaining_installments': remainingInstallments,
        'activated_at': activatedAt,
        'cancelled_at': cancelledAt,
        'completed_at': completedAt,
        'failed_at': failedAt,
        'is_active': isActive,
        'is_bulk': isBulk,
        'bulk_transaction_file_id': bulkTransactionFileId,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

class FundDetailsModel extends FundDetailsEntity {
  FundDetailsModel({
    required super.id,
    required super.planId,
    required super.rtaCode,
    required super.variantFundId,
    required super.riskGrade,
    required super.returnGrade,
    required super.basicName,
    required super.shortName,
    required super.planName,
    required super.schemeName,
    required super.amc,
    required super.category,
    required super.fundType,
    required super.minInitialInvestment,
    required super.minSubsequentSipInvestment,
    super.issueOpen,
    super.objectiveText,
    super.navDate,
    super.nav,
  });

  factory FundDetailsModel.fromJson(Map<String, dynamic> json) {
    return FundDetailsModel(
      id: json['id'],
      planId: json['planId'],
      rtaCode: json['rtaCode'],
      variantFundId: json['variantFundId'],
      riskGrade: json['riskGrade'],
      returnGrade: json['returnGrade'],
      basicName: json['basicName'],
      shortName: json['shortName'],
      planName: json['planName'],
      schemeName: json['schemeName'],
      amc: AMCModel.fromJson(json['amc']),
      category: FundCategoryModel.fromJson(json['category']),
      fundType: FundTypeModel.fromJson(json['fundType']),
      minInitialInvestment: json['minInitialInvestment'],
      minSubsequentSipInvestment: json['minSubsequentSipInvestment'],
      issueOpen: json['issueOpen'],
      objectiveText: json['objectiveText'],
      navDate: json['navDate'],
      nav: (json['nav'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'planId': planId,
        'rtaCode': rtaCode,
        'variantFundId': variantFundId,
        'riskGrade': riskGrade,
        'returnGrade': returnGrade,
        'basicName': basicName,
        'shortName': shortName,
        'planName': planName,
        'schemeName': schemeName,
        'amc': (amc as AMCModel).toJson(),
        'category': (category as FundCategoryModel).toJson(),
        'fundType': (fundType as FundTypeModel).toJson(),
        'minInitialInvestment': minInitialInvestment,
        'minSubsequentSipInvestment': minSubsequentSipInvestment,
        'issueOpen': issueOpen,
        'objectiveText': objectiveText,
        'navDate': navDate,
        'nav': nav,
      };
}

class AMCModel extends AmcEntity {
  AMCModel({
    required super.id,
    required super.amcId,
    required super.amcFullName,
    required super.logoUrl,
    required super.ownerType,
    required super.cio,
    required super.investorsRelationsOfficer,
    required super.amcShortName,
    required super.ceo,
    required super.managementTrustee,
    required super.startDate,
    required super.website,
    required super.address1,
    required super.address2,
    required super.address3,
    required super.city,
    required super.pin,
    required super.phone,
    required super.fax,
    required super.email,
    required super.createdAt,
    required super.updatedAt,
    required super.deleted,
    required super.excluded,
  });

  factory AMCModel.fromJson(Map<String, dynamic> json) {
    return AMCModel(
      id: json['id'],
      amcId: json['amcId'],
      amcFullName: json['amcFullName'],
      logoUrl: json['logoUrl'],
      ownerType: json['ownerType'],
      cio: json['cio'],
      investorsRelationsOfficer: json['investorsRelationsOfficer'],
      amcShortName: json['amcShortName'],
      ceo: json['ceo'],
      managementTrustee: json['managementTrustee'],
      startDate: json['startDate'],
      website: json['website'],
      address1: json['address1'],
      address2: json['address2'],
      address3: json['address3'],
      city: json['city'],
      pin: json['pin'],
      phone: json['phone'],
      fax: json['fax'],
      email: json['email'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deleted: json['deleted'],
      excluded: json['excluded'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amcId': amcId,
        'amcFullName': amcFullName,
        'logoUrl': logoUrl,
        'ownerType': ownerType,
        'cio': cio,
        'investorsRelationsOfficer': investorsRelationsOfficer,
        'amcShortName': amcShortName,
        'ceo': ceo,
        'managementTrustee': managementTrustee,
        'startDate': startDate,
        'website': website,
        'address1': address1,
        'address2': address2,
        'address3': address3,
        'city': city,
        'pin': pin,
        'phone': phone,
        'fax': fax,
        'email': email,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deleted': deleted,
        'excluded': excluded,
      };
}

class FundCategoryModel extends CategoryEntity {
  FundCategoryModel({
    required super.createdAt,
    required super.updatedAt,
    required super.id,
    required super.primaryCategoryName,
    required super.categoryName,
    required super.categoryIcon,
    required super.active,
    required super.deleted,
  });

  factory FundCategoryModel.fromJson(Map<String, dynamic> json) {
    return FundCategoryModel(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      id: json['id'],
      primaryCategoryName: json['primaryCategoryName'],
      categoryName: json['categoryName'],
      categoryIcon: json['categoryIcon'],
      active: json['active'],
      deleted: json['deleted'],
    );
  }

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'id': id,
        'primaryCategoryName': primaryCategoryName,
        'categoryName': categoryName,
        'categoryIcon': categoryIcon,
        'active': active,
        'deleted': deleted,
      };
}

class FundTypeModel extends FundTypeEntity {
  FundTypeModel({
    required super.id,
    required super.typeName,
    required super.createdAt,
    required super.updatedAt,
    required super.deleted,
  });

  factory FundTypeModel.fromJson(Map<String, dynamic> json) {
    return FundTypeModel(
      id: json['id'],
      typeName: json['typeName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deleted: json['deleted'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'typeName': typeName,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deleted': deleted,
      };
}
