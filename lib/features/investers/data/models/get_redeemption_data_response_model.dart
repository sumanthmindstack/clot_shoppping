import '../../domain/entity/get_redeemption_data_entity.dart';

class GetRedeemptionDataResponseModel extends GetRedeemptionDataEntity {
  GetRedeemptionDataResponseModel({
    required super.status,
    required super.data,
    required super.meta,
  });

  factory GetRedeemptionDataResponseModel.fromJson(Map<String, dynamic> json) {
    return GetRedeemptionDataResponseModel(
      status: json['status'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => RedeemptionDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: MetaModel.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.map((e) => (e as RedeemptionDataModel).toJson()).toList(),
        'meta': (meta as MetaModel).toJson(),
      };
}

class RedeemptionDataModel extends RedeemptionDataEntity {
  RedeemptionDataModel({
    required super.id,
    super.fpId,
    super.oldId,
    super.mfInvestmentAccount,
    required super.folioNumber,
    required super.state,
    required super.amount,
    required super.scheme,
    super.redemptionMode,
    super.tradedOn,
    super.failedAt,
    super.plan,
    super.euin,
    super.partner,
    super.distributorId,
    super.units,
    super.redeemedPrice,
    super.redeemedUnits,
    super.redeemedAmount,
    super.redemptionBankAccountNumber,
    super.redemptionBankAccountIfscCode,
    super.scheduledOn,
    super.createdAt,
    super.confirmedAt,
    super.succeededAt,
    super.submittedAt,
    super.reversedAt,
    required super.gateway,
    required super.initiatedBy,
    super.initiatedVia,
    super.sourceRefId,
    required super.userIp,
    required super.serverIp,
    required super.userId,
    required super.transactionBasketItemId,
    super.failureCode,
    required super.updatedAt,
    required super.user,
    required super.fundName,
    required super.logoUrl,
  });

  factory RedeemptionDataModel.fromJson(Map<String, dynamic> json) {
    return RedeemptionDataModel(
      id: json['id'],
      fpId: json['fp_id'],
      oldId: json['old_id'],
      mfInvestmentAccount: json['mf_investment_account'],
      folioNumber: json['folio_number'] as String,
      state: json['state'] as String,
      amount: json['amount'] as String?,
      scheme: json['scheme'] as String,
      redemptionMode: json['redemption_mode'],
      tradedOn: json['traded_on'],
      failedAt: json['failed_at'],
      plan: json['plan'],
      euin: json['euin'],
      partner: json['partner'],
      distributorId: json['distributor_id'],
      units: json['units'],
      redeemedPrice: json['redeemed_price'],
      redeemedUnits: json['redeemed_units'],
      redeemedAmount: json['redeemed_amount'],
      redemptionBankAccountNumber: json['redemption_bank_account_number'],
      redemptionBankAccountIfscCode: json['redemption_bank_account_ifsc_code'],
      scheduledOn: json['scheduled_on'],
      createdAt: json['created_at'],
      confirmedAt: json['confirmed_at'],
      succeededAt: json['succeeded_at'],
      submittedAt: json['submitted_at'],
      reversedAt: json['reversed_at'],
      gateway: json['gateway'] as String,
      initiatedBy: json['initiated_by'] as String,
      initiatedVia: json['initiated_via'],
      sourceRefId: json['source_ref_id'],
      userIp: json['user_ip'] as String,
      serverIp: json['server_ip'] as String,
      userId: json['user_id'] as int,
      transactionBasketItemId: json['transaction_basket_item_id'] as int,
      failureCode: json['failure_code'],
      updatedAt: json['updated_at'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      fundName: json['fund_name'] as String,
      logoUrl: json['logo_url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fp_id': fpId,
        'old_id': oldId,
        'mf_investment_account': mfInvestmentAccount,
        'folio_number': folioNumber,
        'state': state,
        'amount': amount,
        'scheme': scheme,
        'redemption_mode': redemptionMode,
        'traded_on': tradedOn,
        'failed_at': failedAt,
        'plan': plan,
        'euin': euin,
        'partner': partner,
        'distributor_id': distributorId,
        'units': units,
        'redeemed_price': redeemedPrice,
        'redeemed_units': redeemedUnits,
        'redeemed_amount': redeemedAmount,
        'redemption_bank_account_number': redemptionBankAccountNumber,
        'redemption_bank_account_ifsc_code': redemptionBankAccountIfscCode,
        'scheduled_on': scheduledOn,
        'created_at': createdAt,
        'confirmed_at': confirmedAt,
        'succeeded_at': succeededAt,
        'submitted_at': submittedAt,
        'reversed_at': reversedAt,
        'gateway': gateway,
        'initiated_by': initiatedBy,
        'initiated_via': initiatedVia,
        'source_ref_id': sourceRefId,
        'user_ip': userIp,
        'server_ip': serverIp,
        'user_id': userId,
        'transaction_basket_item_id': transactionBasketItemId,
        'failure_code': failureCode,
        'updated_at': updatedAt,
        'user': user,
        'fund_name': fundName,
        'logo_url': logoUrl,
      };
}

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.mobile,
    required super.role,
    required super.isBulkUploaded,
    super.bulkUserFileId,
    super.password,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      role: json['role'] as String,
      isBulkUploaded: json['is_bulk_uploaded'] as bool,
      bulkUserFileId: json['bulk_user_file_id'],
      password: json['password'],
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'mobile': mobile,
        'role': role,
        'is_bulk_uploaded': isBulkUploaded,
        'bulk_user_file_id': bulkUserFileId,
        'password': password,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}

class MetaModel extends MetaEntity {
  MetaModel({
    required super.page,
    required super.limit,
    required super.total,
    required super.totalPages,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      page: json['page'] as String,
      limit: json['limit'] as String,
      total: json['total'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'limit': limit,
        'total': total,
        'totalPages': totalPages,
      };
}
